#!/bin/bash

BOT_TOKEN="7543185099:AAH61Nd5Zmp5iyN0GiaY_KmB4Kprdo8-8ik"
CHAT_ID="1798987189"

NOW="$(date +'%Y-%m-%d_%H-%M')"
SOURCE_DB="/etc/x-ui/x-ui.db"
BACKUP_FILE="/root/x-ui-backup-${NOW}.db"

if [ -f "$SOURCE_DB" ]; then
  cp "$SOURCE_DB" "$BACKUP_FILE"

  # پیام بدون کاراکتر خاص برای جلوگیری از خطای offset
  MESSAGE="X-UI Backup: $NOW"

  curl -s -F document=@"$BACKUP_FILE" \
       -F caption="$MESSAGE" \
       "https://api.telegram.org/bot$BOT_TOKEN/sendDocument?chat_id=$CHAT_ID"
else
  echo "❌ فایل دیتابیس پیدا نشد: $SOURCE_DB"
  exit 1
fi
