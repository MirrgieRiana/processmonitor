cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
eval $(cat config.sh)

# init
bash init.sh || exit 1

exec {lock}> $lock_file
flock -w 0 $lock
if [ $? -eq 0 ]; then
	# down
	echo false
	exit 1
else
	# up
	echo true
	exit 0
fi
