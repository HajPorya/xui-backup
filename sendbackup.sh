#!/bin/bash

# مسیر فایل اصلی بک‌آپ
SOURCE="/etc/x-ui/x-ui.db"
DEST="/root/x-ui.db"

# توکن و آیدی ربات - به‌صورت متغیر (قبلاً ست شده با sed)
TOKEN="YOUR_TOKEN"
CHAT_ID="YOUR_CHATID"

# بررسی وجود فایل و دسترسی
if [ -f "$SOURCE" ]; then
  cp "$SOURCE" "$DEST"

  if [ -f "$DEST" ]; then
    curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendDocument" \
      -F document=@"$DEST" \
      -F chat_id="$CHAT_ID" \
      -F caption="Backup from x-ui ($(date +%F_%H-%M))"
  else
    curl -s "https://api.telegram.org/bot$TOKEN/sendMessage?chat_id=$CHAT_ID&text=❌ کپی فایل بک‌آپ با خطا مواجه شد."
  fi

else
  curl -s "https://api.telegram.org/bot$TOKEN/sendMessage?chat_id=$CHAT_ID&text=❌ فایل بک‌آپ x-ui پیدا نشد!"
fi
