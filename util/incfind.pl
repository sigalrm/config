#!/usr/bin/perl

use warnings;
use strict;

die "Usage: $0 <searchterm>\n" if @ARGV != 1;
my $searchstr = shift @ARGV;

chdir "/usr/include" or die "Failed to change directory: $!\n";

my $cmd = "grep -RIlw $searchstr . | sort | uniq";

open(FH, '-|', $cmd) or die "Failed to pipe command: $!\n";
my @lines = <FH>;
close(FH);

if (@lines == 1) {
	$cmd = "vim +/$searchstr $lines[0]";
}
else {
	$cmd = "grep -RIHnw $searchstr . | less";
}

exec($cmd);
die "Failed to exec command: $!\n";
