#!/usr/bin/perl

# Created by Alagar Pitchai
# Date Sep/23/2015


use File::Basename;
use strict;
use POSIX qw(strftime);

chdir(dirname($0));
my $datestring = strftime "%F_%H-%M-%S.txt" ,  localtime;

print " Date String : $datestring";
my $action = basename($0);
print $action;

my %links;
my $loc = qx(pwd);
chomp $loc;
print "\n$loc\n";

my $filename = "$loc/metcommand.configuration";
print "\n$filename\n";

open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";
while (my $line = <$fh>) {
   chomp $line;
   print "$line\n";
   my ($key, $val) = split ('=', $line);
   $links{$key} .= exists $links{$key} ? " $val" : $val;
}

while( my( $key, $value ) = each %links ){
    print "$key: $value\n";
    my @sc = split(' ', $value);
    foreach my $s (@sc) {
       qx(ln -s $loc/$key $s);
    }
}
