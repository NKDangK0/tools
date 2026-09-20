#!/usr/bin/env bash

# Cấu hình cài đặt hệ thống
settings put system user_rotation 0
wm density 180
settings put global package_verifier_enable 0

# Thông báo bắt đầu
echo "=========================================="
echo "      Đang tiến hành cài các ứng dụng     "
echo "=========================================="

# Danh sách 8 file APK trực tiếp từ GitHub Release v1.1
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

# Tạo thư mục lưu file tạm
DEST_DIR="/sdcard/Download/installer_apks"
mkdir -p "$DEST_DIR"

# Vòng lặp tải và cài đặt
for url in "${LINKS[@]}"; do
  filename=$(basename "$url")
  filepath="$DEST_DIR/$filename"

  # Thêm đuôi .apk nếu file chưa có để Android cài đặt bình thường
  if [[ "$filepath" != *.apk ]]; then
    filepath="${filepath}.apk"
  fi

  echo "--> Đang tải: $filename..."
  curl -L -s -o "$filepath" "$url"

  if [ -f "$filepath" ]; then
    echo "--> Đang cài đặt: $(basename "$filepath")...."
    pm install -r "$filepath" > /dev/null 2>&1
    rm -f "$filepath"
  fi
done

# Dọn dẹp thư mục tạm
rm -rf "$DEST_DIR"

# Thông báo hoàn tất
echo "=========================================="
echo "    Đã hoàn thành cài đặt những ứng dụng  "
echo "=========================================="
