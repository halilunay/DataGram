#!/bin/bash

# Datagram Node Kurulum Script'i
# Ubuntu 24 için hazırlanmıştır

set -e  # Hata durumunda script'i durdur

# Renkli çıktı için
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Datagram Node Kurulum Script'i ===${NC}"

# API key parametresini kontrol et
if [ -z "$1" ]; then
    echo -e "${RED}Hata: API key belirtilmedi!${NC}"
    echo "Kullanım: $0 YOUR_API_KEY"
    echo "Örnek: $0 abc123def456"
    exit 1
fi

API_KEY="$1"

echo -e "${YELLOW}1. Datagram CLI indiriliyor...${NC}"
# Mevcut dosyayı sil (varsa)
if [ -f "datagram-cli-x86_64-linux" ]; then
    rm -f datagram-cli-x86_64-linux
fi

# Son sürümü indir
wget -q --show-progress https://github.com/Datagram-Group/datagram-cli-release/releases/latest/download/datagram-cli-x86_64-linux

echo -e "${YELLOW}2. Dosya /usr/local/bin dizinine taşınıyor...${NC}"
sudo mv datagram-cli-x86_64-linux /usr/local/bin/datagram-cli

echo -e "${YELLOW}3. Çalıştırma izni veriliyor...${NC}"
sudo chmod +x /usr/local/bin/datagram-cli

echo -e "${YELLOW}4. Screen kurulumu kontrol ediliyor...${NC}"
if ! command -v screen &> /dev/null; then
    echo -e "${YELLOW}Screen kurulu değil, kuruluyor...${NC}"
    sudo apt update
    sudo apt install -y screen
fi

echo -e "${YELLOW}5. Datagram node başlatılıyor...${NC}"
echo -e "${GREEN}API Key: $API_KEY${NC}"

# Screen session'ı başlat
screen -dmS datagram bash -c "datagram-cli run -- -key $API_KEY"

echo -e "${GREEN}✅ Kurulum tamamlandı!${NC}"
echo -e "${GREEN}Node 'datagram' isimli screen session'ında çalışıyor.${NC}"
echo ""
echo -e "${YELLOW}Faydalı komutlar:${NC}"
echo "• Node durumunu görmek için: screen -r datagram"
echo "• Screen'den çıkmak için: Ctrl+A sonra D"
echo "• Tüm screen session'larını görmek için: screen -ls"
echo "• Node'u durdurmak için: screen -S datagram -X quit"
echo ""
echo -e "${GREEN}Kurulum başarıyla tamamlandı! 🎉${NC}"
