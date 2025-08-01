# 🛡️ اسکریپت بکاپ‌گیری خودکار X-UI و ارسال به تلگرام

این اسکریپت هر ۳۰ دقیقه، از دیتابیس پنل X-UI بکاپ گرفته و به صورت خودکار از طریق ربات تلگرام برای شما ارسال می‌کند.

---

## ✅ ویژگی‌ها

- گرفتن بکاپ از فایل `/etc/x-ui/x-ui.db`
- ارسال خودکار به تلگرام با Bot Token و Chat ID
- دریافت آدرس آی‌پی یا ساب‌دامین سرور (اختیاری برای نمایش در پیام)
- نصب کرون‌جاب به‌صورت خودکار
- قابلیت آپدیت با یک دستور
- بدون نیاز به تنظیم دستی

---

## 🧰 پیش‌نیازها

- نصب بودن X-UI روی سرور
- داشتن ربات تلگرام از [BotFather](https://t.me/BotFather)
- داشتن Chat ID عددی
- نصب بودن `curl` و `cron`

---

## 🚀 نصب سریع

وارد سرور شوید و دستور زیر را بزنید:

```bash
bash <(curl -s https://raw.githubusercontent.com/HajPorya/xui-backup/main/xui-backup-installer.sh)
