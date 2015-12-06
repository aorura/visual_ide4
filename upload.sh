#!/bin/bash
declare -i file_cnt=0
declare -i i=1
declare -i num_files=1000
declare -i cnt
declare -a remote=("dummy_url" "https://github.com/aorura/visual_ide4.git" "https://github.com/aorura/visual_ide4.git")
declare -i pre_i=0

# set dummy origin to avoid the error
if [ ! -d ".git" ]
then
   git init
   git remote add origin https://github.com/aorura/visual_ide4.git
fi

for egg in *.egg
do
   i=$((file_cnt / num_files + 1))
   cnt=$((num_files * i))

   if [ $pre_i -ne $i ]
   then
   	#echo "diff url $pre_i : $i"
	#echo ${remote[i]}

        echo "change remote-url ${remote[i]}"
   	git remote set-url origin ${remote[i]}
        pre_i=$i	
   fi 

   #if [ $file_cnt -le $cnt ]
   #then
   #   echo "$file_cnt $egg"
   #fi 
   git add $egg
   git commit -m "$egg"
   git push origin master
   echo "$egg uploaded..."

   file_cnt=$((file_cnt + 1))
done
