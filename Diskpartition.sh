#!/bin/bash

usage() {
    echo "To create a partition follow the instructions below"
    echo "Enter :"
    echo "1 to list  the different disk partitions already available. You might be prompted to enter your password."
    echo "2 to create a new partition"
    echo "3 to exit"

}
partition() {
    read num
    case $num in
    1)
        sudo fdisk -l
        read -p "Enter p to proceed" p
        if [ "$p" = 'p' ]; then
            usage
            partition
        fi
        ;;
    2)
        echo "Copy the path to the disk and paste it here : "
        read path
        
        if [ ! -d $path ]; then
            if [[ "$path" =~ ^/ ]]; then
                cd /
                sudo fdisk $path
            fi
            echo "Path /dev/nvme0n1p2th to disk does not exist"
            read -p "Enter r to return" r
            if [ "$r" = 'r' ]; then
                usage
                partition
            fi
        else
            if [ "${path#/}" != "/" ]; then
                cd /
                sudo fdisk $path
            fi
        fi
        ;;
    3)
        exit
        ;;
    *)
        usage
        ;;
    esac

}

echo "Hello I Guess you will like to partition your disk [yes/no]"
read ans
if [ "$ans" = "yes" ]; then
    echo "You are at the right place"
    read -p "Now Lets create a partition press c to continue : " c
    if [ "$c" = "c" ]; then
        usage
        partition
    fi
fi
