#!/usr/bin/env bash

dir_to_archive=$1
log_date=$(date '+%Y%m%d_%H%M%S')
log_dir=./logs/
logs_archive=logs_archive_"$log_date".tar.gz

dir_to_archive_check ()
{
    if [[ -z $1 ]]; then
        echo -e "\nThis script requires a log directory argument."
        echo -e "Usage: ./<script> ./path/to/output\n"
        exit 1
    else
        echo -e "\nLog directory value set: $dir_to_archive\n"
    fi
}

archive ()
{
    if [[ -z $(ls -l $log_dir) ]]; then
        echo -e "\nLog directory not available, creating now...\n"
        mkdir $log_dir
        ls -l
        echo -e "\nLog directory created."
    else
        echo -e "\nLog directory available"
        ls -l
    fi
    echo -e "\n\nCreating logs $log_dir$logs_archive\n"
    tar -cvvf "$log_dir$logs_archive" "$dir_to_archive"
    echo -e "\nDone."
}

main ()
{
    dir_to_archive_check "$@"
    archive
}

main "$@"
