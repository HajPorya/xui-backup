#!/bin/bash

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="sendbackup.sh"
SCRIPT_PATH="$INSTALL_DIR/$SCRIPT_NAME"
REPO_URL="https://raw.githubusercontent.com/HajPorya/xui-backup/main/$SCRIPT_NAME"

function install_script() {
  echo "✅ در حال نصب اسکریپت بکاپ..."
  
  read -p "🟡 لطفا Bot Token را وارد کنید: " BOT_TOKEN
  read -p "🟡 لطفا Chat ID را وارد کنید: " CHAT_ID

  cat > "$SCRIPT_PATH" <<EOF
#!/bin/bash
BOT_TOKEN="$BOT_TOKEN"
CHAT_ID="$CHAT_ID"
NOW=\$(date +"%Y-%m-%d_%H-%M")
SOURCE_DB="/etc/x-ui/x-ui.db"
BACKUP_FILE="/root/x-ui-backup-\${NOW}.db"

if [ -f "\$SOURCE_DB" ]; then
  cp "\$SOURCE_DB" "\$BACKUP_FILE"
  MESSAGE="X-UI Backup: \$NOW"
  curl -s -F document=@"\$BACKUP_FILE" -F caption="\$MESSAGE" "https://api.telegram.org/bot\$BOT_TOKEN/sendDocument?chat_id=\$CHAT_ID"
else
  echo "❌ فایل دیتابیس پیدا نشد"
  exit 1
fi
EOF

  chmod +x "$SCRIPT_PATH"
  echo "✅ نصب کامل شد. می‌توانید با اجرای دستور زیر تست کنید:"
  echo "bash $SCRIPT_PATH"
}

function update_script() {
  echo "🔄 در حال آپدیت اسکریپت از GitHub..."
  curl -s -o "$SCRIPT_PATH" "$REPO_URL"
  chmod +x "$SCRIPT_PATH"
  echo "✅ آپدیت انجام شد."
}

# اگر دستور update اجرا شد فقط آپدیت کند
if [[ "$1" == "update" ]]; then
  update_script
  exit 0
fi

install_script
