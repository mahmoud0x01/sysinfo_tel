# sysinfo_tel

This script periodically sends important system usage information to a specified Telegram bot as a message to send it to specific Telegram User. It is designed to run with superuser privileges and can help monitor the system's performance remotely.

## Features

- Sends initial setup status to Telegram.
- Periodically collects and sends system usage information including:
  - Hostname
  - Uptime
  - Load average
  - Memory usage
  - Disk usage
  - CPU usage
- Adjustable reporting interval.

## Prerequisites

- A Telegram bot token. You can create a bot by following the instructions [here](https://core.telegram.org/bots#creating-a-new-bot).
- Your Telegram chat ID. You can get your chat ID by messaging the bot and accessing the `https://api.telegram.org/bot<BOT_TOKEN>/getUpdates` URL.

## Setup

1. Clone this repository:
    ```bash
    git clone https://github.com/your-username/system-usage-telegram-bot.git
    cd system-usage-telegram-bot
    ```

2. Edit the script `system_usage_telegram.sh` to add your Telegram bot token and chat ID:
    ```bash
    nano system_usage_telegram.sh
    ```

    Replace the placeholders with your actual bot token and chat ID:
    ```bash
    telegram_bot_token="YOUR_BOT_TOKEN"
    telegram_chat_id="YOUR_CHAT_ID"
    ```

3. Make the script executable:
    ```bash
    chmod +x system_usage_telegram.sh
    ```

## Usage

1. Run the script with superuser privileges to ensure it can modify log file permissions:
    ```bash
    sudo ./system_usage_telegram.sh
    ```

2. The script will start by ensuring it has the necessary permissions and will send an initial success message to your Telegram bot.

3. It will then enter an infinite loop, periodically gathering system usage information and sending it to your Telegram bot at the specified interval (default is every hour).

## Customization

- To change the reporting interval, edit the `interval` variable in the script (time is in seconds):
    ```bash
    interval=3600  # e.g., 3600 seconds = 1 hour
    ```

## Example

After running the script, you will receive messages in your Telegram bot that look like this:

```
System Usage:
- Hostname: myserver
- Uptime: up 1 hour, 23 minutes
- Load Average: 0.42, 0.37, 0.35
- Memory Usage: 2.3G/8.0G
- Disk Usage: 15G/50G
- CPU Usage: 7.5%
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to modify the script and the README file according to your needs. If you encounter any issues or have suggestions, please open an issue or submit a pull request.
