clear

#!/data/data/com.termux/files/usr/bin/bash

function core {
	echo "-Core $x:"
	echo "   CPU Maximum Frequency: `cat /sys/devices/system/cpu/cpu$x/cpufreq/scaling_max_freq` MHz"
	echo "   CPU Minimum Frequency: `cat /sys/devices/system/cpu/cpu$x/cpufreq/scaling_min_freq` MHz"
	echo "   Governor: `cat /sys/devices/system/cpu/cpu$x/cpufreq/scaling_governor`"
	a=`su -c "cat /sys/devices/system/cpu/cpu$x/online"`
	if [ $a == 1 ]
	then
		echo "   Trạng thái: Bật"
	else
		echo "   Trạng thái: Tắt"
	fi
}

x=0
while [ $x -le 7 ]
do
	core
	x=$(( $x + 1 ))
done

echo "Bạn muốn bật hay tắt nhân:"
echo "1. BẬT"
echo "2. TẮT"
echo "Nhập số từ 1-2:"
read onoff
case $onoff in
	1)
		clear
		echo "Chọn nhân muốn bật:"
		echo "1. TOÀN BỘ"
		echo "2. ĐƠN LẺ"
		echo "Nhập số từ 1-2:"
		read core
		
		case $core in
			1)
				x=0
				while [ $x -le 7 ]
				do
					echo "Bật nhân $x"
					su -c "chmod 777 /sys/devices/system/cpu/cpu$x/online"
					su -c "echo 1 > /sys/devices/system/cpu/cpu$x/online"
					su -c "chmod 444 /sys/devices/system/cpu/cpu$x/online"
					x=$(( $x + 1 ))
				done
			;;
			2)
				clear
				echo "Nhập số từ 0-7(không cần dấu cách, không cần theo thứ tự):"
				read core1
				value=$core1
				arr=()
				for ((i = 0; i < ${#value}; i++)); do
					arr+=(${value:$i:1})
				done
				
				for x in "${arr[@]}"; do
				    echo "Bật nhân $x"
					su -c "chmod 777 /sys/devices/system/cpu/cpu$x/online"
					su -c "echo 1 > /sys/devices/system/cpu/cpu$x/online"
					su -c "chmod 444 /sys/devices/system/cpu/cpu$x/online"
				done
			;;
		esac
	;;
	2)
		clear
		echo "Chọn nhân muốn tắt:"
		echo "1. ĐA NHÂN(5-6-7)"
		echo "2. ĐƠN LẺ"
		echo "Nhập số từ 1-2:"
		read core
		
		case $core in
			1)
				echo "Tắt nhân 7"
				su -c "chmod 777 /sys/devices/system/cpu/cpu7/online"
				su -c "echo 0 > /sys/devices/system/cpu/cpu7/online"
				su -c "chmod 444 /sys/devices/system/cpu/cpu7/online"
				echo "Tắt nhân 6"
				su -c "chmod 777 /sys/devices/system/cpu/cpu6/online"
				su -c "echo 0 > /sys/devices/system/cpu/cpu6/online"
				su -c "chmod 444 /sys/devices/system/cpu/cpu6/online"
				echo "Tắt nhân 5"
				su -c "chmod 777 /sys/devices/system/cpu/cpu5/online"
				su -c "echo 0 > /sys/devices/system/cpu/cpu5/online"
				su -c "chmod 444 /sys/devices/system/cpu/cpu5/online"
			;;
			2)
				clear
				echo "Nhập số từ 0-7(không cần dấu cách, không cần theo thứ tự):"
				read core1
				value=$core1
				arr=()
				for ((i = 0; i < ${#value}; i++)); do
					arr+=(${value:$i:1})
				done
				
				for x in "${arr[@]}"; do
					echo "Tắt nhân $x"
					su -c "chmod 777 /sys/devices/system/cpu/cpu$x/online"
					su -c "echo 0 > /sys/devices/system/cpu/cpu$x/online"
					su -c "chmod 444 /sys/devices/system/cpu/cpu$x/online"
				done
			;;
		esac
	;;
esac