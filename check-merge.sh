#!/bin/sh
set -o nounset
set -o errexit

M=${1:-HEAD}
B=${M}^2
DEEP=${2:-1}

((git log --decorate -${DEEP} ${B}; git di ${B}~${DEEP} ${B}) |sed -r "s,(.*),- \1,"; \
 (git log --decorate -1       ${M}; git di ${M}^        ${M}) |sed -r "s,(.*),+ \1,") \
   |egrep -v "^[+-] index[ 0-9a-f.]+$" \
   |xd
