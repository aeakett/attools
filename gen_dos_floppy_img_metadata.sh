#!/bin/sh
# Initial version courtesy of Dashcloud

touch floppy-contents-v3
for count in `ls |grep .img`; do
  file $count >> floppy-contents
  mdir -i $count >> floppy-contents 2>&1
  7z l $count >> floppy-contents 2>&1
done