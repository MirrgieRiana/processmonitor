cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
eval $(cat config.sh)

# init
bash init.sh || exit 1

# stdin -> pipe1
echo <(

	while true
	do
		if read -r line; then
			echo $line > $pipe1_file
		else
			break
		fi
	done

	echo "$0: Stdin closed!" >&2

) > /dev/null

# run monitor
(cd "$project_dir"; tail -F "$log_file")

# terminate
for pid in $(bash processtree.sh $$)
do
	kill $pid
	wait $pid 2> /dev/null
done
