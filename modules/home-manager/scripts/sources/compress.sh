#!/usr/bin/env bash

if (( $# == 1 )) then
  tar -cvzf "$1.tar.gz" $1
else
  echo "Wrong number of arguments..."
fi
