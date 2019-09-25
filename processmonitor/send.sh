cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
eval $(cat config.sh)

# init
bash init.sh || exit 1

echo "$*" > $pipe1_file
