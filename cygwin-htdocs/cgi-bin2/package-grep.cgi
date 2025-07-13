#! /bin/bash

############################## reduce self priority

# ionice -c 3 -p $$ >/dev/null 2>&1     # IDLE
ionice -c 2 -n 7 -p $$ >/dev/null 2>&1  # lowest priority best-effort
renice -n 19 -p $$ >/dev/null 2>&1

############################## decode parameters

urldecode() {
    # urldecode <string>, <text>
    local url_encoded="${1}"
    if [ -z $2 ] ; then
        url_encoded="${1//+/ }"
    fi
    printf '%b' "${url_encoded//%/\\x}"
}

htmlencode() {
    echo "$1" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g'
}

urlencode() {
# urlencode <string>
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
	local c="${1:i:1}"
	case $c in
	    [a-zA-Z0-9.~_-]) printf "$c" ;;
	    *) printf '%%%02X' "'$c"
	esac
    done
}



# defaults
param_grep=
param_text=
param_arch=x86_64

if [ "$QUERY_STRING" = "" ]; then
    QUERY_STRING="&grep="
fi

if [ "$REQUEST_METHOD" = "GET" ]; then
    OIFS="$IFS"
    IFS="&"
    set $QUERY_STRING
    IFS="$OIFS"

    for i in $*; do
	key=`echo "$i" | cut -f1 -d=`
	value=`echo "$i" | cut -f2- -d=`
	case "$key" in
	    grep)  param_grep=`urldecode "$value" "$param_text"` ;;
	    text)  param_text=`urldecode "$value"` ;;
	    arch)  param_arch=`urldecode "$value"` ;;
	    *)     param_ignored=`urldecode "$value"` ;;
	esac
    done
fi

param_grep_htmlencode=`htmlencode "$param_grep"`

############################## reject unsupported arch values

if [ "$param_arch" = "x86" ]; then
    echo "Content-Type: text/plain; charset=utf-8"
    echo "Status: 410 Gone"
    echo
    echo "x86 package search is no longer available."
    exit
fi

# silently ignores unknown arch values
param_arch=x86_64
dir=x86_64

############################## print headerstuff

if [ -n "$param_text" ]; then
    echo "Content-Type: text/plain; charset=utf-8"
    echo
else
    echo "Content-Type: text/html"
    echo
    echo '
<!DOCTYPE html>
<html lang="en-US">
<head>
<title>Cygwin Package Search</title>
<link rel="stylesheet" type="text/css" href="../style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head><body>'
    cat ../navbar.html
    echo '<div id="main">'
    cat ../top.html
    echo '<h1>Cygwin Package Search</h1>
<form method="get" action="//cygwin.com/cgi-bin2/package-grep.cgi">
<p>
Search package contents for a
<a href="https://www.gnu.org/software/grep/manual/grep.html">grep</a>
<a href="https://www.gnu.org/software/grep/manual/grep.html#Basic-vs-Extended">basic</a>
<a href="https://en.wikipedia.org/wiki/Regular_expression">regular expression</a>
pattern
</p>
<p>
<input type="text" size="40" name="grep" value="'$param_grep_htmlencode'"/>
<input type="submit" value="Go"/>
</p>
</form>'
fi



############################## do the search

# We don't emulate the perlre /m modifier.

tmpfile=`mktemp`
trap 'rm -f $tmpfile' 0 1 2 3 4 5 9 15
if [ -n "$param_grep" ]; then
    find ../packages/{$dir,noarch,src} -mindepth 2 -maxdepth 2 -not -name '.*' -prune  | xargs -L1000 -P16 env LC_ALL=C grep --line-buffered -l -- "$param_grep" | sort > "$tmpfile"
    # 1000 is less than 1/16th of the number of $dir/*/* files
else
    touch "$tmpfile"
fi


############################## report


if [ -z "$param_text" ]; then
    if [ -n "$param_grep" ]; then
      echo '<h1>Search Results</h1>&nbsp;Found <b>'`wc -l < "$tmpfile"`'</b>'
      echo ' matches for <b>'$param_grep_htmlencode'</b><br/><br/>'
    fi
    echo '<ul class="compact">'
else
    echo 'Found '`wc -l < "$tmpfile"`' matches for '$param_grep
fi

cat "$tmpfile" | while read fullfile; do
    file=`echo $fullfile | cut -f5 -d/` # subtract ../packages/$ARCH/DIR/
    partfile=`echo $fullfile | cut -f3- -d/` # subtract only ../packages/

    basedesc=`fgrep '<h1>' "$fullfile" | sed -e 's/<[^>]*>//g' `
    desc="$basedesc"

    if [ -z "$param_text" ]; then
	echo '<li><a href="package-cat.cgi?file='`urlencode $partfile`'&amp;grep='`urlencode $param_grep`'">'$file'</a> - '$desc'</li>'
    else
	echo "$file - $desc"
    fi
done


############################## footer

if [ -z "$param_text" ]; then
    echo '</ul></div></body></html>'
else
    true
fi
