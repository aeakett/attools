#!/bin/sh
# initially intended to generate a list of external image references in a warc

if (( $# != 1 )); then
   echo "Usage: $0 filename.warc.gz"
	exit 1
fi

zgrep '<img' $1|sed 's/<img src="/\n/g'|grep '^http'|sed 's/\([^"][^"]*\).*/\1/'|sort|uniq