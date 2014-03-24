#!/bin/bash
# 

if (( $# != 2 )); then
   echo "Usage: $0 forum_url base_name"
   exit 1
fi

if [ -f ~/.attoolsrc ]
then
   source ~/.attoolsrc
else
   attoolspath=unset
fi

if [ $attoolspath = 'unset' ]
then
   echo no path to phpbb3.lua
   exit 1
fi
wget-lua --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27" -nv -o $2-$( date +'%Y%m%d' ).log --page-requisites --span-hosts -e "robots=off" --keep-session-cookies --save-cookies=cookies.txt --timeout=10 --tries=3 --waitretry=5 --lua-script=$attoolspath/wget-lua-forum-scripts/phpbb3.lua --warc-header="operator: Archive Team" --warc-file=$2-$( date +'%Y%m%d' ) "$1/rss.php" "$1" "$1/index.php"