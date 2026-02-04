#!/usr/bin/env bash

log_file=./nginx-access.log

check_log_file_exists ()
{
    if [[ -z $(ls -l "$log_file" 2> /dev/null) ]]; then
        printf "%s file is missing from this directory.\nExiting program...\n\n" "$log_file"
        exit 1
    fi
}

top_5_ips ()
{
    echo -e "\nTop 5 IP addresses with the most requests:" && \
        awk '{print $1}' $log_file  \
        | sort \
        | uniq --count \
        | sort --key=1 --numeric-sort --reverse \
        | head --lines=5 \
        | awk '{ print $2 " - " $1 " requests"}' && \
        echo
}

top_5_paths ()
{
    echo -e "\nTop 5 most requested paths:" && \
        awk '{print $7}' nginx-access.log \
        | sort \
        | uniq --count \
        | sort --key=1 --numeric-sort --reverse \
        | head --lines=5 \
        | awk '{ print $2 " - " $1 " requests"}' && \
        echo
}

top_5_status_codes ()
{
    echo -e "\nTop 5 response status codes:" && \
        grep --only-matching -E ' [1-5][0-9]{2} ' nginx-access.log \
        | sort \
        | uniq --count \
        | sort --key=1 --numeric-sort --reverse \
        | head --lines=5 \
        | awk '{ print $2 " - " $1 " requests"}' && \
        echo
}

main ()
{
    check_log_file_exists
    top_5_ips
    top_5_paths
    top_5_status_codes
}

main "$@"