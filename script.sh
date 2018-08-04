#!/usr/bin/env bash

# Written some time in 2014
# Probably doesnt work anymore, but I wouldnt be surprised

airport=/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport && sudo $airport -z
device=$(networksetup -listallhardwareports | grep -A1 "Wi-Fi" | grep "Device:" | cut -d ":" -f2 | sed 's/^ *//')
newmac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
sudo ifconfig $device ether $newmac
actualmac=$(ifconfig en1 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
if [ "$newmac" = "$actualmac" ]; then
    echo IT WORKED!
else
    echo YOU MUST TRY AGAIN D:
fi
