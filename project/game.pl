
open $log, ">", "latest.log";

sub out( $ ) {
	print "$_[0]\n";
	print $log "STDOUT: $_[0]\n";
}
sub err( $ ) {
	print STDERR "$_[0]\n";
	print $log "STDERR: $_[0]\n";
}


$SIG{INT} = sub {
	err "INT!!!!!";
	exit;
};
$SIG{HUP} = sub {
	err "HUP!!!!!";
	exit;
};
$SIG{PIPE} = sub {
	err "PIPE!!!!!";
	exit;
};
$SIG{TERM} = sub {
	err "TERM!!!!!";
	exit;
};

out "START!";

while ($a = <>) {
	chomp $a;
	if ($a eq "stop") {
		out "STOP!";
		exit;
	}
	out "{$a}";
	err "Error!" if rand() < 0.2;
}

out "EOF!";
