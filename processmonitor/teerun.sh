cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
eval $(cat config.sh)

# init
bash init.sh || exit 1

# make command input
exec {in}< <(cat $pipe2_file)

# make command output
exec {out}> $pipe2_file

# read from pipe
tail -f $pipe1_file >&${out} &

# read from stdin
echo <(cat >&${out}; echo "$0: Stdin closed!" >&2) > /dev/null

# run game
bash run.sh <&$in

# terminate
for pid in $(bash processtree.sh $$)
do
	kill $pid
	wait $pid 2> /dev/null
done
