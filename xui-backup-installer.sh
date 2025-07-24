#!/bin/bash

# گرفتن ورودی بدون قاطی شدن
echo "📬 لطفا Bot Token را وارد کنید:"
read BOT_TOKEN

echo "🆔 لطفا Chat ID را وارد کنید:"
read CHAT_ID

# دانلود و آماده‌سازی فایل بک‌آپ
curl -o /usr/local/bin/sendbackup.sh https://raw.githubusercontent.com/HajPorya/xui-backup/main/sendbackup.sh
chmod +x /usr/local/bin/sendbackup.sh

# جایگذاری توکن و چت‌آیدی در فایل بک‌آپ
sed -i "s|YOUR_TOKEN|$BOT_TOKEN|g" /usr/local/bin/sendbackup.sh
sed -i "s|YOUR_CHATID|$CHAT_ID|g" /usr/local/bin/sendbackup.sh

# تنظیم کرون‌جاب برای اجرا هر ۳۰ دقیقه
(crontab -l 2>/dev/null; echo "*/30 * * * * bash /usr/local/bin/sendbackup.sh") | crontab -

# اجرای تست اولیه
echo -e "\n✅ نصب کامل شد. در حال ارسال تست بک‌آپ..."
bash /usr/local/bin/sendbackup.sh
