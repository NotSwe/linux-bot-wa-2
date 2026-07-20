#!/bin/bash

OFFSET=0

while true
do

UPDATE=$(curl -s \
"https://api.telegram.org/bot${TELEGRAM_TOKEN}/getUpdates?offset=$OFFSET")


if echo "$UPDATE" | grep -q "/status"; then

curl -s \
"https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
-d chat_id="$TELEGRAM_CHAT_ID" \
-d text="🟢 BOT STATUS

Status: ONLINE
Workflow: RDP-BOT-WA-AUTO-LOOP
Runner: GitHub Actions
Watchdog: ACTIVE
Time: $(date)"


fi


ID=$(echo "$UPDATE" | grep -o '"update_id":[0-9]*' | tail -1 | cut -d: -f2)

if [ ! -z "$ID" ]; then
OFFSET=$((ID+1))
fi


sleep 5

done
