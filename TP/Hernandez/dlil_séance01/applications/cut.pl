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

my $version;
my $input = "";
my $delim = "\t";
my @arg = ();

while (my $opt = shift) {
    $_ = $opt;
  SWITCH: {
      if (/^\-v$/) {
	  $version = shift;
	  last SWITCH;
      }
      if (/^\-col$/) { # colonne dans l'ordre
	  $input = shift;
	  push @arg, $input;
	  last SWITCH;
      }
      if (/^\-delim$/) { # delimiteur
	  $delim = shift;
	  last SWITCH;
      }     
      if (/^\-h$/) {
	  &error("Help");
	  last SWITCH;
      }
      &error("wrong arguments");
  }
}

#if (($input eq "") && ($output eq "")) {
#  &error("bad arguments");     
#}


#  # syntactic check
#  if (!(( (@ARGV + 0) == 3 ) || ( (@ARGV + 0) == 5 ))) {
#     &error();
#  }

#  $version =~ s/-//g;
#  if (($version ne 'fr') && ($version ne 'en')) {&error();}

#&assertValid($metaCommonFile,"","metaCommonFile >$metaCommonFile< non existant");


sub error($) {
    my ($error) = @_;
    print STDERR "Message: $error\n";
    print STDERR "Description: - \n";
    print STDERR "Usage: perl $0 
[-col indice]+\tles indices derrière l argument -col correspond au numéro des colonnes dans le fichier source ; l ordre d apparition dans les arguments correspond à celui de l affichage     
[-delim delim]\tle démitateur par défaut un espace
 \n";
    die "Exemple: cat  \| perl $0 
[-v version (en|fr)] 
[-h (this help)]?\n";
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


#  my %entree = ();

#  #my @inputFile = <STDIN>;

#  open (INFILE, "$input");
#  my @inputFile = <INFILE>;
#  close INFILE;

#  foreach my $aEntree (@inputFile) {
#      chomp ($aEntree);
#      #my ($rank,$freq,$term) = split (/\t/, $aEntree);
#      #$entree {$term} = $freq;
#      $entree {$aEntree}++;

#  }


#-----------------------------------------------------------------------------#
#-- PROCESSING


while (<>) {
    my $current = $_; 
    chomp $current;
    
    my @colonne = split (/$delim/, $current);
    
    my $toPrint = "";
    foreach my $a (@arg) {
	$toPrint .= "$colonne[$a]\t"; 
    }
    $toPrint =~ s/\t$//g; 
    print "$toPrint\n";
   
   
}


#-----------------------------------------------------------------------------#
#-- OUTPUT




