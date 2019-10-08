cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
eval $(cat config.sh)

# backup dir
(
	if [ ! -d "$backup_dir" ]; then
		mkdir -p "$backup_dir" || exit $?
	fi
) || exit $?

# timestamp
timestamp="$(date -u -d '9 hour' +'%Y%m%d%H%M%S')"

# archive name
archive="$(cd "$backup_dir"; echo "$(pwd)/${backup_base_name}_${timestamp}.zip")"
echo "Archive='$archive'"

# inclusions
inclusions="."
echo "Inclusions='$inclusions'"

# exclusions
echo "Exclusions=$backup_exclusions"

command=zip
command="${command} -y"
command="${command} -r '$archive'"
command="${command} '$inclusions'"
command="${command} $(perl -e '$ARGV[0] =~ /\A\s*\Z/ ? print "" : print "-x $ARGV[0]"' "$backup_exclusions")"
echo "Command=$command"

# execute
(cd "$project_dir"; eval $command)
echo "Finished!"
