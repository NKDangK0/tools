#!/bin/bash

# ====================================================
# TẮT PLAY PROTECT & CHỈNH DPI MÀN HÌNH
# ====================================================
su -c "settings put global package_verifier_enable 0"
su -c "settings put global upload_apk_enable 0"
su -c "wm size 720x1280"
su -c "wm density 240"
su -c "pkill com.android.systemui"

# Mã màu giao diện Termux
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

clear
echo -e "${CYAN}"
echo "  ██████╗ ███████╗██╗  ████████╗██████╗ "
echo "  ██╔══██╗██╔════╝██║  ╚══██╔══╝██╔══██╗"
echo "  ██║  ██║█████╗  ██║     ██║   ███████║"
echo "  ██║  ██║██╔══╝  ██║     ██║   ██╔══██║"
echo "  ██████╔╝███████╗███████╗██║   ██║  ██║"
echo "  ╚═════╝ ╚══════╝╚══════╝╚═╝   ╚═╝  ╚═╝"
echo -e "${PURPLE}       --- AUTO INSTALLER TOOL v1.3 ---${NC}"
echo "================================================="

# Tạo thư mục tạm
DIR="/sdcard/Download/DeltaClones"
rm -rf "$DIR"
mkdir -p "$DIR"

# ====================================================
# MENU LỰA CHỌN PHIÊN BẢN ỨNG DỤNG
# ====================================================
echo -e "${YELLOW}[?] Bạn muốn cài đặt phiên bản nào?${NC}"
echo -e "  [${GREEN}qt${NC}]  : Delta Quốc Tế (4 Clones)"
echo -e "  [${GREEN}vn${NC}]  : Delta VNG (4 Clones)"
echo -e "  [${GREEN}aus${NC}] : Arceus X Quốc Tế (4 Clones)"
echo "-------------------------------------------------"
read -p "👉 Nhập lựa chọn (qt / vn / aus): " CHOICE

CHOSEN_LINKS=()
CHOSEN_NAMES=()

# Xử lý theo lựa chọn của người dùng
if [[ "$CHOICE" == "vn" || "$CHOICE" == "VN" ]]; then
  echo -e "${GREEN}[✓] Bạn đã chọn: Delta VNG${NC}"
  CHOSEN_LINKS=(
    "https://github.com/NKDangK0/tools/releases/download/v1.1/deltavn1.apk"
    "https://github.com/NKDangK0/tools/releases/download/v1.1/deltavn2.apk"
    "https://github.com/NKDangK0/tools/releases/download/v1.1/deltavn3.apk"
    "https://github.com/NKDangK0/tools/releases/download/v1.1/deltavn4.apk"
  )
  CHOSEN_NAMES=("deltavn1.apk" "deltavn2.apk" "deltavn3.apk" "deltavn4.apk")

elif [[ "$CHOICE" == "aus" || "$CHOICE" == "AUS" ]]; then
  echo -e "${GREEN}[✓] Bạn đã chọn: Arceus X Quốc Tế${NC}"
  CHOSEN_LINKS=(
    "https://github.com/NKDangK0/tools/releases/download/v1.1/arceus1.apk"
    "https://github.com/NKDangK0/tools/releases/download/v1.1/arceus2.apk"
    "https://github.com/NKDangK0/tools/releases/download/v1.1/arceus3.apk"
    "https://github.com/NKDangK0/tools/releases/download/v1.1/arceus4.apk"
  )
  CHOSEN_NAMES=("arceus1.apk" "arceus2.apk" "arceus3.apk" "arceus4.apk")

else
  echo -e "${GREEN}[✓] Mặc định / Lựa chọn: Delta Quốc Tế${NC}"
  CHOSEN_LINKS=(
    "https://github.com/NKDangK0/tools/releases/download/v1.1/delta1.apk"
    "https://github.com/NKDangK0/tools/releases/download/v1.1/delta2.apk"
    "https://github.com/NKDangK0/tools/releases/download/v1.1/delta3.apk"
    "https://github.com/NKDangK0/tools/releases/download/v1.1/delta4.apk"
  )
  CHOSEN_NAMES=("delta1.apk" "delta2.apk" "delta3.apk" "delta4.apk")
fi

# Gộp chung với các app tiện ích cố định (MT Manager, ZArchiver, Warp)
LINKS=(
  "${CHOSEN_LINKS[@]}"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/mtmanager.apk"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/zarchiver.apk"
  "https://github.com/NKDangK0/tools/releases/download/v1.1/warp.apk"
)

NAMES=(
  "${CHOSEN_NAMES[@]}"
  "mtmanager.apk"
  "zarchiver.apk"
  "warp.apk"
)

echo "================================================="
echo -e "${CYAN}    BẮT ĐẦU TIẾN TRÌNH TẢI & CÀI ĐẶT TỰ ĐỘNG${NC}"
echo "================================================="

# Vòng lặp tải và cài đặt
for i in "${!LINKS[@]}"; do
  url="${LINKS[$i]}"
  name="${NAMES[$i]}"
  path="$DIR/$name"

  echo -e "${YELLOW}[+] Đang tải ${name}...${NC}"
  curl -L --connect-timeout 30 -o "$path" "$url"

  if [ -f "$path" ] && [ -s "$path" ]; then
    echo -e "${CYAN}[+] Đang cài đặt ${name}...${NC}"
    if su -c "pm install -r -d -g '$path'" || su -c "cmd package install -r -d -g '$path'"; then
      echo -e "${GREEN}[✓] Cài đặt thành công: ${name}${NC}"
    else
      echo -e "${RED}[!] Lỗi hệ thống khi cài ${name}${NC}"
    fi
  else
    echo -e "${RED}[!] Lỗi: Không tải được file ${name}${NC}"
  fi
  echo "-------------------------------------------------"
done

rm -rf "$DIR"

echo -e "${GREEN}=================================================${NC}"
echo -e "${GREEN}    HOÀN TẤT TOÀN BỘ TIẾN TRÌNH CÀI ĐẶT!     ${NC}"
echo -e "${GREEN}=================================================${NC}"
