#!/bin/bash
echo "list " $(date) > ./html/list.out

for filename in *.md; do
    base=${filename##*/}
    e="${filename##*.}"
    f="${base%.*}"
    echo "converting" $filename "to ./html/"$f".html"
    markdown-it "$filename" -o html/"$f".html
    echo "[]("$f".html)" >> ./html/list.out
done


