#!/bin/bash

# توکن و آیدی ربات را اینجا وارد کنید
BOT_TOKEN="توکن_ربات"
CHAT_ID="آیدی_چت"

# زمان فعلی برای نام فایل
NOW="$(date +'%Y-%m-%d_%H-%M')"

# مسیر فایل دیتابیس و بکاپ
SOURCE_DB="/etc/x-ui/x-ui.db"
BACKUP_FILE="/root/x-ui-backup-${NOW}.db"

# کپی فایل بکاپ
cp "$SOURCE_DB" "$BACKUP_FILE"

# بررسی موفقیت کپی و ارسال فایل
if [ $? -eq 0 ]; then
  curl -s -F document=@"$BACKUP_FILE" \
       -F caption="Backup file from x-ui at $NOW" \
       "https://api.telegram.org/bot$BOT_TOKEN/sendDocument?chat_id=$CHAT_ID"
else
  echo "❌ Backup failed: could not copy file."
  exit 1
fi
