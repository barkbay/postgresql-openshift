#!/bin/bash

tag=`git describe --exact-match --tags $(git log -n1 --pretty='%h')`
regex='([0-9]+)r.*'

if [[ $tag =~ $regex ]]; then
  #psqlv=${BASH_REMATCH[1]}
  #echo "Postgresql version is $psqlv"
  docker build -f Dockerfile -t d1g1tal/postgresql-exporter:${tag} .
else
  echo "Cannot decode current git tag"
  exit 2
fi


