#!/bin/bash

function monitor_page_for_content {
    haystack_url=$1
    needle=$2
    message=$3
    echo "Looking for '$needle' on page: $haystack_url"
    while true; do
        if curl -s "$haystack_url" | grep -q "$needle"; then
            echo 'Match!'
            osascript -e "display alert \"$message\""
            break
        else
            echo 'No match...'
        fi
        sleep 60
    done
}

if [ -z "$1" ]; then
    echo 'Provide month and year. E.g. "August 2017"'
    exit 1
fi

monitor_page_for_content 'https://news.ycombinator.com/submitted?id=whoishiring' "Who is hiring? ($1)" "HN Post Found!"
