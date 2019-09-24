
this=$$

function children(){
	local ppid=$1;
	for pid in $(pgrep -P $ppid | grep -v '^'$this'$')
	do
		echo $pid
		children $pid
	done
}

children $1
