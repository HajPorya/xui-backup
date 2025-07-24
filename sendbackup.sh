#!/bin/bash

# -----------------------------------------------
# 🛡️ Auto Backup Sender for X-UI Panel to Telegram
# 📦 by HajPorya | https://github.com/HajPorya/xui-backup
# -----------------------------------------------

# 🔧 Configuration
BOT_TOKEN="PASTE_YOUR_BOT_TOKEN_HERE"
CHAT_ID="PASTE_YOUR_CHAT_ID_HERE"

# 📅 Generate timestamp
NOW=$(date +"%Y-%m-%d_%H-%M")

# 📁 Paths
SOURCE_DB="/etc/x-ui/x-ui.db"
BACKUP_FILE="/root/x-ui-backup-$NOW.db"

# 🔄 Copy backup file
cp "$SOURCE_DB" "$BACKUP_FILE"

# ✅ If successful, send file to Telegram
if [ $? -eq 0 ]; then
    curl -s -F document=@"$BACKUP_FILE" \
         -F caption="🛡️ *Backup from x-ui* (`$NOW`)" \
         -F parse_mode=Markdown \
         "https://api.telegram.org/bot$BOT_TOKEN/sendDocument?chat_id=$CHAT_ID"
else
    echo "❌ Backup failed: could not copy file"
    exit 1
fi
