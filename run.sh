#!/bin/bash

RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
BOLD=$(tput bold)
NC=$(tput sgr0)

while true; do
echo -e "${RED}"
echo "Loading..."
cat << "EOF"
 ________ ___  ________  _______   ________  _______   ________  ________  ________  ___  ___     
|\  _____\\  \|\   __  \|\  ___ \ |\   ____\|\  ___ \ |\   __  \|\   __  \|\   ____\|\  \|\  \    
\ \  \__/\ \  \ \  \|\  \ \   __/|\ \  \___|\ \   __/|\ \  \|\  \ \  \|\  \ \  \___|\ \  \\\  \   
 \ \   __\\ \  \ \   _  _\ \  \_|/_\ \_____  \ \  \_|/_\ \   __  \ \   _  _\ \  \    \ \   __  \  
  \ \  \_| \ \  \ \  \\  \\ \  \_|\ \|____|\  \ \  \_|\ \ \  \ \  \ \  \\  \\ \  \____\ \  \ \  \ 
   \ \__\   \ \__\ \__\\ _\\ \_______\____\_\  \ \_______\ \__\ \__\ \__\\ _\\ \_______\ \__\ \__\
    \|__|    \|__|\|__|\|__|\|_______|\_________\|_______|\|__|\|__|\|__|\|__|\|_______|\|__|\|__|
                                     \|_________|                                                 
EOF
echo -e "${NC}"
echo -e "${BLUE}* Download APK files automatically and dump the contents of exposed Firebase databases.\n* Every APK file in the current directory that does not lead to an exposed database will be removed to save you the trouble of deleting them.\n\n${NC}"

apk_download() {
	python3 -m venv venv
	source venv/bin/activate

	pip3 install google-play-scraper

	> appid.csv
	> appdetails.csv

	python3 createcsv.py

	deactivate

	apkeep -c appid.csv . 
}

echo "${BLUE}${BOLD}Choose a mode:${NC}"
echo "${BLUE}${BOLD}[1] Download apk files${NC}"
echo "${BLUE}${BOLD}[2] Firebase database search${NC}"
echo "${BLUE}${BOLD}[3] Exit${NC}"

read -p "${BLUE}>${NC}" opt

case $opt in
	1)
 		apk_download
		echo -e "\nUse 2"
		continue
		;;
	2)
		bash fire.sh
		continue
		;;
	3)
		echo "${BLUE}Exiting...${NC}"
		break
		;;
	*)
		echo "${RED}Invalid option. Exiting...${NC}"
		break
		;;
esac
done
