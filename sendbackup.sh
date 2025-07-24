#!/bin/bash
BOT_TOKEN="اینجا نباید چیزی باشه"
CHAT_ID="اینجا نباید چیزی باشه"

NOW=$(date +"%Y-%m-%d_%H-%M")
SOURCE_DB="/etc/x-ui/x-ui.db"
BACKUP_FILE="/root/x-ui-backup-${NOW}.db"

if [ -f "$SOURCE_DB" ]; then
  cp "$SOURCE_DB" "$BACKUP_FILE"
  MESSAGE="X-UI Backup: $NOW"
  curl -s -F document=@"$BACKUP_FILE" -F caption="$MESSAGE" "https://api.telegram.org/bot$BOT_TOKEN/sendDocument?chat_id=$CHAT_ID"
else
  echo "❌ فایل دیتابیس پیدا نشد"
  exit 1
fi
