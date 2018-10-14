#!/usr/bin/perl

use warnings;
use strict;

use constant W => 9;
use constant H => 9;
use constant X => 3;
use constant Y => 3;

my @a;
my @sets;
my $iteration;

sub read_input {
    my ($x, $y);
    my $line;
    my @l;

    for ($y = 0; $y < H; $y++) {
	chomp($line = <STDIN>);
	@l = split(//, $line);
	next unless @l > 0;

	for ($x = 0; $x < W; $x++) {
	    if ($l[$x] eq '.') {
		$a[$x][$y] = [ 1 .. (X*Y) ];
	    } else {
		$a[$x][$y] = [ 0 + $l[$x] ];
	    }
	}
    }
}

sub setup_sets {
    my ($x, $y, $i, $j);
    my $list;

    # Rows
    for ($y = 0; $y < H; $y++) {
	$list = [];
	for ($x = 0; $x < W; $x++) {
	    push @$list, $a[$x][$y];
	}
	push @sets, $list;
    }

    # Columns
    for ($x = 0; $x < W; $x++) {	
	$list = [];
	for ($y = 0; $y < H; $y++) {
	    push @$list, $a[$x][$y];
	}
	push @sets, $list;
    }

    # Cells
    for ($x = 0; $x < W; $x += X) {
	for ($y = 0; $y < H; $y += Y) {
	    $list = [];
	    for ($i = $x; $i < $x + X; $i++) {
		for ($j = $y; $j < $y + Y; $j++) {
		    push @$list, $a[$i][$j];
		}
	    }
	    push @sets, $list;
	}
    }
}

sub is_solved {
    my ($x, $y);

    for ($x = 0; $x < W; $x++) {
	for ($y = 0; $y < H; $y++) {
	    return 0 if @{$a[$x][$y]} > 1;
	}
    }

    return 1;
}

sub remove_from_list {
    my ($number, $list) = @_;
    my ($i, $n, $x);

    $n = @$list;
    for ($i = 0; $i < $n; $i++) {
	$x = shift @$list;
	push @$list, $x if $x != $number;
    }
}

sub set_list_to {
    my ($number, $list) = @_;
    my ($i, $n);

    $n = @$list;
    for ($i = 0; $i < $n; $i++) {
	pop @$list;
    }
    push @$list, $number;
}

sub solve_list_with_number {
    my ($number, $set) = @_;

    for (@$set) {
	next if @$_ == 1;
	if (grep($_ == $number, @$_)) {
	    set_list_to($number, $_);
	}
    }
}

sub check_set {
    my ($set) = @_;
    my $n;
    my @solved;
    my %hash;

    # Get the set of numbers that are solved
    for (@$set) {
	push @solved, $$_[0] if @$_ == 1;
    }

    # Remove solved numbers from unsolved sets
    for (@$set) {
	next if @$_ == 1;
	foreach $n (@solved) {
	    remove_from_list($n, $_);
	}
    }

    # Find any unique unsolved numbers
    %hash = ();
    for (@$set) {
	if (@$_ == 1) {
	    $hash{$$_[0]} = 10;
	    next;
	}
	foreach $n (@$_) {
	    $hash{$n}++;
	}
    }
    for (keys %hash) {
	if ($hash{$_} == 1) {
	    solve_list_with_number($_, $set);
	}
    }
}

sub iterate {
    check_set($_) for @sets;
    $iteration++;
}

sub print_output {
    my ($x, $y);

    print "-----------------\n";

    for ($y = 0; $y < H; $y++) {
	for ($x = 0; $x < W; $x++) {
	    if (@{$a[$x][$y]} == 1) {
		print $a[$x][$y][0] , ' ';
	    } else {
		#print join '', @{$a[$x][$y]} , ' ';
		print '. ';
	    }
	}
	print "\n";
    }
}

sub main {
    read_input();
    setup_sets();

    $iteration = 0;
    until (is_solved()) {
	print_output();
	iterate();
	sleep(1);
    }

    print_output();
    print "Solved after " . $iteration . " iterations\n";
}

main();
