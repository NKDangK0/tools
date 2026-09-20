#!/bin/bash

# 1. Tắt Google Play Protect và chỉnh DPI màn hình
su -c "settings put global package_verifier_enable 0"
su -c "settings put global upload_apk_enable 0"
su -c "wm size 720x1280"
su -c "wm density 240"
su -c "pkill com.android.systemui"

# Thông báo bắt đầu
echo "=========================================="
echo "      Đang tiến hành cài các ứng dụng     "
echo "=========================================="

# 2. Xoá thư mục cũ và tạo thư mục lưu trữ mới
rm -rf /sdcard/Download/DeltaClones
mkdir -p /sdcard/Download/DeltaClones

# 3. Danh sách link 8 app lấy từ GitHub Release v1.1
LINKS=(
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.01-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.04-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.03-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/DeltaX_QT.No_SameHwi.By.Anya.02-2.738.1397.apk_clone.a"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/termux-boot-app_v0.8.1+github.debug.apk"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/com-cloudflare-onedotonedotonedotone-3837-66752135-ef8"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/ZArchiver_1.0.10_APKPure.apk"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/MT+Manager_2.26.8_APKPure.apk"
)

NAMES=(
  "Delta_1.apk"
  "Delta_2.apk"
  "Delta_3.apk"
  "Delta_4.apk"
  "Termux_Boot.apk"
  "Warp_1111.apk"
  "ZArchiver.apk"
  "MT_Manager.apk"
)

# 4. Vòng lặp tải và ép cài ngầm
for i in "${!LINKS[@]}"; do
    url="${LINKS[$i]}"
    name="${NAMES[$i]}"
    path="/sdcard/Download/DeltaClones/$name"
    
    echo "--------------------------------------------"
    echo "[+] Đang tải $name..."
    curl -L --connect-timeout 15 -o "$path" "$url"
    
    echo "[+] Đang tự động cài $name..."
    su -c "pm install -r -d -g -i com.android.shell '$path'" || su -c "cmd package install -r -d -g '$path'"
done

# Thông báo hoàn tất
echo "=========================================="
echo "    Đã hoàn thành cài đặt những ứng dụng  "
echo "=========================================="
