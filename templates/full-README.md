# CHANGE_COMMAND_TEST Test - Selective Files Test Result

Ctrl + click [test results](https://jhauga.github.io/htmlpreview.github.com/?https://github.com/CHANGE_USER/CHANGE_REPO/blob/main/index.html).

The repos used for the test were selected as they had several dozen (*hundred*) files that could be converted with CHANGE_COMMAND_TEST.
Expand below to show test repos and what file extensions were used: 
<details>
 <summary>Show Files Tested</summary>
  
CHANGE_FILE_LIST
   
</details>

## Extract Data Procedure - Condensed:
1. Set configuration and ready data to be extracted.
2. Determine, then clone repositories from configuration.
3. Extract files matching configured extensions in ` config-variables.sh ` to data/full-test directory.
4. Prompt to confirm then run function to extract data.

## Test Procedure - Condensed:
1. Set configuration and ready test elements.
2. Pending on configuration Either:
   - Clone source (*CHANGE_SOURCE_USER*) and pull (*CHANGE_USER*) CHANGE_COMMAND_TEST repo.
   - Copied and used local version of CHANGE_SOURCE_USER CHANGE_COMMAND_TEST tool and CHANGE_USER CHANGE_COMMAND_TEST
3. Start test function configuring function for source or pull.
4. Set a start and end time for each build with CHANGE_COMMAND_TEST, pushing start and end to two separate arrays.
5. In ` run_command() ` sub-function call CHANGE_COMMAND_TEST first utilizing prior configurations to build using source or pull CHANGE_COMMAND_TEST and calculate build time(s).
   - Additional marker here cause this is where CHANGE_COMMAND_TEST is called and timed.
6. Determine difference after all files built second in `runc_command() sub-function.
7. Call ` run_command() ` sub-function.
8. Determine if there is a difference, checking empty files and count number of differences.
9. Call ` run_test() ` function with source or pull, reconfigure and call ` run_test() ` again.
10. Make support html elements for difference output and dropdown menus.
11. Compare total fies built to files with differences, outputting results to supporting text file.
12. Calculate stats for build times, outputting results to supporting text file.
13. Make remaining support html elements and clean files and directories.
