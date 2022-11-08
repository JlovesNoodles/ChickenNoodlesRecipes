#!/bin/bash
# HomeBrewedByChickenN00dles

url=$1

if [ ! -d "$url" ];then
	mkdir $url
fi

if [ ! -d "$url/initial" ];then
	mkdir $url/initial
fi

if [ ! -d "$url/subdomain" ];then
	mkdir $url/subdomain
fi

if [ ! -d "$url/nmapscan" ];then
	mkdir $url/nmapscan
fi

if [ ! -d "$url/gau" ];then
	mkdir $url/gau
fi

if [ ! -d "$url/fuzz" ];then
	mkdir $url/fuzz
fi

if [ ! -d "$url/aquatone" ];then
	mkdir $url/aquatone
fi

if [ ! -d "$url/vulnscanner" ];then
	mkdir $url/vulnscanner
fi

if [ ! -d "$url/breachparsing" ];then
	mkdir $url/breachparsing
fi	

if [ ! -d "$url/subtakeover" ];then
	mkdir $url/subtakeover
fi	

if [ ! -d "$url/cloudscan" ];then
	mkdir $url/cloudscan
fi	


cowsay  "Chickenoodlesspecial Coming Right Up :D" | lolcat -a -d 1



#add here to check if its in the cloud, if no proceed, if yes bruteit via cloudbrute


# cloudbrute -d globe.com.ph -c /etc/cloudbrute/config/modules/amazon.yaml -w /usr/share/cloudbrute/data/storage_small.txt
function scanningcloud(){
	echo " "
	echo " "
	echo " "
	echo " "
	echo " "
	echo "[----------------------------------------------------------------------------------------------------------------------------------]"
	echo "[ +++++++++++++++ This program will scan for open cloud repositories online would you like to proceed? [Y]es [N]o ++++++++++++++++ ]" | lolcat
	echo "[----------------------------------------------------------------------------------------------------------------------------------]"
	echo " "
	echo " "
	#cowsay -f flaming-sheep "I assume you already done your recon is the target on cloud? [Y]es [N]o" | lolcat
	read scancloudchoice
	if [[ $scancloudchoice == "Y" || $scancloudchoice == "y" ]]; then
	echo "Select what Cloud Service the Target have [A]zure [W]aws [G]oogle_Cloud [N]ot Sure! " | lolcat
	read cloud_choice
	
	
		if [[ $cloud_choice == "A" || $cloud_choice ==  "a" ]]; then
		echo "Enumeration on Process Please Wait" | lolcat
		cloud_enum -k $url --disable-aws --disable-gc >> $url/cloudscan/cloud_result_for_$url.txt
		cat $url/cloudscan/cloud_result_for_$url.txt
		
		
		elif [[ $cloud_choice == "W" || $cloud_choice == "w" ]]; then
		echo "Enumeration on Process Please Wait" | lolcat
		cloud_enum -k $url --disable-azure --disable-gc >> $url/cloudscan/cloud_result_for_$url.txt
		cat $url/cloudscan/cloud_result_for_$url.txt
		
		
		elif [[ $cloud_choice  == "G" || $cloud_choice == "g" ]]; then
		echo "Enumeration on Process Please Wait" | lolcat
		cloud_enum -k $url --disable-aws --disable-azure >> $url/cloudscan/cloud_result_for_$url.txt
		cat $url/cloudscan/cloud_result_for_$url.txt
		
		
		elif [[ $cloud_choice == "N" || $cloud_choice == "n" ]]; then
		echo "Enumeration on Process Please Wait" | lolcat
		cloud_enum -k $url >> $url/cloudscan/cloud_result_for_$url.txt
		cat $url/cloudscan/cloud_result_for_$url.txt
		else
		echo "Wrong choice bruh exiting now" | lolcat	
		exit
		fi
		
		
		
	#cloud_enum -k $url


	elif [[ $scancloudchoice == "N" || $scancloudchoice == "n" ]]; then
	echo " "
	echo " "
	echo "[-------------------------------------------------------------------------]"
	echo "[ +++++++++++++++ Proceeding with the rest of the script ++++++++++++++++ ]" | lolcat
	echo "[-------------------------------------------------------------------------]"
	echo " "
	echo " "
	
	#cowsay "Proceeding with the rest of the script" | lolcat
	cd $url
	rm -r cloudscan
	cd ..
	else
	
	echo " "
	echo " "
	echo "[-------------------------------------------------------]"
	echo "[ +++++++++++++++ Wrong Choice Brother ++++++++++++++++ ]" | lolcat
	echo "[-------------------------------------------------------]"
	echo " "
	echo " "
	#cowsay -f ren "Wrong Choice Brother " | lolcat
	exit
	fi
	


}
scanningcloud




#add here to check for waf
function checkingforwaf(){
	echo " "
	echo " "
	echo " "
	echo "Do you wanna scan for WAF? [Y]es [N]o" | lolcat
	read wafscan
	if [[ $wafscan == "Y" || $wafscan == "y" ]]; then
	echo "Checking if there is a WAF" | lolcat
	wafw00f $url
	elif [[ $wafscan == "N" || $wafscan == "n" ]]; then
	echo ""
	
	else
	exit
	fi
	
	#echo "Do you want to proceed ? [Y]es [N]o" | lolcat
	#read wafinput
	#if [[ $wafinput == "Y" || $wafinput == "y" ]]; then
	#cowsay -f eyes "Proceeding with the rest of the script" | lolcat
	#elif [[ $wafinput == "N" || $wafinput == "n" ]]; then
	#echo "" 
	#cowsay -f ren "Understandable have a Good Day! " | lolcat
	#exit
	#else
	#exit
	#fi
	

}
checkingforwaf


function whoisrecords() {
	echo " "
	echo " "
	echo " "
	echo "[+] Gathering WhoIS Records | DNS MX Records |  DNS A Records | DNS TXT Records" | lolcat
	whois $url >> $url/initial/$url.whois.txt
	dig $url MX >> $url/initial/$url.DnsMx.txt
	dig $url A >> $url/initial/$url.DnsA.txt
	dig $url TXT >> $url/initial/$url.DnsTXT.txt
	
}
whoisrecords

echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]" | lolcat
echo "[-------------------------------------------]"
echo " "
echo " "

#THIS WILL HARVEST SUBDOMAINS AND SAVE IT ON ITS RESPECTIVE FOLDER



function subdomain () {

	#echo "[+] Gathering Info with Asset Finder "
	#read choice
#	if [[ $choice == "S" || $choice == "s" ]]; then
	#echo "[+] Harvesting Sudomains with Subfinder..."
#	subfinder -d $url >> $url/subdomain/$url.subdomainraw.txt 
#	cat $url/subdomain/$url.subdomainraw.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/subdomain/$url.subdomain.txt
#	rm $url/subdomain/$url.subdomainraw.txt

#	elif [[ $choice == "A" || $choice == "a" ]]; then

	echo " "
	echo " "
	echo " "



	echo "[+] Harvesting Sudomains with Assetfinder..." | lolcat
	assetfinder  $url >> $url/subdomain/$url.subdomainraw.txt
	cat $url/subdomain/$url.subdomainraw.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/subdomain/$url.subdomain.txt
	rm $url/subdomain/$url.subdomainraw.txt
	
	echo " "
	echo " "
	echo "[-------------------------------------------]"
	echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]" | lolcat
	echo "[-------------------------------------------]"
	echo " "
	echo " "
	
	echo "[+] Do you wanna double check it with Knockpy? {Y} | {N} [+]"  | lolcat
	read knock
	if [[ $knock == "Y" || $knock == "y" ]]; then
	
	echo "[+] Saving file using Knockpy for Double Checking " | lolcat

	knockpy $url >> $url/subdomain/$url.subdomainKNOCKPY.txt
	cat $url/subdomain/$url.subdomainKNOCKPY.txt
	
	elif [[ $knock == "N" || $knock == "n" ]]; then
	echo "Aight Understandable Have A Good Day" | lolcat
	
	else 
	echo "Bruh can you even read?" | lolcat
	rm -r $url
	exit
	fi
}
subdomain



echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]" | lolcat
echo "[-------------------------------------------]"
echo " "
echo " "




#edit this part if you want. This filter status 200 only
function httpxresult() {
	echo " "
	echo " "
	echo " "
	echo "[+] Content Discovery using HTTPX" | lolcat
	/opt/httpx -list $url/subdomain/$url.subdomain.txt -title -tech-detect -status-code >> $url/subdomain/$url.subdomainchecked.txt
	cat $url/subdomain/$url.subdomainchecked.txt | grep -e 200 >> $url/subdomain/$url.AliveSubdomain.txt
	rm $url/subdomain/$url.subdomainchecked.txt
}

httpxresult

echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]" | lolcat
echo "[-------------------------------------------]"
echo " "
echo " "





function subtakeover() { 
	echo " "
	echo " "
	echo " "
	echo "[+] Checking for possible Domain Takeover Using Subjack" | lolcat
	subjack -w $url/subdomain/$url.subdomain.txt -t 100 -timeout 30 -ssl -c /usr/share/subjack/fingerprints.json -v 3 >> $url/subtakeover/$url.subjacktakeover.txt
	cat $url/subtakeover/$url.subjacktakeover.txt
	echo " " 
	echo "Finished" | lolcat
	echo " "
	#altdns -i $url/subdomain/$url.subdomain.txt -o $url.data_output -w /opt/altdns/words.txt -r -s $url.altdnstakeover.txt
	#mv $url.data_output $url.altdnstakeover.txt /$url/subtakeover	
	echo "Check this website for the HOW TO takeover if there is any https://github.com/EdOverflow/can-i-take-over-xyz" | lolcat
	
}

subtakeover


echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]" | lolcat
echo "[-------------------------------------------]"
echo " "
echo " "


#AQUATONE
	function aquatoneresult(){
	echo " "
	echo " "
	echo " "
	echo "[+] Do You want a Visual Identification using Aquatone { Y | N } ?" | lolcat
	read aquainput
	if [[ $aquainput == "Y" || $aquainput == "y" ]]; then
	echo "[+] Visual Identification Using Aquatone"
	cd $url/subdomain
	cat $url.AliveSubdomain.txt | aquatone
	mv aquatone_* /home/kali/Documents/bugbounty/$url/aquatone/
	cd ..
	cd ..
	else
	echo "Aight Understandable Have A Good Day" | lolcat
	fi
}
aquatoneresult


echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]" | lolcat
echo "[-------------------------------------------]"
echo " "
echo " "

#GetAllUrls


function gauresult(){
	#.asa .inc .sql .zip .tar .pdf .txt
	echo " "
	echo " "
	echo " "
	echo "[+] Getting URL's using GAU (.php .asa .inc .sql .zip .tar .pdf .txt Extenstions Only)" | lolcat
	gau --fc 404,302 $url | grep ".php" >> $url/gau/$url.PHP_extentionurl.txt
	gau --fc 404,302 $url | grep ".asa" >> $url/gau/$url.ASA_extentionurl.txt
	gau --fc 404,302 $url | grep ".inc" >> $url/gau/$url.INC_extentionurl.txt
	gau --fc 404,302 $url | grep ".sql" >> $url/gau/$url.SQL_extentionurl.txt
	gau --fc 404,302 $url | grep ".zip" >> $url/gau/$url.ZIP_extentionurl.txt
	gau --fc 404,302 $url | grep ".tar" >> $url/gau/$url.TAR_extentionurl.txt
	gau --fc 404,302 $url | grep ".pdf" >> $url/gau/$url.PDF_extentionurl.txt
	gau --fc 404,302 $url | grep ".txt" >> $url/gau/$url.TXT_extentionurl.txt
	gau --fc 404,302 $url | grep ".png, .jpeg, .gif, .raw" >> $url/gau/$url.PHOTOS_extentionurl.txt
	
	gau --fc 404,302 $url >> $url/gau/$url.GAU_url.txt
}

gauresult


echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]" | lolcat
echo "[-------------------------------------------]"
echo " "
echo " "


function breachparsing() {
	echo " "
	echo " "
	echo " "

	echo "[ Do you want to gather breached data? { Y | N }]" | lolcat
	read breach
	if [[ $breach == "Y" || $breach == "y" ]]; then
	
	echo "[@$url is this the same email extension? { Y | N }]" | lolcat 
	read breachchoice
		if [[ $breachchoice == "Y" || $breachchoice == "y" ]]; then
		cd $url/breachparsing 
		/opt/breach-parse/breach-parse.sh $url $url.breachparse.txt
		
		#echo "$url" >> $url/syntax.txt
		#cat syntax.txt | sed -e "s/\.com//" >> $url.parsesysntax
		#mv $url* /$url/breachparsing/
		
		elif [[ $breachchoice == "N" || $breachchoice == "n" ]]; then
		echo ["Type the email format"]
		read emailformat
		cd $url/breachparsing 
		/opt/breach-parse/breach-parse.sh $emailformat $emailformat.breachparse.txt
		#mv $choice* /$url/breachparsing
		else
		echo "Wrong Choice Exiting" | lolcat
		fi
		
	else 
	echo " "
	fi
}

breachparsing


echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]" | lolcat
echo "[-------------------------------------------]"
echo " "
echo " "



echo " "
echo " "
echo "[---------------------------------------------------------------------------------------------------------------------------------------------]"
echo "[ +++++++++++++++ THIS PORTION IS OPTIONAL YOU MAY CHOOSE NOT TO PROCEED, BUT WOULD STILL SUGGEST TO RUN MANUALLY SEPERATELY ++++++++++++++++ ]" | lolcat
echo "[---------------------------------------------------------------------------------------------------------------------------------------------]"
echo " "
echo " "
	
#VULNERABILITY SCANNER FOR WP | JOOMLA | DRUPAL | NUCLEI | CMS | 

function vulnscanner () {
	echo " "
	echo " "
	echo " "

	echo "[+] CHOOSE BETWEEN THE AUTOMATED VULNSCANNERS" | lolcat
	echo "[+] { W - Wordpress | J - Joomla | D - Drupal | N - NUCLEI | C - CMS (IF YOUR NOT SURE ABOUT THE CMS BEING USED) | X - Cancel}" | lolcat
	read vulnchoice

	if [[ $vulnchoice == "W" || $vulnchoice == "w" ]]; then
	wpscan --url $url --enumerate --stealthy --ignore-main-redirect>> $url/vulnscanner/$url.WPScan.txt
	cat $url/vulnscanner/$url.WPScan.txt

	elif [[ $vulnchoice == "J" || $vulnchoice == "j" ]]; then
	joomscan -u $url >> $url/vulnscanner/$url.JoomsScan.txt
	cat $url/vulnscanner/$url.JoomsScan.txt

	elif [[ $vulnchoice == "D" || $vulnchoice == "d" ]]; then
	droopescan scan drupal -u $url >> $url/vulnscanner/$url.DrupScan.txt
	cat $url/vulnscanner/$url.DrupScan.txt


	elif [[ $vulnchoice == "N" || $vulnchoice == "n" ]]; then
	echo "Do you wanna run nuclei on all subdomain or only the domairn or Both ? { B | D | S } " | lolcat
	read nucleichoice
		if [[ $nucleichoice == "B" || $nucleichoice == "b" ]]; then
		nuclei -u $url -t /root/nuclei-templates/ >> $url/vulnscanner/$url.NucleiDomain.txt 
		nuclei -list $url/subdomain/$url.subdomain.txt -t /root/nuclei-templates/ >> $url/vulnscanner/$url.NucleiSubDomain.txt
		
	
	
		elif [[ $nucleichoice == "D" || $nucleichoice == "d" ]]; then
		nuclei -u $url >> $url/vulnscanner/$url.NucleiDomain.txt
		cat $url/vulnscanner/$url.NucleiDomain.txt
	
		elif [[ $nucleichoice == "S" || $nucleichoice == "s" ]]; then
		nuclei -list $url/subdomain/$url.subdomain.txt >> $url/vulnscanner/$url.NucleiSubDomain.txt
		cat $url/vulnscanner/$url.NucleiSubDomain.txt
		else
		echo "Error on Choice" | lolcat
		fi


	elif [[ $vulnchoice == "C" || $vulnchoice == "c" ]]; then
	cmseek -u https://$url --ignore-cms-wp --random-agent >> $url/vulnscanner/$url.CmSeek.txt
	cat $url/vulnscanner/$url.CmSeek.txt
	else
	echo " "
	fi
	echo " "
	echo " "
	echo "[-------------------------------------------]"
	echo "[ ++ Do you wanna scan again? ++ { Y | N } ]" | lolcat
	echo "[-------------------------------------------]"
	echo " "
	echo " "
	read anotherchoice
	if [[ $anotherchoice == "Y" || $anotherchoice == "y" ]]; then
	vulnscanner
	fi


}
vulnscanner






echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]" | lolcat
echo "[-------------------------------------------]"
echo " "
echo " "



#FUZZING
function fuzzresult() {
	echo " "
	echo " "
	echo " "

	echo "WARNING THIS MIGHT TAKE A LOT OF RESOURCERS BOTH PROCESSING POWER AND STORAGE " | lolcat
	echo "[+] Do you want to perform url fuzzing { Y | N } ? " | lolcat
	read fuzz
	if [[ $fuzz == "Y" || $fuzz == "y" ]]; then
	echo "[This might take a while]" | lolcat 
	ffuf -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt:FUZZ -u https://$url:FUZZ >> $url/fuzz/$url.FFUFResults.txt
	else
	echo "Aight Understandable Have A Good Day"  | lolcat
	fi
}
fuzzresult

echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]" | lolcat
echo "[-------------------------------------------]"
echo " "
echo " "


function nmapscan(){
	echo " "
	echo " "
	echo " "

	echo "[+] Would you like to proceed on NMAP Scan? [ Y | N ] " | lolcat
	echo " "
	echo "WARNING THIS MIGHT TAKE A LOT OF RESOURCERS BOTH PROCESSING POWER AND STORAGE " | lolcat
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
	nmap $url -T4 -sV -p- -A >> $url/nmapscan/$url.ScanDomain.txt
	nmap -iL $url/subdomain/$url.subdomain.txt -T4 -sV -p- -A >> $url/nmapscan/$url.ScannedSubDomains.txt
	
	elif [[ $input == "N" || $input == "n" ]]; then
	echo "Aight Understandable Have A Good Day" | lolcat
	
	else 
	echo "Really Bruh?"
	fi

}
nmapscan
