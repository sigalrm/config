#!/usr/bin/perl

use warnings;
use strict;

my @files = glob("*.[ch]");

print "digraph G {\n";

foreach my $file (@files) {
    open FH, '<', $file or die "Failed to open '$file': $!\n";

    while (<FH>) {
	if (/^#include "(.*?)"/) {
	    print "\"$file\" -> \"$1\"\n";
	}
    }

    close FH;
}

print "}\n";
