#! /bin/bash
#! HomeBrewedByChickenN00dles


#cowsay -f dragon "Welcome to ChickenNoodles Installer" | lolcat -a -d 1

echo " "
echo " "
echo "[----------------------------------------------------------------------------------]"
echo "[ ++++++++++ Welcome to ChickenNoodles Installer +++++++++++ ]" | lolcat -a -d 1
echo "[----------------------------------------------------------------------------------]"
echo " "
echo " "








echo " "
echo " "
echo "[----------------------------------------------------------------------------------]"
echo "[ ++++++++++ Do you wish to install the applications needed? { Y , N } +++++++++++ ]" | lolcat
echo "[----------------------------------------------------------------------------------]"
echo " "
echo " "





read choice
if [[ $choice == "Y" || $choice == "y" ]]; then
echo "Will install the necessary Applications, Just note that breach parsing DB will not be included Comment it first or download seperate here https://github.com/hmaverickadams/breach-parse.git" |boxes -a c -d cat | lolcat -a -d 7

apt install whois
echo "Finished with Whois"

apt install assetfinder
echo "Finished with Assetfinder"
apt install knockpy
echo "Finished with Knockpy"

unzip httpx_1.2.2_linux_amd64.zip
sudo mv httpx /opt/
echo "Finished with httpx, was installed on /opt/"

apt install subjack
echo "Finished with Subjack"

unzip aquatone_linux_amd64_1.7.0.zip 
mv aquatone /opt/
echo "Finished with Aquatone, was installed on /opt/"


tar xvf gau_2.1.1_linux_amd64.tar.gz
mv gau /opt
echo "Finished with GAU, was installed on /opt/"


apt install wpscan
echo "Finished with WPSCAN"

apt install joomscan
echo "Finished with Joomscan"

git clone https://github.com/SamJoan/droopescan.git
cd droopescan
pip3 install -r requirements.txt
cd ..
echo "Finished with Droopescan"

apt install cmseek
echo "Finished with CMSeek"

unzip nuclei_2.7.3_linux_amd64.zip
mv nuclei /opt/
echo "Finished with Nuclei, was installed on /opt/"

cowsay "FINISHED WITH EVERYTHING HAPPY HACKING <3 also Never forget to update everything after installing for best results! " | lolcat




elif [[ $choice == "N" || $choice == "n" ]]; then

echo " "
echo " "
echo "[---------------------------------------------------------------]"
echo "[ ++++++++++ Why did you even downloaded this bruh? +++++++++++ ]" | lolcat 
echo "[---------------------------------------------------------------]"
echo " "
echo " "

exit

else

echo " "
echo " "
echo "[-------------------------------------]"
echo "[ ++++++++++ Really Bruh? +++++++++++ ]" | lolcat 
echo "[-------------------------------------]"
echo " "
echo " "


exit
fi
