#!/bin/bash

interval=3600 # 1 hour
status=0      # 0 = UP; 1 = DOWN
url="https://www.momentkaph.sk"

# email configuration
toemail="your-email@domain.com"
fromemail="your-smtp-email@domain.com"
smtpserver="your-smtp-server"
port=587 # Common SMTP port
username="your-smtp-username"
password="your-smtp-password"

# email sending function
send() {
    # your SMTP configuration here
    sendemail -f "$fromemail" -t "$toemail" -u "$1" -m "$2" -s "$smtpserver:$port" \
        -xu "$username" -xp "$password" -o tls=yes -q
}

# infinite loop
while :; do
    # wget checks the status of the website
    wget --server-response --spider $url
    if [ $? -eq 0 ]; then
        if [ $status -eq 1 ]; then
            echo "UP | $(date)" >>"$url-status.log"
            send "$url is UP" "UP | $(date)"
            status=0
        fi
    else
        if [ $status -eq 0 ]; then
            echo "DOWN | $(date)" >>$(echo "$url-status.log")
            send "$url is DOWN" "DOWN | $(date)"
            stat=1
        fi
    fi

    sleep $interval

done

exit
