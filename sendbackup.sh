#!/bin/bash

# 🛠 تنظیمات
BOT_TOKEN="توکن_ربات_خودتو_اینجا_بذار"
CHAT_ID="آیدی_چت_عددی_رو_اینجا_بذار"

# 🗓 گرفتن تاریخ و زمان
NOW="$(date +'%Y-%m-%d_%H-%M')"

# 📁 مسیر فایل‌ها
SOURCE_DB="/etc/x-ui/x-ui.db"
BACKUP_FILE="/root/x-ui-backup-${NOW}.db"

# 🧱 ساخت فایل بکاپ
cp "$SOURCE_DB" "$BACKUP_FILE"

# 📤 ارسال فایل اگر موفق بود
if [ $? -eq 0 ]; then
  curl -s -F document=@"$BACKUP_FILE" \
       -F caption="Backup from x-ui ${NOW}" \
       "https://api.telegram.org/bot$BOT_TOKEN/sendDocument?chat_id=$CHAT_ID"
else
  echo "❌ Backup failed: could not copy file."
  exit 1
fi
