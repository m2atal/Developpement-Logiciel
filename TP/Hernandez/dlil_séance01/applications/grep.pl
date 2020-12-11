#!/usr/bin/perl


#-----------------------------------------------------------------------------#
# 
# By Nicolas HERNANDEZ 
# nicolas.hernandez@limsi.fr
# 
# DESCRIPTIF : 
# -- INPUT :
# -- PROCESSING :
# -- OUTPUT :

# USAGE :

# LAST MODIFIED : 
# -- 

#-----------------------------------------------------------------------------#


#-----------------------------------------------------------------------------#
#-- PACKAGES

use strict;
#use std_nico;
#use xml_nico;
#use tag_nico;

my $TRUE = 1;
my $FALSE = 0;

#  my $str;
#  my $num;

#  format Something =
#          Test: @<<<<<<<< @||||| @>>>>>
#                $str,     $%,    '$' . int($num)
#  .
#### Attention ce . doit être coller au bord gauche !!!!!!!!!!!!!!!!!!!!!!!!!


    
#  $str = "widget";
#  $num = 1.23;
#  $~ = 'Something';
#  write;
#-----------------------------------------------------------------------------#
#-- SAISIE DES PARAMETRES

#my $version;
#my $input = "";
#my $output = "";

#my @stdin = <STDIN>;

my $condition = "";
my $vArg = "";
my $patron = "";
my $file = "";

while (my $opt = shift @ARGV) {
    $_ = $opt;
  SWITCH: {
      if (/^\-c$/) {
	  $condition = shift;
	  last SWITCH;
      }
      if (/^\-v$/) {
	  $vArg = $_;
	  last SWITCH;
      }
      if ((/^\-h$/) || (/^\--help$/)) {
	  &help() ;
      }
      #&error("");
#      if ($patron eq "") {$patron = $_}
#      else {$file = $_;} 
      $patron = $_; 
  }
}
#print STDERR "Debug: FILE>$_< stdin>$#stdin<\n";
#if (($_ eq "") && ($#stdin == -1)) {&error("FILE or PIPELINE is required"); }

#my $isStdin = eof STDIN ; # ne marche pas
#print "Debug: isStdin>$isStdin<  FILE>$_< \n";
#if ($file eq "") {&error("FILE or PIPELINE is required"); }



#$patron = shift;

#print "Debug:>$patron<\n";

#if ($condition eq "") { &error("a condition is required");      }
if ($patron eq "") {
    &error("PATTERN is required");     
}


#  #  # syntactic check
#  #  if (!(( (@ARGV + 0) == 3 ) || ( (@ARGV + 0) == 5 ))) {
#  #     &error();
#  #  }

#  #  $version =~ s/-//g;
#  #  if (($version ne 'fr') && ($version ne 'en')) {&error();}

#  &assertValid($metaCommonFile,"","metaCommonFile >$metaCommonFile< non existant");

sub usage() {
    #my ($) = @_;
    print STDERR "Usage: $0 [OPTION]... \"/PATTERN/\" \n";
    die "[-h]? (more help)\n";
}

sub error($) {
    my ($error) = @_;
    print STDERR "Error: $error\n";
    &usage();
}

sub help() {
    print STDERR "Description: - PERL GREP\n";
    print STDERR "Author: Nicolas dot Hernandez at limsi dot fr\n";
    print STDERR "Date: 05/05/25\n";
    &usage();
}

sub assertValid($$$) {
    # is valid if different from the second param
    my ($param,$criticCase,$message) = @_;
      
    if ($param eq $criticCase) {
	error($message);
    }
}


#-----------------------------------------------------------------------------#
#-- INPUT

#  my $fileFreqAbs = shift @ARGV;

#  print STDERR "Processing: Loading the first file...\n";

#  open(INFILE,"$fileFreqAbs");

#  my %mfa = ();

#  while (<INFILE>) {
#      chomp;
#      my ($r,$f,$m) = split (/\t/);
    
#      $mfa{$m} = $f;
    
#  }


#  #  my @inputFile = <STDIN>;


#  #  foreach my $aEntree (@inputFile) {
#  #      chomp ($aEntree);
#  #      $entree {$aEntree}++;
#  #  }


#  #-----------------------------------------------------------------------------#
#  #-- PROCESSING

#  #my %meta

#  print STDERR "Processing: Parsing the second file with the first file...\n";


#  while (<>) {
#      chomp;
#      my ($r,$f,$m) = split (/\t/);
    
#      if (exists($mfa{$m})) { print "$f\t$mfa{$m}\t$m\n";} 
#  #   if (exists($mfa{$m})) { print "$mfa{$m}\t$f\t$m\n";}
#     # else {print STDERR "Info: n'existe pas >$m<\n"}
    
#  }


#  #-----------------------------------------------------------------------------#
#  #-- OUTPUT

$patron = "/$patron/";


while (<>) {
#foreach $_ (@stdin) {
    chomp;
    #print "Debug: >$_<\n";
    
    if ((eval($patron)) && ($vArg eq '')) {	
	print; print "\n";
    } 
    elsif ((!(eval($patron))) && ($vArg ne '')) {  
	print; 
	print "\n";}
}






#  #-- Classic Display !f
#  for (my $idRe = 0 ; $idRe < $idObjet ; $idRe++) {
#      my %object = %{$objet{$idRe}};
    
#      #-- test conditionnel 
#      my $eval = eval($condition);
#      #print "Debug:>$condition<>$eval<\n";
#      if (eval($condition)) {
	
#  	print "<$object{balise}>\n";
	
#  	foreach my $feat (keys(%object)) {	
#  	    print "<$balFeature $feat=\"$object{$feat}\"/>\n";
#  	}
	
#  	print "</$object{balise}>\n";
#      }
#  }


