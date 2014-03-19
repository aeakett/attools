#!/bin/sh
# initially intended to generate a list of external image references in a warc

zgrep '<img' $1|sed 's/<img src="/\n/g'|grep '^http'|sed 's/\([^"][^"]*\).*/\1/'|sort|uniq