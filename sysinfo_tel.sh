#!/bin/bash

send_telegram_message() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$telegram_bot_token/sendMessage" \
        -d chat_id="$telegram_chat_id" \
        -d text="$message"
}

gather_system_usage() {
    local usage_info
    usage_info=$(cat <<EOF
System Usage:
- Hostname: $(hostname)
- Uptime: $(uptime -p)
- Load Average: $(uptime | awk -F'load average: ' '{ print $2 }')
- Memory Usage: $(free -h | awk '/^Mem:/ { print $3 "/" $2 }')
- Disk Usage: $(df -h / | awk '/\// { print $3 "/" $2 }')
- CPU Usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 "%"}')
EOF
    )
    echo "$usage_info"
}

log_dir="/var/log"
telegram_bot_token="BOT_TOKEN" # bot token is needed. I hide it
telegram_chat_id="YOUR_CHAT_ID"  # replace with your Telegram chat ID
interval=3600  # interval in seconds (e.g., 3600 seconds = 1 hour)

if [[ $(id -u) -ne 0 ]]; then
    message="This script must be run with superuser privileges."
    send_telegram_message "$message"
    exit 1
fi

for file in "$log_dir"/*; do
    if [[ -f "$file" ]]; then
        chmod g+w "$file"
        echo "Added write permission for group to file: $file"
    fi
done

# Sending initial success message to Telegram
message="все готово!"
send_telegram_message "$message"

# Periodically send system usage information to Telegram
while true; do
    system_usage=$(gather_system_usage)
    send_telegram_message "$system_usage"
    sleep "$interval"
done
