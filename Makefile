##########################################################
###################### MAKE TEST #########################
### All files in this repositroy are public domain cc0 ###
### Any files created by the test are subject to the   ###
### license specified in that reposityor.              ###
##########################################################

all:
	@./extract-full-data.sh
	@./roffit-test 1

quick:
	@./roffit-test

clean:
	@rm -rf diff/* support/* tests/* data/full-test/*
	@rm -rf diff commands support tests