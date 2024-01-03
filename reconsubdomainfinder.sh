#!/bin/bash
# HomeBrewedByChickenN00dles

url=$1



if [ ! -d "$url" ];then
	mkdir $url
fi

if [ ! -d "$url/amass" ];then
	mkdir $url/amass
fi

if [ ! -d "$url/subfinder" ];then
	mkdir $url/subfinder
fi

if [ ! -d "$url/crtsh" ];then
	mkdir $url/crtsh
fi

if [ ! -d "$url/assetfinder" ];then
	mkdir $url/assetfinder
fi

if [ ! -d "$url/combined" ];then
	mkdir $url/combined
fi

if [ ! -d "$url/httprpobe" ];then
	mkdir $url/httprpobe
fi

if [ ! -d "$url/httpx" ];then
	mkdir $url/httpx
fi



function amassscan(){
	cowsay "Scanning with amass may take a while please wait" | lolcat
	
	amass enum -d $url >> $url/amass/$url.amassresult.txt
	awk '{print $1}' $url/amass/$url.amassresult.txt | sed -e 's/^[^(]*\.(com|net)//' -e 's/[()]//g' >> $url/amass/$url.amassfinal.txt
	rm $url/amass/$url.amassresult.txt
	
	sleep 3
	echo -n "Finishing please wait: " | lolcat
	for i in {1..50}; do
	    echo -n "#"
	    sleep 0.1
	done | pv -lep -s 50 > /dev/null
	echo -e "\nProcess completed!" | lolcat
	echo " "
	echo " "

	

}
amassscan


function scanningsubfinder() {
	
	cowsay "Scanning with Subfinder" | lolcat
	
	subfinder -d $url >> $url/subfinder/$url.subfinderresult.txt
	
	echo " "
	echo " "
	echo "Proccess Completed" | lolcat
	echo " "
	echo " "
	
}

scanningsubfinder

function scanningassetfinder() {
	
	cowsay "Scanning with Assetfinder" | lolcat
	
	assetfinder $url >> $url/assetfinder/$url.assetfinderresult.txt
	
	echo " "
	echo " "
	echo "Proccess Completed" | lolcat
	echo " "
	echo " "

}
scanningassetfinder


function crtshfinder(){

	cowsay "Scanning with CRTSH" | lolcat
	
	curl -s https://crt.sh/\?q\=%25.$url\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u >> $url/crtsh/$url.crtshresult.txt
	
	echo " "
	echo " "
	echo "Proccess Completed" | lolcat
	echo " "
	echo " "

}
crtshfinder




function sortingeverything(){

	cowsay "Sorting the Result and Deleting the Duplicates" | lolcat
	
	sleep 3
	echo -n "Finishing please wait: " | lolcat
	for i in {1..50}; do
	    echo -n "#"
	    sleep 0.1
	done | pv -lep -s 50 > /dev/null
	echo -e "\nProcess completed!" | lolcat
	echo " "
	echo " "
	
	cat $url/assetfinder/$url.assetfinderresult.txt $url/crtsh/$url.crtshresult.txt $url/subfinder/$url.subfinderresult.txt $url/amass/$url.amassfinal.txt >> $url/combined/$url.combined.txt
	sort -u $url/combined/$url.combined.txt >> $url/combined/$url.unique_combined.txt
	rm $url/combined/$url.combined.txt	
	
	
}


sortingeverything




function probingresult(){
	 
	cowsay "Probing Result to see all the active Please wait	" | lolcat
	cat $url/combined/$url.unique_combined.txt | httprobe -c 50 >> $url/httprpobe/$url.proberesult.txt
	
	sleep 3
	echo -n "Finishing please wait: " | lolcat
	for i in {1..50}; do
	    echo -n "#"
	    sleep 0.1
	done | pv -lep -s 50 > /dev/null
	echo -e "\nProcess completed!" | lolcat
	echo " "
	echo " "
}
probingresult


function httpxresult(){

	cowsay "Checking with httpx for result of 200" | lolcat 
	/opt/httpx -list tesla.com/combined/tesla.com.unique_combined.txt  -title -tech-detect -status-code >>  $url/httpx/$url.httpxresult.txt
	cat $url/httpx/$url.httpxresult.txt | grep -e 200 >> $url/httpx/$url.httpxaliveresult.txt
	rm $url/httpx/$url.httpxresult.txt
	
	echo " "
	echo " "
	
	echo "Cleaning up the text and excess strings please wait" | lolcat
	
	echo " "
	echo " "
	
	awk '{print $1}' $url/httpx/$url.httpxaliveresult.txt | sed 's/https\?:\/\///; s/\/.*//' >> $url/httpx/$url.httpxfinal.txt
	rm $url/httpx/$url.httpxaliveresult.txt
	
	sleep 3
	echo -n "Finishing please wait: " | lolcat
	for i in {1..50}; do
	    echo -n "#"
	    sleep 0.1
	done | pv -lep -s 50 > /dev/null
	echo -e "\nProcess completed!" | lolcat
	echo " "
	echo " "



}

httpxresult
