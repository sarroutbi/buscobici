#!/bin/bash
sloccount --addlangall $(for i in $(ls -d * | grep -v BACKUPS); do echo $i; done);
