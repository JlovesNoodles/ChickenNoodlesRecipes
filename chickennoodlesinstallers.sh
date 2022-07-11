#! /bin/bash
#! HomeBrewedByChickenN00dles


cowsay -f dragon "Welcome to ChickenNoodles Installer" 

echo " "
echo " "
echo "[----------------------------------------------------------------------------------]"
echo "[ ++++++++++ Do you wish to install the applications needed? { Y , N } +++++++++++ ]"
echo "[----------------------------------------------------------------------------------]"
echo " "
echo " "





read choice
if [[ $choice == "Y" || $choice == "y" ]]; then
echo "Will install the necessary Applications, Just note that breach parsing DB will not be included Comment it first or download seperate here https://github.com/hmaverickadams/breach-parse.git" | boxes -d diamonds -a c 

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

cowsay "FINISHED WITH EVERYTHING HAPPY HACKING <3"

elif [[ $choice == "N" || $choice == "n" ]]; then
cowsay -f dragon "Why did you even downloaded this bruh?"
exit

else
cowsay -f dragon "Really Bruh?"
exit
fi

