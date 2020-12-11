#!/usr/bin/perl


#-----------------------------------------------------------------------------#
# 
# By Nicolas HERNANDEZ 
# nicolas.hernandez@gmail.com
# 
# DESCRIPTIF : 
my $shortDescription = "rename files -from dir1 matching -pattern turning name -with expr1 -into expr2 (may copy -to a dir2)";
# -- INPUT :
# -- PROCESSING :
# -- OUTPUT :

# USAGE :

# LAST MODIFIED : 
# -- 03 07 22

#-----------------------------------------------------------------------------#


#-----------------------------------------------------------------------------#
#-- PACKAGES

use strict;
#use std_nico;
#use xml_nico;
#use tag_nico;

my $TRUE = 1;
my $FALSE = 0;


#-----------------------------------------------------------------------------#
#-- SAISIE DES PARAMETRES

my $version;
my $from = "";
my $pattern = "";
my $into = "";
my $with = "";
my $to = "";


while (my $opt = shift) {
    $_ = $opt;
  SWITCH: {

      if (/^\-from$/) {
	  $from = shift;
	  last SWITCH;
      } 
      if (/^\-pattern$/) {
	  $pattern = shift;
	  last SWITCH;
      }
      if (/^\-to$/) {
	  $to = shift;
	  last SWITCH;
      }
      if (/^\-into$/) {
	  $into = shift;
	  last SWITCH;
      }
      if (/^\-with$/) {
	  $with = shift;
	  last SWITCH;
      }
      &error("wrong -from or -to");
      
  }
}

if (($from eq "") && ($into eq "")  && ($with eq "")) {
  &error("bad arguments");     
}


#  # syntactic check
#  if (!(( (@ARGV + 0) == 3 ) || ( (@ARGV + 0) == 5 ))) {
#     &error();
#  }

#  $version =~ s/-//g;
#  if (($version ne 'fr') && ($version ne 'en')) {&error();}



sub error($) {
    my ($error) = @_;

    print STDERR "Description: - $shortDescription \n";
    print STDERR "Usage: perl $0 -from dir1 [-pattern file having this pattern] [-with expr1] [-into expr2] [-to dir2]\n";
    print STDERR "Exemple:  $0  \n";
    die "Error: $error\n";
}




#-----------------------------------------------------------------------------#
#-- INPUT


#-----------------------------------------------------------------------------#
#-- PROCESSING

#-- pour tous les fichiers qui sont couramment à l'intérieur du répertoire from 


#-- find 
my $find = "find $from";
my $name = "*";
if ($pattern ne "") { $name = $pattern;}
$find .= " -name  \"$name\"";

my $listInputFile = readpipe ("$find");
#my (@listInputFile) = split (/[^\\]?\s+/, $listInputFile);
my (@listInputFile) = split (/\s+/, $listInputFile);

my $INPUT = "";
my $nameExtFile = "";
my $nameFile = "";

foreach my $INPUT (@listInputFile) {
# afin de permettre de changer des parties autres que l'extension
    my $in =  $INPUT;
    my $out = $in;

#BEAWARE: s/\$with/\$into can alter the path to this file not only the basename
     $out =~ s/$with/$into/; 

    my $command = "mv";

    if ($to ne "") {
	$INPUT =~  m/([^\/]+)$/;	#m"/([^/]+)$";	
	$nameExtFile = $1;
	$nameExtFile =~ m/^([^\.]+)/;
#	$nameFile = $1;
	$nameExtFile =~ s/$with/$into/; 
	$command = "cp"; 
	
	$out = $to.'/'.$nameExtFile;
    }  

 

    print STDERR "INFO: $command $in $out  \n";
    system "$command $in $out ";
}



#-----------------------------------------------------------------------------#
#-- OUTPUT








