##########################################################
###################### MAKE TEST #########################
### All files in this repositroy are public domain cc0 ###
### Any files created by the test are subject to the   ###
### license specified in that reposityor.              ###
##########################################################

all:
	@./extract-full-data.sh
	@./data-test 1

quick:
	@./data-test

clean:
	@rm -rf diff/* support/* tests/* data/full-test/*
	@rm -rf diff commands support tests
	@sed -i "s|https://github.com/.*/.*/blob/main/index.html|https://github.com/CHANGE_USER/CHANGE_REPO/blob/main/index.html|" README.md	