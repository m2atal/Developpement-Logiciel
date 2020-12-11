#!/bin/bash

#-- check input
if [ "$2" == "" ]
then
	echo "USAGE: $0 <xpath query> <file/dir name> [<OPTIONS>]"
	echo "OPTIONS:"
	echo "    -c: for count"
	echo "    -cn: for count with name"
	exit 0
fi

ISJAVA=`which java`
if [ "$ISJAVA" == "" ]
then
	echo "Error: no java command found in the PATH"
	exit 1
fi

# -- set env
#SAXONLIB=tools/saxon/saxon9he.jar 
SAXONLIB=$HOME/applications/textAnalysisToolkit/system/saxon/saxon9he.jar 
DATE=`date +%Y%m%d`-`date +%H%M%S`
SRCNAME=$2
XPATHQUERY=$1
OPTION=$3

#--
if [ -d "$SRCNAME" ]
then
	LISTNAME=`ls $SRCNAME/*`
else 
	LISTNAME=$SRCNAME
fi

# echo listname $LISTNAME


TOTAL=0
for f in $LISTNAME
do

TMPFILE=/tmp/`basename $f`-$DATE

#xpath -e '//w[@cat=""]' data/FrenchTreebank/corpus-tagged/$f 
#java -Xmx4092m -cp $SAXONLIB net.sf.saxon.Query -qs:"doc('$1')/$2" -o:$TMPFILE -wrap
JAVAARGS="-Xmx1024m"
JAVAARGS="-Xmx4092m"
echo java $JAVAARGS -cp $SAXONLIB net.sf.saxon.Query -qs:\"doc\(\'$f\'\)$XPATHQUERY\" -o:$TMPFILE -wrap
java $JAVAARGS -cp $SAXONLIB net.sf.saxon.Query -qs:"doc('$f')$XPATHQUERY" -o:$TMPFILE -wrap


if [ "$OPTION" == "" ]
then
	xmllint --format $TMPFILE 
else 
	if [ "$OPTION" == "-c" ]
	then
		# les éléments peuvent être result:element, result:attribute, result:text... 
		ELEMENTWC=`xmllint --format $TMPFILE  | grep '<result' | grep -v '<result:sequence' | wc -l` 
		echo $ELEMENTWC	
	else
		if [ "$OPTION" == "-cn" ]
		then
			echo -n "$f "
			ELEMENTWC=`xmllint --format $TMPFILE  | grep '<result' | grep -v '<result:sequence' | wc -l` 
			echo $ELEMENTWC	
		else
				echo "ERROR: unknown OPTION"
				exit 1
		fi
		
	fi
fi
TOTAL=$[TOTAL+ELEMENTWC]

done
echo INFO: run-$DATE $TOTAL \"$XPATHQUERY\" matched
