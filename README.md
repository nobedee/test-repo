# Template to test pull to data-conversion tool

This can be used to make tests for/before making pull requests to
a data conversion tool repository. Download zip or clone the repo
locally. Edit the "config-variables.sh" file to run test.
<br>
It is recommended that you at least have an intermediate knowledge of
the following before using this repository to build your test:
 1. bash scripting
 2. Makefile
 3. Data conversion tool being tested

<strong>IMPORTANT</strong>:<br>
This is not specific to any current repositroy. The current 
"config-variables.sh" contents is for example purposes. So it 
is important that you edit the "config-variables.sh" file 
before running test.

<strong>IMPORTANT</strong>: <br>
There are no safe guards if you ```make full``` test and use repos with
large amounts of data so be mindful of possible build sizes for test.

### View resulte
1. If final test repo is uploaded to Github:
  - To see outputs from test [click here](https://jhauga.github.io/htmlpreview.github.com/?https://github.com/CHANGE_USER/CHANGE_REPO/blob/main/index.html).
2. If final test remains local use method for localhost:
  - For example - ```php -S localhost:8000```

### Instructions

1. Make repo based on this template repo.
2. Change variables in "config-variables.sh"
3. Run either:
   a. make quick
   b. make all
4. Clean, make result repo, or leave test contents:
   a. Clean:
      - make clean
   b. Make result Repo:
      - make results