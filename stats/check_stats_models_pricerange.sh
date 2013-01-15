#!/bin/bash
while read line; 
do 
  echo
  echo "STORE:$(echo $line | awk -F "," {'print $1'})"; 
  echo -n "\`- Columns add:"; echo "$(echo -n $line | awk -F "," {'for (i=2; i<NF; ++i){printf $i; if (i<NF-1){printf "+"}'}})" | bc; 
  echo -n "\`- Total in DB:"; echo "$(echo $line | awk -F "," {'print $11'})" | tr -d ' '; 
done<stats_models_pricerange.txt
echo
