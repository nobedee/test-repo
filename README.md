# Template to test pull to data-conversion tool

Ctrl + click [test results](https://jhauga.github.io/htmlpreview.github.com/?https://github.com/CHANGE_USER/CHANGE_REPO/blob/main/index.html).

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

## INSTRUCTIONS
### Local Test Instructions
1. Make repo based on this template repo.
2. Either
   - Upload test files that will be converted to data/quick-test directories.
      - gen - general files tested
      - unq - any unique or focus files tested
   - Use a ready made config for a command previously tested. Use pre-config below:
      - `` make roffit ``
      - `` make asciidoctor ``
3. Read and agree to terms in USAGE_AGREEMENT.md. Either:
   - ``` cat USAGE_AGREEMENT.md ```
   - Click [link to file](https://github.com/jhauga/data-conversion-tool/blob/master/USAGE_AGREEMENT.md)
4. Change variables in "config-variables.sh".
   - See commented instructions in the file.
   - **IMPORTANT** - the function `` _commandSyntax `` uses variables defined in main script that are passed as arguments to function. Use the pre-configurred examples in the function as a guide to to arrange the syntax for the test.
   - **IMPORTANT** - if more than three elements are needed to run the command for test, then edit the main script file "data-test".
5. Ensure necessary dependencies are installed for test.
6. Run either:
   - `` make quick ``
   - `` make full ``
7. Run a local host and open in browser to view test results.
8. Additionally to clean to reset repo:   
   - `` make clean ``
   - `` make retest ``
      
### Codespace Test Instruction
1. Make repo based on this template repo.
2. Either
   - Upload test files that will be converted to data/quick-test directories.
      - gen - general files tested
      - unq - any unique or focus files tested
   - Use a ready made config for a command previously tested. Use pre-config below:
      - `` make roffit ``
      - `` make asciidoctor ``
 3. After naming new repo open it in codespace.
 4. Read and agree to terms in USAGE_AGREEMENT.md. Either:
    - ``` cat USAGE_AGREEMENT.md ```
    - Click [link to file](https://github.com/jhauga/data-conversion-tool/blob/master/USAGE_AGREEMENT.md)
 5. Change variables in "config-variables.sh".
    - See commented instructions in the file.
    - **IMPORTANT** - the function `` _commandSyntax `` uses variables defined in main script that are passed as arguments to function. Use the pre-configurred examples in the function as a guide to to arrange the syntax for the test.
    - **IMPORTANT** - if more than three elements are needed to run the command for test, then edit the main script file "data-test".
 6. Install necessary dependencies
 7. Copy paste below line:
    - `` chmod a+x Makefile agree config-variables.sh data-test extract-full-data.sh server.js ``
 8. Run either:
    - `` make quick ``
    - `` make full ``
 9. Run server with:
    - `` node server.js ``
    - Or use Github pages environment
 10. Create a new repo by:
    - `` CHANGE `` 
 11. Additionally to clean to reset repo:   
    - `` make clean ``
    - `` make retest ``

### View resulte
1. If final test repo is uploaded to Github:
   - To see outputs from test there will be a link generated and included at the top of the new README.md file.
2. If final test remains local use method for localhost:
   - For example - ```php -S localhost:8000```

### Additional Notes
  - Once the test has completed a new README.md file will be genereated, which gives a brief overview of the test procedure.
  - The README.md that was used in the original template repository will be copied to INSTRUCTIONS.md
