#!/bin/bash

name=`git log -1 --oneline`
CommitName=$(echo $name | cut -d ' ' -f 1)
echo ${CommitName}

exit