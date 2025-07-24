#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

NOW=$(date "+%Y-%m-%d_%H-%M")
BACKUP_PATH="/tmp/x-ui-backup-$NOW.db"

cp /etc/x-ui/x-ui.db "$BACKUP_PATH"

echo -e "${YELLOW}📦 در حال ارسال بک‌آپ به تلگرام ..."

RESPONSE=$(curl -s -F document=@"$BACKUP_PATH" "https://api.telegram.org/botYOUR_TOKEN/sendDocument?chat_id=YOUR_CHATID&caption=📦 Backup from x-ui ($(hostname -I | awk '{print $1}') | $NOW)")

if [[ "$RESPONSE" == *'"ok":true'* ]]; then
  echo -e "${GREEN}✅ بک‌آپ با موفقیت ارسال شد.${NC}"
else
  echo -e "${YELLOW}⚠️ ارسال بک‌آپ با خطا مواجه شد."
  echo "$RESPONSE"
fi
