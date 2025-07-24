#!/bin/bash

# تنظیمات
BOT_TOKEN="توکن_ربات"
CHAT_ID="آیدی_چت"

# زمان
NOW="$(date +'%Y-%m-%d_%H-%M')"

# مسیرها
SOURCE_DB="/etc/x-ui/x-ui.db"
BACKUP_FILE="/root/x-ui-backup-${NOW}.db"

# ساخت بکاپ
cp "$SOURCE_DB" "$BACKUP_FILE"

# ارسال به تلگرام
if [ $? -eq 0 ]; then
  curl -s -F document=@"$BACKUP_FILE" \
       -F caption="Backup from x-ui at ${NOW}" \
       "https://api.telegram.org/bot$BOT_TOKEN/sendDocument?chat_id=$CHAT_ID"
else
  echo "❌ Backup failed: could not copy file."
  exit 1
fi
