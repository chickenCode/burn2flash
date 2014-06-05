#Matt Permenter 2013 - chickenCode
#Find the mountpoint of usb device and make a bootable drive from an iso
#Be sure to run as root or sudo to run the script


function title
{   
	echo ""
	echo "------------------------------"
	echo "|   Auto ISO flash Burner    |"
	echo "------------------------------"
	echo ""
}

function loadSpinner
{
	while(true); 
	do 
		for i in \\ \| \/ -; 
			do echo -n $i; sleep 1; 
			echo -n -e \\r; 
		done; 
	done

}

function getMount
{
	usbFind=$(dmesg | tail -n1)
	mountPoint=${usbFind:29:3}
	dmesg  | grep -i $mountPoint | head -n1
	echo "The flash drive is mounted to dev/$mountPoint"
  
}

function getISO
{
	
	while [ true ];
	  do
		read -p "Please provide full path to ISO image: " path
		if [ -f "$path"  ] && [ ${path: -4} == ".iso" ];
		then
			echo "Loading $path for burning"
			break
		else
			echo "file does not exist or not a valid ISO image, try again"
			echo " "
		fi
	  done
}

function burn2flash
{
    
    echo " "
	echo "Burning image to flash drive "
	echo "____________________________ "
	echo "this could take some time, go have a coffee."
	loadSpinner & dd if=$path of=/dev/$mountPoint ibs=20M obs=20M 
	echo "burn complete, you now have a bootable flash drive"
}

function main
{
	title
	getMount
	getISO
	burn2flash
}

main
