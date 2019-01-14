#!/usr/bin/perl

use warnings;
use strict;

my $g_home = "civ5patch/";
my $g_dir = ".local/share/Steam/steamapps/common/Sid Meier's Civilization V/";

$g_dir = '/tmp/' if defined($ARGV[0]) and $ARGV[0] eq '-n';

sub setn {
    my ($fh, $off, $byte, $count) = @_;
    sysseek($fh, $off, 0);
    syswrite($fh, chr($byte) x $count) or die;
}

sub match {
    my ($fh, $off, $pat) = @_;
    my $buf = '';
    sysseek($fh, $off, 0);
    sysread($fh, $buf, length($pat));
    return ($buf eq $pat);
}

sub prep {
    my ($file) = @_;
    my $fh;
    system("install -m 755 \"${g_home}${file}\" \"${g_dir}\"") and die;
    open($fh, '+<:raw', $g_dir . $file) or die;
    return $fh;
}

sub get1 {
    my ($fh, $off) = @_;
    my $buf = '';
    sysseek($fh, $off, 0);
    sysread($fh, $buf, 1);
    return unpack("C", $buf);
}

sub get4 {
    my ($fh, $off) = @_;
    my $buf = '';
    sysseek($fh, $off, 0);
    sysread($fh, $buf, 4);
    return unpack("V", $buf);
}

#
## Civ5XP
#
my $pat1 = "\x81\x3c\x2f\x01\x00\x60\x00";
my $pat2 = "\x73";
my $pat3 = "\x0f\x0b";
my $pat4 = "\x0f\x83";

sub checkCiv5XP {
    my ($fh, $off) = @_;
    return unless match($fh, $off, $pat1);
    $off += length($pat1);

    # Single-byte jump
    if (match($fh, $off, $pat2)) {
	if (match($fh, $off + 2 + get1($fh, $off + 1), $pat3)) {
	    setn($fh, $off, 0x90, 2);
	    printf("1. Patched SIGILL check at %x\n", $off);
	}
    }
    # Multi-byte jump
#    if (match($fh, $off, $pat4)) {
#	if (match($fh, $off + 6 + get4($fh, $off + 2), $pat3)) {
#	    setn($fh, $off, 0x90, 6);
#	    printf("2. Patched SIGILL check at %x\n", $off);
#	}
#    }
}

sub patchCiv5XP {
    my $fh = prep('Civ5XP');

    my $size = sysseek($fh, 0, 2);

    for (my $i = 0; $i < $size - length($pat1); ++$i) {
	checkCiv5XP($fh, $i);
    }

    close($fh);
}

#
## Expansion2
#
my $pat5 = "\x0f\x84\x9a\x00\x00\x00\x8b\x44\x3d\x68";

sub patchExpansion2 {
    my $fh = prep('libCvGameCoreDLL_Expansion2.so');

    my $off = 0x3a75a8;
    die unless match($fh, $off, $pat5);
    setn($fh, $off, 0x90, 1);
    setn($fh, $off + 1, 0xe9, 1);
    printf("3. Patched around SEGV at %x\n", $off);
    close($fh);
}

patchCiv5XP();
patchExpansion2();
