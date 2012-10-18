#!/bin/bash
export LANGUAGE=
export LC_ALL=
export LANG=
sloccount --addlangall $(for i in $(ls -d * | grep -v BACKUPS); do echo $i; done);
