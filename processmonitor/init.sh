cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
eval $(cat config.sh)

# make pipe if do not exist
if [ ! -p $pipe1_file ]; then
	if [ ! $(mkfifo $pipe1_file; echo $?) -eq "0" ]; then
		exit 1
	fi
fi
if [ ! -p $pipe2_file ]; then
	if [ ! $(mkfifo $pipe2_file; echo $?) -eq "0" ]; then
		exit 1
	fi
fi

# make lock if do not exist
if [ ! -f $lock_file ]; then
	if [ ! $(touch $lock_file; echo $?) -eq "0" ]; then
		exit 1
	fi
fi
