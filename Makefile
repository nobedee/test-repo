##########################################################
###################### MAKE TEST #########################
### All files in this repositroy are public domain cc0 ###
### Any files created by the test are subject to the   ###
### license specified in that reposityor.              ###
##########################################################
.PHONY: check-mac

check-mac:
	@if [ -e MAC-ME ]; then \
		./MAC-ME; \
		mv MAC-ME .MAC-ME; \
	fi

all: check-mac
	@./extract-full-data.sh
	@./data-test 1

quick: check-mac
	@./data-test
	
# Ready made test. See "Ready Made Tests" in README.md
roffit: ask.clone check-mac
	@if [ ! -d "reset" ]; then \
		mkdir reset; \
		cp -f config-variables.sh reset/config-variables.sh; \
	fi
	@./data/ready/config-prompt.sh "roffit"

# Ask if cloning from GithHub.
ask.clone:
	@echo Are commands tested cloned from GitHub \[Y \| n\]?
	@./data/ready/askClone.sh

# Reset test but keep current config.
retest:
	@rm -rf diff/* support/* tests/* data/full-test/*
	@sed -i "s|https://github.com/.*/.*/blob/main/index.html|https://github.com/CHANGE_USER/CHANGE_REPO/blob/main/index.html|" README.md
	@sed -i "s|var cur_test_results = \"https://github.com/.*/.*/blob/main/\";|var cur_test_results = \"https://github.com/CHANGE_USER/CHANGE_REPO/blob/main/\";|" scripts.js
	@if [ -e list-gen.txt ]; then \
		rm list-gen.txt; \
	fi
	@if [ -e list-unq.txt ]; then \
		rm list-unq.txt; \
	fi

# Completely clean as if starting from scratch, but keep some configurations.
clean:
	@rm -rf diff/* support/* tests/* data/full-test/*
	@if [ -e ".localCommandUsed" ]; then \
		rm -rf diff support tests; \
	else \
		rm -rf diff commands support tests; \
	fi
	@sed -i "s|https://github.com/.*/.*/blob/main/index.html|https://github.com/CHANGE_USER/CHANGE_REPO/blob/main/index.html|" README.md
	@sed -i "s|var cur_test_results = \"https://github.com/.*/.*/blob/main/\";|var cur_test_results = \"https://github.com/CHANGE_USER/CHANGE_REPO/blob/main/\";|" scripts.js
	@if [ -d "reset" ]; then \
		echo Resetting to initial config.; \
		mv reset/config-variables.sh ./config-variables.sh; \
		rm -rf reset data/quick-test/gen/* data/quick-test/unq/*; \
		echo General files. > data/quick-test/gen/General.txt && echo Unique files. > data/quick-test/unq/Unique.txt; \
		sed -i "s|_readyCommand=.*|_readyCommand=CHANGE_READY_COMMAND|" data/ready/ready-source.sh; \
		sed -i "s|_confirmUserName=.*|_confirmUserName=CHANGE_USER_NAME|" data/ready/ready-source.sh; \
	fi
	@if [ -e data/ready/.noGitHubClone ]; then \
		rm data/ready/.noGitHubClone; \
	fi
	@if [ -e .localCommandUsed ]; then \
		rm .localCommandUsed; \
	else \
		rm -rf commands; \
	fi
	@if [ -e list-gen.txt ]; then \
		rm list-gen.txt; \
	fi
	@if [ -e list-unq.txt ]; then \
		rm list-unq.txt; \
	fi

# Remove all and re-clone
reinstall:
	@rm -rf *
	@git clone https://github.com/jhauga/data-conversion-test.git .tempClone/
	@cp -r .tempClone/* .
	@rm -rf .tempClone