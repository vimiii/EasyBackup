#!/bin/bash

#this is a shell with link some file to ~/.backupgit. 
#you just run ./link.sh [filepath/filename]

###########
#enviroment
###########
home=$(echo $HOME)
Dir=$home'/.backupgit'/
DataDir=$Dir.data/
DataFile=$DataDir"data"
#echo $DataFile

#echo "$1 $2 $3"

#############
#check error
#############
if [ -z $1  ];then
        echo "          you must run './link.sh [filepath/filename]'"
        exit 0
elif [ $# -gt 1 ];then
        echo "          too much argument"
        echo "           you must run './link.sh [filepath/filename]'"
        exit 0
elif [ ! -f $1 -a ! -d $1 ];then
        echo "          no file to be found"
        exit 0
fi
###########
#had base
###########
if [ ! -d $Dir ];then
        mkdir $Dir
fi

if [ ! -d $DataDir ];then
        echo "mkdir $DataDir"
        mkdir $DataDir
fi

if [ ! -f $DataFile ];then
        echo "tou ch $DataFile"
        touch $DataFile
        echo "#!/bin/bash" >> $DataFile
        chmod +x $DataFile
fi

BackupFile=$(basename $1)
#echo $BackupFile

#############
#no file in ./backupgit
#############
if [ -f $1 ];then
        if [ ! -e $Dir$BackupFile ];then
                echo "          cp $1 $Dir$BackupFile"
                cp  $1 $Dir$BackupFile

                echo "echo 'cp -f $Dir$BackupFile $1'" >> $DataFile
                echo "cp  $Dir$BackupFile $1" >> $DataFile
                exit 0
        else
                echo "          cp -f $1 $Dir$BackupFile"
                cp  $1 $Dir$BackupFile
        fi
elif [ -d $1 ];then
        if [ ! -e $Dir$BackupFile ];then
                echo "          cp -rf $1 $Dir$BackupFile"
                cp  -r $1 $Dir$BackupFile

                echo "echo 'cp -rf $Dir$BackupFile $1'" >> $DataFile
                echo "cp -rf $Dir$BackupFile $1" >> $DataFile
                exit 0
        else
                echo "          cp -rf $1 $Dir$BackupFile"
                cp -r $1 $Dir$BackupFile
        fi
fi
