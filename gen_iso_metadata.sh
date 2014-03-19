#!/bin/sh
# based on Dashcloud's floppy img metadata generator

touch iso-contents-v3
for count in `ls |grep .iso`; do
  file $count >> iso-contents
  isoinfo -d -i $count >> iso-contents 2>&1
  7z l $count >> iso-contents 2>&1
done