if [ -z "$1" ]
then
    echo "version is empty."
	exit 1
fi

url="https://www.taosdata.com/download/download-all.php?pkgType=tdengine_linux&pkgName=TDengine-client-$1-Linux-x64.tar.gz"
zip="TDengine-client.tar.gz"
wget --read-timeout==240 -O "$zip" "$url"

if ! [ -e $zip ]
then
	echo "Not downloaded to the installation package."
	exit 2
fi

dir="TDengine-client"
tar -zxvf "$zip"
rm "$zip"

if ! [ -e $dir ]
then
	echo "Failed to decompress Taos client."
	exit 3
fi

cd "$dir"
for file in ./*
do
	if [ -x $file -a ! -d $file ]
	then
		./"$file"
	fi
done

cd ../
rm -rf "$dir"
