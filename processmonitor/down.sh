cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
eval $(cat config.sh)

# init
bash init.sh || exit 1

if bash isup.sh > /dev/null; then
	bash send.sh "$stop_operator"
	echo "Sent stop operation"
	while bash isup.sh > /dev/null
	do
		sleep 0.5
	done
	echo "Stopped"
else
	echo "$0: Not running" >&2
fi
