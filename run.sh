#!/bin/bash

RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
NC=$(tput sgr0)
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
echo "${BLUE}Download apk files automatically and dump the contents of Firebase databases.${NC}"

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

echo "${BLUE}[1] Download apk files${NC}"
echo "${BLUE}[2] Firebase database search${NC}"
read -p "${BLUE}>${NC}" opt

case $opt in
	1)
 		apk_download
		;;
	2)
		bash fire.sh
		;;
	*)
		echo "${RED}Invalid option. Exiting...${NC}"
		;;
esac
