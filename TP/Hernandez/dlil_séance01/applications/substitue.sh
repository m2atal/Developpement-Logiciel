#!/bin/bash


#------------------------------------------------------------------------------
# By Nicolas.Hernandez@limsi.fr (Nicolas.Hernandez@gmail.com)
#
# voir usage
#
# 071207 substitue from sed file
# 070611 refactoring
# 05/10/13 Creation 
# 
#-----------------------------------------------------------------------------

TMP=/tmp
TMPEXT=bak
TMPFILE=sub

LOCALPATH=`pwd`

fileName() {
# IN/OUT `FILENAME=fileName $fichierEventuellementAvecChemin`
    LISTDOT=`echo $1 | tr ' ' '_' | tr '/' ' '`
    set $LISTDOT
    TAILLELISTDOT=$#
    while [ $TAILLELISTDOT -ge 1 ]
    do
      NAME=$1
      shift
      let TAILLELISTDOT=$TAILLELISTDOT-1
    done
    echo $NAME
}


filePath() {
    # IN/OUT PATH_I=`filePath $i`
    PATH_I_TMP=`echo $1 | tr '/' ' '`
    set $PATH_I_TMP
    
    PATH_I=""
    while [ $DEPTH_PATH_I -ge 1 ];
      do
      PATH_I=$PATH_I/$1
      shift 
      let DEPTH_PATH_I=($DEPTH_PATH_I - 1)
    done
    echo $PATH_I
}

if [ $# -ne 3 ]; then 
    echo "Usage: $0 -- substitute [<expr1> <with expr2>|-from <file list of sed s///g >] <in the file|in all the files present in (sub)directory>"
    exit 0
else 
    # is a directory
    if [ -d "$3" ]; then
	for file in `find $3 -name "*"` 
	  do
	  if [ -f "$file" ]; then
	      echo "Warning: modification of $file"
	      #PATH_I=`filePath $file`
	      #mkdir -p "$PATH_I"
	      #sed -e "s=$1=$2=g" $file > $TMP/$file.$TMPEXT
	      #mv $TMP/$file.$TMPEXT $file
	      
	      if [ "$1" = "-from"  ]; then
		  sed -f $2  $file > $TMP/$TMPFILE.$TMPEXT
	      else
		  sed -e "s=$1=$2=g" $file > $TMP/$TMPFILE.$TMPEXT
	      fi
	      mv $TMP/$TMPFILE.$TMPEXT $file
	  fi
	done
    else 
	file="$3"
            # is a file
	if [ -e "$file" ]; then
	    FILENAME=`fileName $fichierEventuellementAvecChemin $file`
	    echo "Warning: modification of $FILENAME "
	    #PATH_I=`filePath $file`
	    #mkdir -p "$PATH_I"
	   # sed -e "s=$1=$2=g" $file > $TMP/$FILENAME.$TMPEXT
	    #mv $TMP/$FILENAME.$TMPEXT $file
	      
	    if [ "$1" = "-from"  ]; then
		sed -f $2  $file > $TMP/$TMPFILE.$TMPEXT
	    else
		sed -e "s=$1=$2=g" "$file" > "$TMP/$TMPFILE.$TMPEXT"
	    fi
	    #echo "cp \"$TMP/$TMPFILE.$TMPEXT\" \"$file\""
	    mv "$TMP/$TMPFILE.$TMPEXT" "$file"
	fi
	
    fi
fi
