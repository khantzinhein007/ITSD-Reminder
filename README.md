# 🤖 ITSD Reminder Bot

A Slack bot that automatically reminds users to select a category for their IT Service Desk tickets when they forget to do so.

## 📋 Table of Contents

- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start)
- [Configuration](#-configuration)
- [Docker Deployment](#-docker-deployment)
- [Running Locally](#-running-locally)
- [How It Works](#-how-it-works)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)

## ✨ Features

- 🔍 **Automatic Monitoring** - Continuously monitors your Slack channel for new tickets
- ⏰ **Smart Timing** - Only reminds users after a configurable time threshold
- 🤖 **HelpDesk Integration** - Detects when HelpDesk bot has already processed a ticket
- 🔄 **Duplicate Prevention** - Tracks reminded messages to avoid spamming users
- 🐳 **Docker Ready** - Fully containerized with multi-architecture support (Intel & Apple Silicon)
- 🔒 **Secure** - Runs as non-root user, credentials via environment variables

## 📦 Prerequisites

### For Docker Deployment (Recommended)
- Docker 20.10 or later
- Docker Compose v2.0 or later

### For Local Development
- Python 3.9 or later
- pip (Python package manager)

### Slack Bot Setup (Step-by-Step)

Follow these steps to create and configure your Slack bot:

#### Step 1: Create a Slack App

1. Go to [api.slack.com/apps](https://api.slack.com/apps)
2. Click **"Create New App"**
3. Choose **"From scratch"**
4. Enter an App Name (e.g., "ITSD Reminder Bot")
5. Select your workspace
6. Click **"Create App"**

#### Step 2: Configure Bot Permissions

1. In the left sidebar, click **"OAuth & Permissions"**
2. Scroll down to **"Scopes"** → **"Bot Token Scopes"**
3. Click **"Add an OAuth Scope"** and add these scopes:

| Scope | Purpose |
| ----- | ------- |
| `channels:history` | Read messages from public channels |
| `channels:read` | View basic channel info |
| `chat:write` | Send reminder messages |
| `users:read` | Get user information for mentions |

#### Step 3: Install the App

1. Scroll up to **"OAuth Tokens for Your Workspace"**
2. Click **"Install to Workspace"**
3. Review the permissions and click **"Allow"**
4. Copy the **Bot User OAuth Token** (starts with `xoxb-`)
   - This is your `SLACK_BOT_TOKEN`

#### Step 4: Invite Bot to Channel

1. Open Slack and go to your IT Service Desk channel
2. Type `/invite @YourBotName` (use the name you gave your app)
3. The bot is now in the channel and can read/send messages

#### Step 5: Get Required IDs

**Channel ID:**
1. Right-click on your channel name in Slack
2. Select **"View channel details"**
3. Scroll to the bottom - copy the **Channel ID** (starts with `C`)

**HelpDesk Bot ID:**
1. Find any message from your HelpDesk bot in the channel
2. Click the three dots (⋮) on the message → **"Copy link"**
3. The URL contains info, or use Slack's API to find the `bot_id` (starts with `B`)

> **Tip:** You can also find the HelpDesk bot ID by making an API call:
> ```bash
> curl -H "Authorization: Bearer xoxb-your-token" \
>   "https://slack.com/api/conversations.history?channel=YOUR_CHANNEL_ID&limit=50" \
>   | grep -o '"bot_id":"[^"]*"' | head -1
> ```

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/CaputoDavide93/ITSD-Reminder.git
cd ITSD-Reminder
```

### 2. Configure Environment

```bash
# Copy the example configuration
cp .env.example .env

# Edit with your values
nano .env  # or use your preferred editor
```

### 3. Run with Docker

```bash
# Build and start the container
docker-compose up -d

# View logs
docker-compose logs -f
```

That's it! The bot is now running. 🎉

## ⚙️ Configuration

All configuration is done through environment variables. Copy `.env.example` to `.env` and fill in your values:

### Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `SLACK_BOT_TOKEN` | Your Slack Bot OAuth Token | `xoxb-123-456-abc` |
| `CHANNEL_ID` | The Slack channel ID to monitor | `C0310Q6B8S0` |
| `HELPDESK_BOT_ID` | The HelpDesk bot's ID | `B03303BSU56` |

### Optional Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `AGE_THRESHOLD_SECONDS` | Time to wait before sending reminder | `10800` (3 hours) |
| `CHECK_INTERVAL_HOURS` | How often to check for new messages | `2` |
| `REMINDER_MESSAGE` | Custom reminder message | See default in `.env.example` |
| `REMINDER_LOG_FILE` | Path to store reminded message IDs | `/app/data/reminded_messages.json` |

### Finding Your IDs

**Channel ID:**
1. Open Slack and right-click on the channel
2. Select "View channel details"
3. Scroll down to find the Channel ID (starts with `C`)

**HelpDesk Bot ID:**
1. Find a message from the HelpDesk bot
2. Use Slack's API or inspect the message to find the `bot_id` (starts with `B`)

## 🐳 Docker Deployment

### Multi-Architecture Support

This image supports both **Intel/AMD64** and **Apple Silicon (M1/M2/M3) ARM64** processors.

### Build and Run

```bash
# Standard build and run
docker-compose up -d

# Build for specific platform (if needed)
docker build --platform linux/amd64 -t itsd-reminder:amd64 .
docker build --platform linux/arm64 -t itsd-reminder:arm64 .

# Build multi-arch image (requires Docker Buildx)
docker buildx build --platform linux/amd64,linux/arm64 -t itsd-reminder:latest .
```

### Docker Commands

```bash
# View container status
docker-compose ps

# View logs
docker-compose logs -f

# Restart the service
docker-compose restart

# Stop the service
docker-compose down

# Rebuild after code changes
docker-compose up -d --build
```

### Persistent Data

The bot stores reminded message IDs in `/app/data/reminded_messages.json` inside the container. This is mounted to `./data/` on your host machine to persist across container restarts.

```bash
# Create data directory if it doesn't exist
mkdir -p data
```

## 💻 Running Locally

For development or testing without Docker:

### 1. Create Virtual Environment

```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 2. Install Dependencies

```bash
pip install -r requirements.txt
```

### 3. Set Environment Variables

```bash
# Option 1: Export directly
export SLACK_BOT_TOKEN="xoxb-your-token"
export CHANNEL_ID="C0XXXXXXXXX"
export HELPDESK_BOT_ID="B0XXXXXXXXX"

# Option 2: Use .env file with python-dotenv (add to requirements.txt if needed)
```

### 4. Run the Bot

```bash
python main.py
```

## 🔄 How It Works

```
┌─────────────────────────────────────────────────────────────┐
│                    ITSD Reminder Bot                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. 🔍 Fetches today's messages from the channel           │
│                 ↓                                           │
│  2. ⏰ Filters messages older than threshold                │
│                 ↓                                           │
│  3. 🔎 Checks each thread for:                             │
│        • HelpDesk bot replies (category selected)          │
│        • Previous reminders (already notified)             │
│                 ↓                                           │
│  4. 📨 Sends reminder to threads without category          │
│                 ↓                                           │
│  5. 💾 Logs reminded messages to prevent duplicates        │
│                 ↓                                           │
│  6. 😴 Sleeps for configured interval, then repeats        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Message Flow

1. User posts a message in the IT Service Desk channel
2. Bot waits for the configured threshold (default: 3 hours)
3. Bot checks if HelpDesk bot has replied (meaning category was selected)
4. If no HelpDesk response, bot sends a friendly reminder in the thread
5. User gets notified and can then select a category

## 🔧 Troubleshooting

### Common Issues

**Bot not responding:**
- Check if the bot is running: `docker-compose ps`
- Verify logs for errors: `docker-compose logs -f`
- Ensure environment variables are set correctly

**"Missing required environment variables" error:**
- Make sure `.env` file exists and contains all required variables
- Check for typos in variable names

**"channel_not_found" error:**
- Verify the `CHANNEL_ID` is correct
- Ensure the bot is invited to the channel

**"not_in_channel" error:**
- Invite the bot to the channel: `/invite @YourBotName`

**Messages not being detected:**
- Check `AGE_THRESHOLD_SECONDS` - messages must be older than this value
- Verify the bot has `channels:history` permission

### Logs

```bash
# Docker logs
docker-compose logs -f

# Filter for errors
docker-compose logs -f 2>&1 | grep -i error
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is for internal ITSD use.

---

Made with ❤️ by the ITSD Team
