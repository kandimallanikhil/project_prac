#!/bin/bash
#
echo "we awill start creating the users"
echo "$@" >> user.txt
if  [ ! -s user.txt ];
then
        echo "file was empty"
else

        for i in $(cat user.txt);
        do
                if id "$i" &>/root/user/log.txt;
                then
                        echo "user $i already exist:"
                else
                        sudo useradd $i
                        help=$(cat /etc/passwd | grep $i)
                        echo "$help"
                        echo "all is well"
                fi
                echo "sorry"
        done
fi
