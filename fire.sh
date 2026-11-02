#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)

for file in *.xapk; do
	if [[ "$file" =~ [a-zA-Z][a-zA-Z0-9_]*(\.[a-zA-Z0-9_]*)+ ]]; then
		unzip -nq "$file" -d .
		rm config.*
		rm $file
	fi
done

declare -a apps
mapfile -t apps < <(find . -type f -name "*.apk" -printf "%P\n") 

for app in "${apps[@]}"; do
	echo "$app"
	url=$(strings ${app} | grep "firebaseio" | awk '{print substr($0, index($0, "ht"))}')

	if [[ -n "$url" ]]; then
		furl="$url""/.json"
		echo $furl
		count=$(curl -ks $furl | jq '.' | wc -l)

		if [[ $count -le 3 ]]; then
			rm $app
			echo "Removed ${app}"	
		else
			name="${app%.apk}"
			fname="${name//./_}"
			curl -ks $furl -o ${fname}.json
		        echo "${GREEN}Saved to $fname.json${NC}" 	
		fi
	else
		rm $app
		echo "Removed $app"
		dapp=${app%.apk}
		rm -rf $dapp
	fi
	echo
done

rm -f manifest.json icon.png

