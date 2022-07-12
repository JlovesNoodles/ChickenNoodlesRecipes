#! /bin/bash
#! HomeBrewedByChickenN00dles

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


cowsay -f daemon "Chickenoodlesspecial Coming Right Up :D" | lolcat

function whoisrecords() {

	echo "[+] Gathering WhoIS Records | DNS MX Records |  DNS A Records | DNS TXT Records"
	whois $url >> $url/initial/$url.whois.txt
	dig $url MX >> $url/initial/$url.DnsMx.txt
	dig $url A >> $url/initial/$url.DnsA.txt
	dig $url TXT >> $url/initial/$url.DnsTXT.txt
	
}
whoisrecords

echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]"
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





	echo "[+] Harvesting Sudomains with Assetfinder..."
	assetfinder  $url >> $url/subdomain/$url.subdomainraw.txt
	cat $url/subdomain/$url.subdomainraw.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/subdomain/$url.subdomain.txt
	rm $url/subdomain/$url.subdomainraw.txt
	
	echo " "
	echo " "
	echo "[-------------------------------------------]"
	echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]"
	echo "[-------------------------------------------]"
	echo " "
	echo " "
	
	echo "[+] Do you wanna double check it with Knockpy? {Y} | {N} [+]" 
	read knock
	if [[ $knock == "Y" || $knock == "y" ]]; then
	
	echo "[+] Saving file using Knockpy for Double Checking "

	knockpy $url >> $url/subdomain/$url.subdomainKNOCKPY.txt
	cat $url/subdomain/$url.subdomainKNOCKPY.txt
	
	elif [[ $knock == "N" || $knock == "n" ]]; then
	echo "Aight Have A Good Day"
	
	else 
	echo "Bruh can you even read?"
	rm -r $url
	exit
	fi
}
subdomain



echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]"
echo "[-------------------------------------------]"
echo " "
echo " "




#edit this part if you want. This filter status 200 only
function httpxresult() {

	echo "[+] Content Discovery using HTTPX"
	/opt/httpx -list $url/subdomain/$url.subdomain.txt -title -tech-detect -status-code >> $url/subdomain/$url.subdomainchecked.txt
	cat $url/subdomain/$url.subdomainchecked.txt | grep -e 200 >> $url/subdomain/$url.AliveSubdomain.txt
	rm $url/subdomain/$url.subdomainchecked.txt
}

httpxresult

echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]"
echo "[-------------------------------------------]"
echo " "
echo " "





function subtakeover() { 

	echo "[+] Checking for possible Domain Takeover Using Subjack"
	subjack -w $url/subdomain/$url.subdomain.txt -t 100 -timeout 30 -ssl -c /usr/share/subjack/fingerprints.json -v 3 >> $url/subtakeover/$url.subjacktakeover.txt
	cat $url/subtakeover/$url.subjacktakeover.txt
	echo " " 
	echo "Finished"
	echo " "
	#altdns -i $url/subdomain/$url.subdomain.txt -o $url.data_output -w /opt/altdns/words.txt -r -s $url.altdnstakeover.txt
	#mv $url.data_output $url.altdnstakeover.txt /$url/subtakeover	
	echo "Check this website for the HOW TO takeover if there is any https://github.com/EdOverflow/can-i-take-over-xyz"
	
}

subtakeover


echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]"
echo "[-------------------------------------------]"
echo " "
echo " "


#AQUATONE
	function aquatoneresult(){
	echo "[+] Do You want a Visual Identification using Aquatone { Y | N } ?"
	read aquainput
	if [[ $aquainput == "Y" || $aquainput == "y" ]]; then
	echo "[+] Visual Identification Using Aquatone"
	cd $url/subdomain
	cat $url.AliveSubdomain.txt | aquatone
	mv aquatone_* /home/kali/Documents/bugbounty/$url/aquatone/
	cd ..
	cd ..
	else
	echo "Aight up to you cuhz"
	fi
}
aquatoneresult


echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]"
echo "[-------------------------------------------]"
echo " "
echo " "

#GetAllUrls


function gauresult(){
	#.asa .inc .sql .zip .tar .pdf .txt
	echo "[+] Getting URL's using GAU (.php .asa .inc .sql .zip .tar .pdf .txt Extenstions Only)"
	gau --fc 404,302 $url | grep ".php" >> $url/gau/$url.PHP_extentionurl.txt
	gau --fc 404,302 $url | grep ".asa" >> $url/gau/$url.ASA_extentionurl.txt
	gau --fc 404,302 $url | grep ".inc" >> $url/gau/$url.INC_extentionurl.txt
	gau --fc 404,302 $url | grep ".sql" >> $url/gau/$url.SQL_extentionurl.txt
	gau --fc 404,302 $url | grep ".zip" >> $url/gau/$url.ZIP_extentionurl.txt
	gau --fc 404,302 $url | grep ".tar" >> $url/gau/$url.TAR_extentionurl.txt
	gau --fc 404,302 $url | grep ".pdf" >> $url/gau/$url.PDF_extentionurl.txt
	gau --fc 404,302 $url | grep ".txt" >> $url/gau/$url.TXT_extentionurl.txt
	#gau --fc 404,302 $url >> $url/gau/$url.GAU_url.txt
}

gauresult


echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]"
echo "[-------------------------------------------]"
echo " "
echo " "


function breachparsing() {

	echo "[ Do you want to gather breached data? { Y | N }]"
	read breach
	if [[ $breach == "Y" || $breach == "y" ]]; then
	
	echo "[@$url is this the same email extension? { Y | N }]"
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
		echo "Wrong Choice Exiting"
		fi
		
	else 
	echo " "
	fi
}

breachparsing


echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]"
echo "[-------------------------------------------]"
echo " "
echo " "



echo " "
echo " "
echo "[---------------------------------------------------------------------------------------------------------------------------------------------]"
echo "[ +++++++++++++++ THIS PORTION IS OPTIONAL YOU MAY CHOOSE NOT TO PROCEED, BUT WOULD STILL SUGGEST TO RUN MANUALLY SEPERATELY ++++++++++++++++ ]"
echo "[---------------------------------------------------------------------------------------------------------------------------------------------]"
echo " "
echo " "
	
#VULNERABILITY SCANNER FOR WP | JOOMLA | DRUPAL | NUCLEI | CMS | 

function vulnscanner () {

	echo "[+] CHOOSE BETWEEN THE AUTOMATED VULNSCANNERS"
	echo "[+] { W - Wordpress | J - Joomla | D - Drupal | N - NUCLEI | C - CMS (IF YOUR NOT SURE ABOUT THE CMS BEING USED) | X - Cancel}"
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
	echo "Do you wanna run nuclei on all subdomain or only the domairn or Both ? { B | D | S } "
	read nucleichoice
		if [[ $nucleichoice == "B" || $nucleichoice == "b" ]]; then
		/opt/nuclei -u $url >> $url/vulnscanner/$url.NucleiDomain.txt 
		/opt/nuclei -list $url/subdomain/$url.subdomain.txt >> $url/vulnscanner/$url.NucleiSubDomain.txt
		
	
	
		elif [[ $nucleichoice == "D" || $nucleichoice == "d" ]]; then
		/opt/nuclei -u $url >> $url/vulnscanner/$url.NucleiDomain.txt
		cat $url/vulnscanner/$url.NucleiDomain.txt
	
		elif [[ $nucleichoice == "S" || $nucleichoice == "s" ]]; then
		/opt/nuclei -list $url/subdomain/$url.subdomain.txt >> $url/vulnscanner/$url.NucleiSubDomain.txt
		cat $url/vulnscanner/$url.NucleiSubDomain.txt
		else
		echo "Error on Choice"
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
	echo "[ ++ Do you wanna scan again? ++ { Y | N } ]"
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
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]"
echo "[-------------------------------------------]"
echo " "
echo " "



#FUZZING
function fuzzresult() {

	echo "WARNING THIS MIGHT TAKE A LOT OF RESOURCERS BOTH PROCESSING POWER AND STORAGE "
	echo "[+] Do you want to perform url fuzzing { Y | N } ? "
	read fuzz
	if [[ $fuzz == "Y" || $fuzz == "y" ]]; then
	echo "[This might take a while]"
	ffuf -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt:FUZZ -u https://$url:FUZZ >> $url/fuzz/$url.FFUFResults.txt
	else
	echo "aight understandable have a good day!"
	fi
}
fuzzresult

echo " "
echo " "
echo "[-------------------------------------------]"
echo "[ +++++++++++++++ FINISHED ++++++++++++++++ ]"
echo "[-------------------------------------------]"
echo " "
echo " "


function nmapscan(){

	echo "[+] Would you like to proceed on NMAP Scan? [ y | n ] "
	echo " "
	echo "WARNING THIS MIGHT TAKE A LOT OF RESOURCERS BOTH PROCESSING POWER AND STORAGE "
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
	nmap $url -T4 -sV -p- -A >> $url/nmapscan/$url.ScanDomain.txt
	nmap -iL $url/subdomain/$url.subdomain.txt -T4 -sV -p- -A >> $url/nmapscan/$url.ScannedSubDomains.txt
	else 
	echo "Really Bruh?"
	fi

}
nmapscan







cowsay -f kiss "Ooops nothing to see here continue hacking please!" | lolcat
#figlet -c -w  100 " ALL DONE HAPPY HACKING "



cowsay -f vader "May the BUG be with you" | lolcat
