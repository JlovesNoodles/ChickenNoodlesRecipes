#! /bin/bash
#! HomeBrewedByChickenN00dles
#! Dont use with Malicious Intent you might get into trouble for real!

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

if [ ! -d "$url/vulnscanner" ];then
	mkdir $url/vulnscanner
fi



echo "[+] Gathering WhoIS Records | DNS MX Records |  DNS A Records | DNS TXT Records"
whois $url >> $url/initial/$url.whois.txt
dig $url MX >> $url/initial/$url.DnsMx.txt
dig $url A >> $url/initial/$url.DnsA.txt
dig $url TXT >> $url/initial/$url.DnsTXT.txt

echo " " 
echo " FINISHED " 
echo " " 

#THIS WILL HARVEST SUBDOMAINS AND SAVE IT ON ITS RESPECTIVE FOLDER

echo "[+] For the Subdomain Choose between Subfinder / Assetfinder { S | A }"
read choice
if [[ $choice == "S" || $choice == "s" ]]; then
echo "[+] Harvesting Sudomains with Subfinder..."
subfinder -d $url >> $url/subdomain/$url.subdomainraw.txt 
cat $url/subdomain/$url.subdomainraw.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/subdomain/$url.subdomain.txt
rm $url/subdomain/$url.subdomainraw.txt

elif [[ $choice == "A" || $choice == "a" ]]; then
echo "[+] Harvesting Sudomains with Assetfinder..."
assetfinder  $url >> $url/subdomain/$url.subdomainraw.txt
cat $url/subdomain/$url.subdomainraw.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/subdomain/$url.subdomain.txt
rm $url/subdomain/$url.subdomainraw.txt
else 
echo "Bruh can you even read?"
rm -r $url
exit
fi


echo " " 
echo " FINISHED " 
echo " "

#edit this part if you want. This filter status 200 only

echo "[+] Content Discovery using HTTPX"
/opt/httpx -list $url/subdomain/$url.subdomain.txt -title -tech-detect -status-code >> $url/subdomain/$url.subdomainchecked.txt
cat $url/subdomain/$url.subdomainchecked.txt | grep -e 200 >> $url/subdomain/$url.AliveSubdomain.txt
rm $url/subdomain/$url.subdomainchecked.txt


echo " " 
echo " FINISHED " 
echo " "


#/opt/httpx -list $url/subdomain/$url.subdomain.txt >> $url/subdomain/$url.RawAlive.txt
#cat $url/subdomain/$url.RawAlive.txt | sed 's/https\?:\/\///' >> $url/subdomain/$url.parsed.txt
#rm $url/subdomain/$url.RawAlive.txt



#AQUATONE

#if [[ $input == "Y" || $input == "y" ]]; then
#echo "Do You want a Visual Identification using Aquatone?"
#read aquainput
#echo "[+] Visual Identification Using Aquatone"
#cat /home/kali/Documents/bugbounty/dumps/$url.AliveSubdomain.txt | aquatone >> $url.AquatoneSubdomains.txt
#else
#echo "Aight up to you cuhz"
#fi


#GetAllUrls
#Edit this part for your reference this only filter all url with .php extension
echo "[+] Getting URL's using GAU (.php extentions only)"
gau --fc 404,302 $url | grep ".php" >> $url/gau/$url.PHPEXTENSIONSURL.txt
#gau --fc 404,302 $url >> $url/gau/$url.GAU_url.txt

echo " " 
echo " FINISHED " 
echo " "

#VULNERABILITY SCANNER FOR WP | JOOMLA | DRUPAL | NUCLEI | CMS | 


#For Wordpress
#! /bin/bash


url=$1

if [ ! -d "$url" ];then
	mkdir $url
fi	


if [ ! -d "$url/vulnscanner" ];then
	mkdir $url/vulnscanner
fi
	
	
function vulnscanner () {
	echo "[+] CHOOSE BETWEEN THE AUTOMATED VULNSCANNERS"
	echo "[+] { W - Wordpress | J - Joomla | D - Drupal | N - NUCLEI | C - CMS (IF YOUR NOT SURE ABOUT THE CMS BEING USED) | X - Cancel}"
	read vulnchoice

	if [[ $vulnchoice == "W" || $vulnchoice == "w" ]]; then
	wpscan --url $url --enumerate --stealthy >> $url/vulnscanner/$url.WPScan.txt
	cat $url/vulnscanner/$url.WPScan.txt

	elif [[ $vulnchoice == "J" || $vulnchoice == "j" ]]; then
	joomscan -u $url >> $url/vulnscanner/$url.JoomsScan.txt
	cat $url/vulnscanner/$url.JoomsScan.txt

	elif [[ $vulnchoice == "D" || $vulnchoice == "d" ]]; then
	droopescan scan drupal -u $url --random-agent >> $url/vulnscanner/$url.DrupScan.txt
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
	cmseek -u $url --random-agent >> $url/vulnscanner/$url.CmSeek.txt
	cat $url/vulnscanner/$url.CmSeek.txt
	else
	echo " "
	fi

}

vulnscanner

echo "[ ++ Do you wanna scan again? ++ { Y | N } ]"
read anotherchoice
if [[ $anotherchoice == "Y" || $anotherchoice == "y" ]]; then
vulnscanner
fi









echo " " 
echo " FINISHED " 
echo " "




#FUZZING
echo "WARNING THIS MIGHT TAKE A LOT OF RESOURCERS BOTH PROCESSING POWER AND STORAGE "
echo "[+] Do you want to perform url fuzzing { Y | N } ? "
read fuzz
if [[ $fuzz == "Y" || $fuzz == "y" ]]; then
echo "[TAKE YOUR COFFEE GO OUTSIDE LOOK FOR THE POLICE THEY MIGHT BE SEARCHING FOR YOU NOW LOL]"
ffuf -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt:FUZZ -u https://$url:FUZZ >> $url/fuzz/$url.FFUFResults.txt
else
echo "aight understandable have a good day!"
fi

echo " " 
echo " FINISHED " 
echo " "


echo "[+] Would you like to proceed on NMAP Scan? [ y | n ] "
echo "WARNING THIS MIGHT TAKE A LOT OF RESOURCERS BOTH PROCESSING POWER AND STORAGE "
read input
if [[ $input == "Y" || $input == "y" ]]; then
nmap -iL $url/subdomain/$url.subdomain.txt -T4 -sV -p- -A >> $url/nmapscan/$url.ScannedDomains.txt
else 
echo "Really Bruh?"
fi




figlet -c -w  100 " ALL DONE HAPPY HACKING "
