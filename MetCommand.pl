#!/usr/bin/perl
#
# don@hautsch.com 2015-07-16
#

# Modified by Alagar Pitchai
# Date Sep/23/2015


use File::Basename;
use strict;

my $ACTION = basename($0);
print $ACTION;
my $CLASS;
my $SCRIPT_DIR = dirname($0); $SCRIPT_DIR = qx(cd $SCRIPT_DIR && pwd); chomp $SCRIPT_DIR;

if ($0 =~ m!decrypt!) {
        $CLASS = 'com.fanniemae.DecryptToStdOut';
}
else {
        $ENV{CLASSPATH} = "$SCRIPT_DIR/MetCommand/build/classes";
        $CLASS = 'com.siperian.metcommand.MetCommand';
}

$ENV{JAVA_HOME} = "/export/webapps/scommon/jdk/jdk1.7.0-x64";

foreach my $p_ (qx(find $SCRIPT_DIR -name '*.jar')) {
        chomp $p_;
        $ENV{CLASSPATH} .= ':' if $ENV{CLASSPATH};
        $ENV{CLASSPATH} .= $p_;
}

my $name = @ARGV[0];
if (not defined $name) {
   print "\nUsage of Metcommand: \n";
   print "\t-applyChangeList apply a changelist (-propertiesFilename, -sourceXmlFilename, -targetOrsId)\n";
   print "\t-createChangeList create a changelist (-propertiesFilename, -sourceOrsId|-sourceXmlFilename, -targetOrsId, -outputFilename)\n";
   print "\t-getOrsMetadata export metadata to the specified file (-propertiesFilename, -sourceOrsId, -outputFilename)\n";
   print "\t-validateChangeList validate a changelist (-propertiesFilename, -sourceXmlFilename, -targetOrsId)\n";
   print "\t-validateMetadata validate a ORS (-propertiesFilename, -targetOrsId)\n";
   exit;
}

foreach my $arg (@ARGV) {
   print " args : $arg \n";
}

exec("$ENV{JAVA_HOME}/bin/java $CLASS -$ACTION @ARGV 2>&1");
