<div align="center">

# 🤖 ITSD Reminder Bot

> **Automated Slack bot for IT Service Desk ticket category reminders**

A Slack bot that monitors your IT Service Desk channel and automatically reminds users to select a category for their tickets when they forget to do so.

![Python](https://img.shields.io/badge/python-3.9+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Docker](https://img.shields.io/badge/docker-ready-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Slack](https://img.shields.io/badge/Slack-integrated-4A154B?style=for-the-badge&logo=slack&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)

---

[Features](#-features) •
[Quick Start](#-quick-start) •
[Configuration](#️-configuration) •
[Contributing](#-contributing)

</div>

---


## ✨ Features

| Feature | Description |
|---------|-------------|
| 🔍 **Automatic Monitoring** | Continuously monitors your Slack channel for new tickets |
| ⏰ **Smart Timing** | Only reminds users after a configurable time threshold |
| 🤖 **HelpDesk Integration** | Detects when HelpDesk bot has already processed a ticket |
| 🔄 **Duplicate Prevention** | Tracks reminded messages to avoid spamming users |
| 🐳 **Docker Ready** | Fully containerized with multi-architecture support (Intel & Apple Silicon) |
| 🔒 **Secure** | Runs as non-root user, credentials via environment variables |

---

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/CaputoDavide93/ITSD-Reminder.git
cd ITSD-Reminder

# Configure environment
cp config/.env.example config/.env
nano config/.env  # Add your Slack credentials

# Run with Docker
docker compose up -d
```

---

## 📦 Prerequisites

### For Docker Deployment (Recommended)

| Requirement | Version |
|-------------|---------|
| 🐳 Docker | 20.10+ |
| 📦 Docker Compose | 2.0+ |

### For Local Development

| Requirement | Version |
|-------------|---------|
| 🐍 Python | 3.9+ |
| 📦 pip | Latest |

### Slack Bot Setup

<details>
<summary><strong>📋 Step-by-Step Guide</strong></summary>

#### Step 1: Create a Slack App
1. Go to [api.slack.com/apps](https://api.slack.com/apps)
2. Click "Create New App" → "From scratch"
3. Enter an App Name (e.g., "ITSD Reminder Bot")
4. Select your workspace and click "Create App"

#### Step 2: Configure Bot Permissions
1. Navigate to "OAuth & Permissions"
2. Add these **Bot Token Scopes**:

| Scope | Purpose |
|-------|---------|
| `channels:history` | Read messages from public channels |
| `channels:read` | View basic channel info |
| `chat:write` | Send reminder messages |
| `users:read` | Get user information for mentions |

#### Step 3: Install the App
1. Click "Install to Workspace"
2. Review permissions and click "Allow"
3. Copy the **Bot User OAuth Token** (starts with `xoxb-`)

#### Step 4: Invite Bot to Channel
1. Open your IT Service Desk channel in Slack
2. Type `/invite @YourBotName`

</details>

---

## ⚙️ Configuration

### Environment Variables

| Variable | Required | Default | Description |
|----------|:--------:|---------|-------------|
| `SLACK_BOT_TOKEN` | ✅ | - | Your Slack Bot OAuth Token |
| `CHANNEL_ID` | ✅ | - | The Slack channel ID to monitor |
| `HELPDESK_BOT_ID` | ✅ | - | The HelpDesk bot's ID |
| `AGE_THRESHOLD_SECONDS` | ❌ | `10800` | Time to wait before sending reminder (3 hours) |
| `CHECK_INTERVAL_HOURS` | ❌ | `2` | How often to check for new messages |

### Example Configuration

```bash
# config/.env
SLACK_BOT_TOKEN=xoxb-your-token-here
CHANNEL_ID=C0XXXXXXXXX
HELPDESK_BOT_ID=B0XXXXXXXXX
AGE_THRESHOLD_SECONDS=10800
CHECK_INTERVAL_HOURS=2
```

> ⚠️ **Security Note**: Never commit your `.env` file to version control!

---

## 🐳 Docker Deployment

### Multi-Architecture Support

This image supports both Intel/AMD64 and Apple Silicon (ARM64).

### Build and Run

```bash
# Build and start
docker compose up -d

# View logs
docker compose logs -f

# Stop the service
docker compose down

# Rebuild after code changes
docker compose up -d --build
```

---

## 💻 Running Locally

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Set environment variables
export SLACK_BOT_TOKEN="xoxb-your-token"
export CHANNEL_ID="C0XXXXXXXXX"
export HELPDESK_BOT_ID="B0XXXXXXXXX"

# Run the bot
python src/main.py
```

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    ITSD Reminder Bot                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. 🔍 Fetches today's messages from the channel           │
│                 ↓                                           │
│  2. ⏰ Filters messages older than threshold                │
│                 ↓                                           │
│  3. 🔎 Checks each thread for HelpDesk bot replies         │
│                 ↓                                           │
│  4. 📨 Sends reminder to threads without category          │
│                 ↓                                           │
│  5. 💾 Logs reminded messages to prevent duplicates        │
│                 ↓                                           │
│  6. 😴 Sleeps for configured interval, then repeats        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 Project Structure

```
ITSD-Reminder/
├── 📁 src/                    # Source code
│   ├── __init__.py
│   └── main.py                # Main bot logic
├── 📁 config/                 # Configuration
│   ├── .env.example           # Template (safe to commit)
│   └── .env                   # Your secrets (gitignored)
├── 📁 data/                   # Runtime data (gitignored)
│   └── reminded_messages.json
├── 🐳 Dockerfile              # Multi-arch Docker image
├── 🐳 docker-compose.yml      # Docker orchestration
├── 📋 requirements.txt        # Python dependencies
├── 📜 LICENSE                 # MIT License
├── 🤝 CONTRIBUTING.md         # Contribution guidelines
├── 🔐 SECURITY.md             # Security policy
└── 📖 README.md               # This file
```

---

## 🔧 Troubleshooting

<details>
<summary><strong>❌ Bot not responding</strong></summary>

- Check if the bot is running: `docker compose ps`
- Verify logs for errors: `docker compose logs -f`
- Ensure environment variables are set correctly
</details>

<details>
<summary><strong>❌ "channel_not_found" error</strong></summary>

- Verify the `CHANNEL_ID` is correct
- Ensure the bot is invited to the channel: `/invite @YourBotName`
</details>

<details>
<summary><strong>❌ Messages not being detected</strong></summary>

- Check `AGE_THRESHOLD_SECONDS` - messages must be older than this value
- Verify the bot has `channels:history` permission
</details>

---

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details.

1. 🍴 Fork the repository
2. 🌿 Create a feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 Commit your changes (`git commit -m 'Add amazing feature'`)
4. 📤 Push to the branch (`git push origin feature/amazing-feature`)
5. 🔃 Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

<div align="center">

**Davide Caputo**

[![GitHub](https://img.shields.io/badge/GitHub-@CaputoDavide93-181717?style=flat-square&logo=github)](https://github.com/CaputoDavide93)
[![Email](https://img.shields.io/badge/Email-CaputoDav@gmail.com-EA4335?style=flat-square&logo=gmail&logoColor=white)](mailto:CaputoDav@gmail.com)

---

<sub>Made with ❤️ for IT Service Desk teams</sub>

</div>
