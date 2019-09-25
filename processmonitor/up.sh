cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
eval $(cat config.sh)

# init
bash init.sh || exit 1

exec {lock}> $lock_file
flock -w 0 $lock || {
	echo "$0: Already running" 1>&2
	exit 1
}

nohup bash teerun.sh > /dev/null 2>&1 &
