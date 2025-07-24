#!/bin/bash

BOT_TOKEN="توکن_ربات_تو"
CHAT_ID="آیدی_چت_تو"

NOW="$(date +'%Y-%m-%d_%H-%M')"
SOURCE_DB="/etc/x-ui/x-ui.db"
BACKUP_FILE="/root/x-ui-backup-${NOW}.db"

if [ -f "$SOURCE_DB" ]; then
  cp "$SOURCE_DB" "$BACKUP_FILE"
  curl -s -F document=@"$BACKUP_FILE" \
       -F caption="📦 X-UI Backup – ${NOW}" \
       "https://api.telegram.org/bot$BOT_TOKEN/sendDocument?chat_id=$CHAT_ID"
else
  echo "❌ Backup failed: فایل دیتابیس پیدا نشد → $SOURCE_DB"
  exit 1
fi
