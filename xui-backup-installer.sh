#!/bin/bash

# دریافت توکن ربات تلگرام
echo -n "📬 لطفا Bot Token را وارد کنید: "
read BOT_TOKEN

# دریافت Chat ID
echo -n "🆔 لطفا Chat ID را وارد کنید: "
read CHAT_ID

# 📥 دانلود فایل اصلی بک‌آپ
curl -o /usr/local/bin/sendbackup.sh https://raw.githubusercontent.com/HajPorya/xui-backup/main/sendbackup.sh
chmod +x /usr/local/bin/sendbackup.sh

# 🧠 جایگزینی توکن و چت‌آیدی در فایل
sed -i "s|YOUR_TOKEN|$BOT_TOKEN|g" /usr/local/bin/sendbackup.sh
sed -i "s|YOUR_CHATID|$CHAT_ID|g" /usr/local/bin/sendbackup.sh

# ⏱️ تنظیم کرون‌جاب هر ۳۰ دقیقه
(crontab -l 2>/dev/null; echo "*/30 * * * * bash /usr/local/bin/sendbackup.sh") | crontab -

# 🧪 اجرای تست برای اطمینان از نصب
echo -e "\n✅ نصب کامل شد. در حال ارسال تست بک‌آپ..."
bash /usr/local/bin/sendbackup.sh
