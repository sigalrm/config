#!/usr/bin/perl

use warnings;
use strict;

my $home = $ENV{HOME};
die unless -d $home;

my $confdir = "$home/git/config/plugins";
my $dir1 = "$home/.local/share/qtermy/plugins";
my $dir2 = "$home/.local/share/qtermyd/plugins";
my $src1 = "/usr/local/share/qtermy/plugins";
my $src2 = "/usr/local/share/qtermyd/plugins";

system("rm -rf $dir1 $dir2");
system("mkdir -p $dir1 $dir2");

open(FH, '<', "$confdir/plugins.conf") or die;
while (<FH>) {
    chomp;
    if (m/^add (\S+)$/) {
        chdir($dir1);
        system("ln -sf $confdir/$1.mjs .") and die;
        chdir($dir2);
        system("ln -sf $confdir/$1.mjs .") and die;
    }
    elsif (m/^patch (\S+)$/) {
        chdir($dir1);
        system("cp $src1/$1.mjs .") and die;
        system("patch -p1 $1.mjs < $confdir/$1.patch") and die;
        chdir($dir2);
        system("cp $src2/$1.mjs .") and die;
        system("patch -p1 $1.mjs < $confdir/$1.patch") and die;
    }
    elsif (m/^enable (\S+)$/) {
        chdir($dir1);
        system("ln -sf $src1/$1.mjs.* $1.mjs") and die;
        chdir($dir2);
        system("ln -sf $src2/$1.mjs.* $1.mjs") and die;
    }
    else {
        die "Unrecognized directive '$_'\n";
    }
}
close(FH);
