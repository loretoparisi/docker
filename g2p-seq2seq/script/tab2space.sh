#!/bin/bash

FILE=$1
# Replace multi-tab to single space
perl -p -i -e 's/[\t]+/ /g' $1