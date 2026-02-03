#!/usr/bin/env bash

dir_to_archive=$1
log_date=$(date '+%Y%m%d_%H%M%S')
log_dir=./logs/
logs_archive=logs_archive_"$log_date".tar.gz

dir_to_archive_check ()
{
    if [[ -z $1 ]]; then
        echo
        echo "This script requires a log directory argument."
        echo "Usage: ./<script> ./path/to/output"
        echo
        exit 1
    else
        echo
        echo "Log directory value set: $dir_to_archive"
        echo
    fi
}

archive ()
{   
    if [[ -z $(ls -l $log_dir) ]]; then
        echo
        echo Log directory not available, creating now...
        echo
        mkdir $log_dir
        ls -l
        echo
        echo Log directory created.
        echo
    else
        echo
        echo Log directory available
        ls -l
        echo
    fi
    echo
    echo "Creating logs $log_dir$logs_archive"
    echo
    tar -cvvf "$log_dir$logs_archive" "$dir_to_archive"
    echo
    echo Done.
}

main ()
{
    dir_to_archive_check "$@"
    archive
}

main "$@"
