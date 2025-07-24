#!/bin/bash

# -----------------------------------------------------
# 🛡️ Auto Backup Sender for X-UI Panel to Telegram
# 📦 by HajPorya | https://github.com/HajPorya/xui-backup
# -----------------------------------------------------

# 🔧 تنظیمات
BOT_TOKEN="توکن_ربات_خودتو_اینجا_بذار"
CHAT_ID="آیدی_عددی_چت_رو_اینجا_بذار"

# 📅 گرفتن تاریخ و زمان
NOW="$(date +'%Y-%m-%d_%H-%M')"

# 📁 مسیرها
SOURCE_DB="/etc/x-ui/x-ui.db"
BACKUP_FILE="/root/x-ui-backup-${NOW}.db"

# 🛠️ ساخت فایل بکاپ
cp "$SOURCE_DB" "$BACKUP_FILE"

# ✅ اگر کپی موفق بود، بفرست به تلگرام
if [ $? -eq 0 ]; then
  curl -s -F document=@"$BACKUP_FILE" \
       -F caption="🛡️ Backup from x-ui (${NOW})" \
       -F parse_mode=Markdown \
       "https://api.telegram.org/bot$BOT_TOKEN/sendDocument?chat_id=$CHAT_ID"
else
  echo "❌ Backup failed: could not copy file."
  exit 1
fi
