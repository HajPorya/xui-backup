#!/bin/bash

# ----------------------------------------------
# 📦 Installer for X-UI to Telegram Auto Backup
# 🔧 by HajPorya | https://github.com/HajPorya/xui-backup
# ----------------------------------------------

echo -e "\n📥 نصب اسکریپت ارسال بکاپ X-UI به تلگرام..."

# دریافت توکن و آیدی چت
read -p "🤖 لطفا Bot Token را وارد کنید: " BOT_TOKEN
read -p "🆔 لطفا Chat ID را وارد کنید: " CHAT_ID

# ساخت فایل اسکریپت
cat <<EOF > /usr/local/bin/sendbackup.sh
#!/bin/bash

BOT_TOKEN="$BOT_TOKEN"
CHAT_ID="$CHAT_ID"
NOW="\$(date +'%Y-%m-%d_%H-%M')"
SOURCE_DB="/etc/x-ui/x-ui.db"
BACKUP_FILE="/root/x-ui-backup-\${NOW}.db"

cp "\$SOURCE_DB" "\$BACKUP_FILE"

if [ \$? -eq 0 ]; then
  curl -s -F document=@"\$BACKUP_FILE" \\
       -F caption="🛡️ Backup from x-ui (\${NOW})" \\
       -F parse_mode=Markdown \\
       "https://api.telegram.org/bot\$BOT_TOKEN/sendDocument?chat_id=\$CHAT_ID"
else
  echo "❌ Backup failed: could not copy file."
  exit 1
fi
EOF

# مجوز اجرا
chmod +x /usr/local/bin/sendbackup.sh

# اجرای تست بکاپ
echo -e "\n🧪 در حال ارسال اولین بکاپ تستی برای اطمینان..."
bash /usr/local/bin/sendbackup.sh

# پایان
echo -e "\n✅ نصب کامل شد. بکاپ‌ها را از این پس می‌توانید با اجرای دستور زیر ارسال کنید:"
echo "bash /usr/local/bin/sendbackup.sh"
