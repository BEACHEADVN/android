echo "•Bạn chọn Revancify"

if [ -f /data/data/com.termux/files/home/Revancify/revancify ]
then
	revancify
else
	curl -sL https://github.com/decipher3114/Revancify/raw/refs/heads/main/install.sh | bash
fi