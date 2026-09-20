#!/usr/bin/env bash

# 1. Cấu hình hệ thống bằng quyền Root
su -c "settings put system user_rotation 0"
su -c "wm density 180"
su -c "settings put global package_verifier_enable 0"

# Thông báo bắt đầu
echo "=========================================="
echo "      Đang tiến hành cài các ứng dụng     "
echo "=========================================="

# 2. Danh sách 8 file APK
LINKS=(
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.01-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.04-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.03-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.02-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/com-cloudflare-onedotonedotonedotone-3837-66752135-ef8"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/MT+Manager_2.26.8_APKPure.apk"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/termux-boot-app_v0.8.1+github.debug.apk"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/ZArchiver_1.0.10_APKPure.apk"
)

# 3. Tạo thư mục tạm bằng Root
DEST_DIR="/data/local/tmp/installer_apks"
su -c "mkdir -p '$DEST_DIR'"

# 4. Tiến hành tải và cài đặt
for url in "${LINKS[@]}"; do
  filename=$(basename "$url")
  filepath="$DEST_DIR/$filename"

  if [[ "$filepath" != *.apk ]]; then
    filepath="${filepath}.apk"
  fi

  echo "--> Đang tải: $filename..."
  # Tải trực tiếp bằng quyền Root để không bị chặn
  su -c "curl -L -s -o '$filepath' '$url'"

  echo "--> Đang cài đặt: $(basename "$filepath")..."
  # Cài đặt và hiển thị kết quả trực tiếp ra màn hình
  su -c "pm install -r '$filepath'"
  su -c "rm -f '$filepath'"
done

# Dọn dẹp
su -c "rm -rf '$DEST_DIR'"

# Thông báo hoàn tất
echo "=========================================="
echo "    Đã hoàn thành cài đặt những ứng dụng  "
echo "=========================================="
