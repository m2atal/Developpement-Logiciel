#!/usr/bin/perl


#-----------------------------------------------------------------------------#
# 
# By Nicolas HERNANDEZ 
# nicolas.hernandez@limsi.fr
# 
# DESCRIPTIF : uniq -c d'unix pas fiable ? question de taille ? 
# -- INPUT :
# -- PROCESSING :
# -- OUTPUT :

# USAGE :

# LAST MODIFIED : 
# -- 03 03 12

#-----------------------------------------------------------------------------#


#-----------------------------------------------------------------------------#
#-- PACKAGES

use strict;
#use std_nico;
#use xml_nico;
#use tag_nico;



#-----------------------------------------------------------------------------#
#-- PROCESSING

my $cOption = 0;

my $uniqOnASpecificCol = "";

while (my $opt = shift) {
    $_ = $opt;
  SWITCH: {
      if (/^\-c$/) {
	  $cOption = 1;
	  last SWITCH;
      }
      if (/^\-col$/) {
	  $uniqOnASpecificCol = shift;
	  last SWITCH;
      }
      else {&error();}
  }
}


sub error() {
      print STDERR "Description: uniq - (identique à unix) \n";
      print STDERR "Usage: perl $0 <-c> <-col uniqOnASpecificCol>\n";
      die "Exemple: cat <anyFile> \| perl $0 -c\n";
}

my %expression;

while (<>) {
    my $current = $_;
    chomp $current ;
    
    if ($uniqOnASpecificCol ne '') {
	my (@lst) = split (/\t/, $current);
	if (!exists($expression{$lst[$uniqOnASpecificCol]})) {
	    if (!$cOption) {print "$current\n";}
	}
	$expression{$lst[$uniqOnASpecificCol]}++;
    }
    
    else {
	if (!exists($expression{$current})) {
	    if (!$cOption) {print "$current\n";}
	}
	$expression{$current}++;	
    }
	
    
}


#-----------------------------------------------------------------------------#
#-- OUTPUT

if ($cOption) {
    foreach my $k (keys(%expression)) {
	print "$expression{$k}\t$k\n";
    }
}

