echo "•Bạn chọn Revancify"

if [ -f /data/data/com.termux/files/home/Revancify/revancify ]
then
	path="/data/data/com.termux/files/home/revancify-data"
	temp="/storage/emulated/0/Download/ext/temp/jar"
	inotia00_data=".inotia00-data"
	rm -rf $temp
	mkdir -p $temp
	echo "•Restore file jar đã backup"
	for file in "$path"/*patch*.jar.backup
	do
		mv -f "$file" "${file%.backup}"
	done
	revancify
else
	pkg update -y && pkg install git -y && git clone https://github.com/decipher3114/Revancify.git && ./Revancify/revancify
fi