#!/bin/bash

echo "🔧 نصب اسکریپت بکاپ‌گیر X-UI آغاز شد..."

# دریافت اطلاعات از کاربر
read -p "📬 توکن ربات تلگرام را وارد کنید: " TOKEN
read -p "🆔 آیدی عددی چت را وارد کنید: " CHATID

# کلون کردن ریپو (اگر لازم بود)
if [ ! -d "xui-backup" ]; then
  git clone https://github.com/HajPorya/xui-backup.git
fi

cd xui-backup || exit

# جایگزینی TOKEN و CHATID در فایل sendbackup.sh
sed -i "s/YOUR_TOKEN/$TOKEN/" sendbackup.sh
sed -i "s/YOUR_CHATID/$CHATID/" sendbackup.sh

# دادن دسترسی اجرا
chmod +x sendbackup.sh

# افزودن به کرون‌جاب برای اجرا هر ۳۰ دقیقه
croncmd="$(pwd)/sendbackup.sh"
(crontab -l 2>/dev/null; echo "*/30 * * * * $croncmd") | crontab -

echo "✅ نصب تکمیل شد. اسکریپت هر ۳۰ دقیقه اجرا می‌شود."
echo "📦 در حال ارسال اولین بک‌آپ تستی برای اطمینان..."
/usr/local/bin/sendbackup.sh
