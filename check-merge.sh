#!/bin/bash
set -o nounset
set -o errexit

echo "looking for the merge of '${1:?ERR: expected branch name as the first argument}' ..."
MERGE=$(git log --oneline -7777 |grep " branch '$1'.* into " |head -n 1 |sed "s,\s.*,,")
BRANCH=${MERGE:?not found}^2
git log --oneline -1 $MERGE

DEEP=${2:-$(git log --oneline ${MERGE}^1..${BRANCH} |wc -l)}

vimdiff \
	<(git log --decorate -${DEEP} ${BRANCH}; git di ${BRANCH}~${DEEP} ${BRANCH}) \
	<(git log --decorate -1 ${MERGE}; git di ${MERGE}^ ${MERGE})
