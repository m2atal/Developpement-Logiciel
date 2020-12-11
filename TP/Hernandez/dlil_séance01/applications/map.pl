#!/usr/bin/perl



################################################################################################
# 
# By Nicolas HERNANDEZ

# DESCRIPTIF : execute a "command" for all the file of a given directory
# IN :
# OUT :
# USAGE :
# DATES DE DERNIERES MODIF ET AJOUT :
# 07 11 02 
#  *
# 03 03 08

#-----------------------------------------------------------------------------#
#-- PROGRAM HEADER
#-----------------------------------------------------------------------------#

my $version = "1.01";
my $shortDescription =
"$0 -  Execute  command on all files of a given directory"  ;    # This program does...
my $fullDescription = "";
my $authors         = "nicolas dot hernandez at univ-nantes dot fr";
my $knownUsers      = "";


#-----------------------------------------------------------------------------#
#-- PACKAGES

use strict;
use Getopt::Long
  ; 

#-----------------------------------------------------------------------------#
#-- SAISIE DES PARAMETRES


our (%opts);


#--------------------------------------------------------------------------------------------------------#
## 

my $DEBUG = 0;

#
my $OUTPUT ="";

&initCommandLineOptions();



#-- find 
my $find = "find $opts{input}";
my $name = "*";
if (exists($opts{pattern})) { $name = $opts{pattern};}
$find .= " -name  \"$name\"";

my $listInputFile = readpipe ("$find");
#my (@listInputFile) = split (/[^\\]?\s+/, $listInputFile);
my (@listInputFile) = split (/\s+/, $listInputFile);

#--  exec
my $INPUT = "";
my $nameExtFile = "";
my $nameFile = "";

print STDERR "DEBUG: exec >$opts{exec}<\n" unless ($DEBUG == 1);

# si l'entrée doit être placée en argument
if ($opts{exec} =~ /_INPUT_/) {
    print STDERR "DEBUG: by argument\n" unless ($DEBUG == 1);
    foreach my $INPUT (@listInputFile) {
  
	$INPUT =~  m/([^\/]+)$/;	#m"/([^/]+)$";	
	$nameExtFile = $1;
	$nameExtFile =~ m/^([^\.]+)/;
	$nameFile = $1;
	$OUTPUT = $nameExtFile;

	#FIXME map.pl -i ../examples -p "*.sgml" -exec 'wc -l $INPUT'
	my $exec = $opts{exec};
	$exec =~ s/_INPUT_/$INPUT/g;
#	eval ($exec = "$opts{exec}");

	if (exists($opts{output})) {

	    $exec .= "> $opts{output}/$nameExtFile$opts{ext}";
	}
	print STDERR "INFO: $exec\n";

	system "$exec;";
    }
}
# si l'entrée doit être placée en pipeline
else {
    print STDERR "DEBUG: by pipeline\n" unless ($DEBUG == 1);

    foreach my $INPUT (@listInputFile) {

	$INPUT =~  m/([^\/]+)$/;	#m"/([^/]+)$";	
	$nameExtFile = $1;
	$nameExtFile =~ m/^([^\.]+)/;
	$nameFile = $1;
	$OUTPUT = $nameExtFile;
	print STDERR "DEBUG: OUTPUT>$OUTPUT<\n" unless ($DEBUG == 1);

	#
	my $exec = "cat $INPUT |$opts{exec}";	
	$exec =~ s/_OUTPUT_/$OUTPUT/g;

	if (exists($opts{output})) {
	    #$exec .= "> $opts{output}/$nameFile$opts{ext}";
	    $exec .= "> $opts{output}/$nameExtFile$opts{ext}";
	}
	print STDERR "INFO: $exec\n";
	system "$exec";
    }
}




sub initCommandLineOptions() {

#use  Getopt::Long;  http://articles.mongueurs.net/magazines/linuxmag49.html
#  il peut recevoir une référence de hash dans laquelle il stockera les options.
# Attention, contrairement à Getopt::Std, la référence au hash est la première valeur à passer à GetOptions
# options booléennes
# option négative  réagira à une commande --option mais aussi à une commande --nooption.
#En initialisant correctement la valeur correspondant à l'option, on peut imposer un comportement par défaut
# facilement modifiable. Pour spécifier une option négative, il suffit de concaténer un ! après le nom de l'option.
# Spécifier un type incrémental.  A chaque occurrence de l'option sur la ligne de commande, la valeur sera incrémentée de 1. Ce type se distingue via un + concaténé après le nom de la variable
# options complexes
#%Gà¸¢à¸¢%@ Pour les arguments optionnels ajoutent un : après le nom de l'option alors que les arguments obligatoires sont spécifiés par un =
# Pour préciser le type, il suffit de rajouter après le = (ou le :) un caractère représentant le type attendu : s pour une cha%Gà¸£à¸¢à¸%@ne (string), i pour un entier (integer) ou f pour un réel (float).
# Pour spécifier des noms d'option identiques : il suffit de les faire se suivre par un |
# il suffit d'ajouter un @ ou un % pour retrouver le comportement voulu, à savoir une option récupérant une liste ou un hash.

	GetOptions(
		\%opts
		,    # Récupération de toutes les options et leur valeur dans la hash
		"verbose+",      # --verbose --verbose
		"help"    => \&usage,
		"version" => \&usage,
		"input=s",
		"output=s",
		"pattern=s",
		"exec=s",
		"ext=s"
#		"input=s@",
#		"output=s%"
#		"include=s" => \@include,   # liste de val traitée ensuite par  @include = split /,/, join(',',@include);
	) or die;

	# dans les tests utiliser les formes complètes des noms des options !
	if ( exists( $opts{i} ) )    { $opts{input}   = $opts{i}; }
	if ( exists( $opts{o} ) )    { $opts{output}  = $opts{o}; }
	if ( exists( $opts{verb} ) ) { $opts{verbose} = $opts{verb}; }
	if ( exists( $opts{p} ) ) { $opts{pattern} = $opts{p}; }

	if ( ! exists( $opts{input} ) ) { &usage(); }
	if ( ! exists( $opts{exec} ) ) { &usage(); }

}

#
#-- Message about this program and how to use it
#
sub usage() {
	print STDERR << "EOF";
    
  $shortDescription

  Syntax:   
 $0 --input sourceDirectory [--pattern REGEXP to filter source files] --exec command [--output targetDirectory] [--ext extensionToAdd-on] [--help]
  
  _INPUT_ and _OUTPUT_ are two variables available in the exec options to tune the command to execute as you need it (see the examples below)

  Examples:
  # execute wc -l sur tous les .sgml du répertoire courant en les pipant
  map.pl -i . -p "*.sgml" -exec "wc -l" 
  
  # execute wc -l sur tous les .sgml du répertoire courant en les passant par argument
  map.pl -i . -p "*.sgml" -exec "wc -l _INPUT_" 
  
  # execute wc -l sur tous les .sgml du répertoire courant et en redirigeant la sortie 
  # de chaque execution dans le répertoire /tmp et en nommant les fichiers par le nom d'entrée
  map.pl -i . -p "*.sgml" -exec "wc -l" -o /tmp
  
  # execute wc -l sur tous les .sgml du répertoire courant et en redirigeant la sortie 
  # de chaque execution dans le répertoire /tmp et en nommant les fichiers par le nom d'entrée avec l'extension .wc
  map.pl -i . -p "*.sgml" -exec "wc -l" -o /tmp -ext ".wc"
  
  # variante
  # execute wc -l sur tous les .sgml du répertoire courant et en redirigeant la sortie 
  # de chaque execution dans le répertoire /tmp et en nommant les fichiers par le nom d'entrée avec l'extension .another.wc
  map.pl -i . -p "*.sgml" -exec "wc -l > /tmp/_OUTPUT_.another.wc"

    
  Authors: $authors
 
  Version: $version

  Exit message: $!
EOF
	exit;
}



































