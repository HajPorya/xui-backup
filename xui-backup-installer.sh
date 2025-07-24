#!/bin/bash

# 📦 دریافت توکن ربات تلگرام
read -p "🤖 لطفا Bot Token ربات تلگرام را وارد کنید: " BOT_TOKEN

# 💬 دریافت Chat ID
read -p "🆔 لطفا Chat ID را وارد کنید: " CHAT_ID

# ⏬ دانلود فایل اصلی بک‌آپ
curl -o /usr/local/bin/sendbackup.sh https://raw.githubusercontent.com/HajPorya/xui-backup/main/sendbackup.sh
chmod +x /usr/local/bin/sendbackup.sh

# 🧠 جایگزینی مقادیر در فایل
sed -i "s|YOUR_TOKEN|$BOT_TOKEN|g" /usr/local/bin/sendbackup.sh
sed -i "s|YOUR_CHATID|$CHAT_ID|g" /usr/local/bin/sendbackup.sh

# ⏱️ تنظیم کرون‌جاب هر ۳۰ دقیقه
(crontab -l 2>/dev/null; echo "*/30 * * * * /usr/local/bin/sendbackup.sh") | crontab -

# 🧪 اجرای تست برای اطمینان
echo -e "\n✅ نصب کامل شد. در حال ارسال تست بک‌آپ..."
bash /usr/local/bin/sendbackup.sh
