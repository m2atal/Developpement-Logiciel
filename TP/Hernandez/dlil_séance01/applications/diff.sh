#!/bin/bash

FILE1=$1
FILE2=$2

if [ "$FILE2" == "" ]
then
	echo "Usage: $0 <file1> <file2>"
	exit 0
fi

TMP1=/tmp/$O.tmp1
TMP2=/tmp/$O.tmp2

cat $FILE1 | sort | uniq -c > $TMP1
cat $FILE2 | sort | uniq -c  > $TMP2

diff -y $TMP1 $TMP2
