#!/bin/bash

echo "🔐 لطفاً توکن ربات تلگرام را وارد کنید:"
read -p "BOT_TOKEN: " BOT_TOKEN

echo "💬 لطفاً Chat ID مربوط به دریافت فایل بک‌آپ را وارد کنید:"
read -p "CHAT_ID: " CHAT_ID

echo "🌐 لطفاً دامنه یا آدرس آی‌پی سرور را وارد کنید:"
read -p "SERVER_ADDRESS: " SERVER_ADDRESS

# ساخت اسکریپت بک‌آپ با ظاهر گرافیکی
cat <<EOF > /usr/local/bin/sendbackup.sh
#!/bin/bash

GREEN='\\033[0;32m'
YELLOW='\\033[1;33m'
NC='\\033[0m'

NOW=\$(date "+%Y-%m-%d_%H-%M")
BACKUP_PATH="/tmp/x-ui-backup-\$NOW.db"
cp /etc/x-ui/x-ui.db "\$BACKUP_PATH"

echo -e "\${YELLOW}📦 در حال ارسال بک‌آپ به تلگرام...\${NC}"

RESPONSE=\$(curl -s -F document=@"\$BACKUP_PATH" \\
"https://api.telegram.org/bot__BOT_TOKEN__/sendDocument?chat_id=__CHAT_ID__&caption=🛡️ Backup from x-ui 🌐 (__SERVER_ADDRESS__ | \$NOW)")

if [[ "\$RESPONSE" == *'"ok":true'* ]]; then
    echo -e "\${GREEN}✅ بک‌آپ با موفقیت ارسال شد!\${NC}"
    echo -e "\${GREEN}📁 مسیر فایل: \$BACKUP_PATH\${NC}"
else
    echo -e "\${YELLOW}⚠️ ارسال بک‌آپ با خطا مواجه شد!\${NC}"
    echo "\$RESPONSE"
fi
EOF

# جایگزینی مقادیر توکن، چت آیدی، آدرس
sed -i "s|__BOT_TOKEN__|$BOT_TOKEN|g" /usr/local/bin/sendbackup.sh
sed -i "s|__CHAT_ID__|$CHAT_ID|g" /usr/local/bin/sendbackup.sh
sed -i "s|__SERVER_ADDRESS__|$SERVER_ADDRESS|g" /usr/local/bin/sendbackup.sh

# اجازه اجرا بده
chmod +x /usr/local/bin/sendbackup.sh

# کرون‌جاب اضافه کن
if crontab -l | grep -q "/usr/local/bin/sendbackup.sh"; then
  echo "⚠️ کرون‌جاب از قبل وجود دارد. چیزی تغییر نکرد."
else
  (crontab -l 2>/dev/null; echo "*/30 * * * * /usr/local/bin/sendbackup.sh") | crontab -
  echo "✅ کرون‌جاب اضافه شد: هر ۳۰ دقیقه بک‌آپ ارسال می‌شود."
fi

echo "✅ نصب کامل شد!"
