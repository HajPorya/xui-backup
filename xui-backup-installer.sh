#!/bin/bash

# درخواست توکن ربات تلگرام
echo "🔐 لطفاً توکن ربات تلگرام را وارد کنید:"
read -p "BOT_TOKEN: " BOT_TOKEN

# درخواست Chat ID
echo "💬 لطفاً Chat ID مربوط به دریافت فایل بک‌آپ را وارد کنید:"
read -p "CHAT_ID: " CHAT_ID

# درخواست دامنه یا آی‌پی
echo "🌐 لطفاً دامنه یا آدرس آی‌پی سرور را وارد کنید:"
read -p "SERVER_ADDRESS: " SERVER_ADDRESS

# ساخت اسکریپت بک‌آپ
cat <<EOF > /usr/local/bin/sendbackup.sh
#!/bin/bash
NOW=\$(date "+%Y-%m-%d_%H-%M")
BACKUP_PATH="/tmp/x-ui-backup-\$NOW.db"
cp /etc/x-ui/x-ui.db "\$BACKUP_PATH"
curl -s -F document=@"\$BACKUP_PATH" "https://api.telegram.org/bot$BOT_TOKEN/sendDocument?chat_id=$CHAT_ID&caption=Backup%20from%20x-ui%20(\$NOW)"
EOF

# دسترسی اجرایی بده به اسکریپت
chmod +x /usr/local/bin/sendbackup.sh

# بررسی اینکه کرون قبلاً اضافه شده یا نه
if crontab -l | grep -q "/usr/local/bin/sendbackup.sh"; then
  echo "⚠️ کرون‌جاب از قبل وجود دارد. چیزی تغییر نکرد."
else
  (crontab -l 2>/dev/null; echo "*/30 * * * * /usr/local/bin/sendbackup.sh") | crontab -
  echo "✅ کرون‌جاب اضافه شد: هر ۳۰ دقیقه بک‌آپ به تلگرام ارسال می‌شود."
fi

echo "✅ نصب کامل شد!"
