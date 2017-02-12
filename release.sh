#!/bin/bash

func=$(dirname $0)/mvn_functions
. ${func}

set -e

num_args=${#@}
if [ $num_args -gt 0 ]; then
   cd $1
fi

if [ ! -f pom.xml ]; then
   echo "no POM found in folder `pwd`"
   false
fi

project=$(current_project)
curr=$(current_version)

rel=$(to_release $curr)
dev=$(next_snapshot $rel)

echo -n "$curr - $rel - $dev - OK? [y/n]: "
read check

if [ "$check" = "y" ]; then
   echo "Doing RELEASE ... "
else
   echo "aborting ... "
   false
fi

git add . && git commit -m "[ci-skip] release prepare $rel" && git push

mvn --batch-mode versions:set -DnewVersion=$rel
git tag -a $rel -m "[ci-skip] release $rel" && git push origin $rel

mvn deploy 

mvn --batch-mode versions:set -DnewVersion=$dev
git add . && git commit -m "[ci-skip] release finish" && git push

cd ~/maven
git add . && git commit -m "[ci-skip] new release $rel of $project" && git push

