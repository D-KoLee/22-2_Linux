#!/bin/bash	
y="[103m   [0m"
w="[47m   [0m"
b="[44m   [0m"
m=("   " "   " "   " "   " "   " "   " "   " "   " "   "
	"   " "   " "   " "   " "   " "   " "   " "   " "   "
	"   " "   " "   " "   " "   " "   " "   " "   " "   "
	"   " "   " "   " "   " "   " "   " "   " "   " "   "
	"   " "   " "   " "   " "   " "   " "   " "   " "   "
	"   " "   " "   " "   " "   " "   " "   " "   " "   "
	"   " "   " "   " "   " "   " "   " "   " "   " "   "
	"   " "   " "   " "   " "   " "   " "   " "   " "   ")
is_blue=0
blue_location=-3
map1_location=-2
show_map1(){
    clear
    echo ""
    echo -e "                  _  _____ _____  _    __  ____  __ "
    echo -e "                 / \|_   _|_   _|/ \   \ \/ /\ \/ / "
    echo -e "                / _ \ | |   | | / _ \   \  /  \  /  "
    echo -e "               / ___ \| |   | |/ ___ \  /  \  /  \  "
    echo -e "              /_/   \_\_|   |_/_/   \_\/_/\_\/_/\_\ "
    echo ""
    echo -e "                ┌───┬───┬───┬───┬───┬───┬───┬───┐"
    echo -e "                │${m[0]}│${m[1]}│${m[2]}│${m[3]}│${m[4]}│${m[5]}│${m[6]}│${m[7]}│"
    echo -e "                ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo -e "                │${m[8]}│${m[9]}│${m[10]}│${m[11]}│${m[12]}│${m[13]}│${m[14]}│${m[15]}│"
    echo -e "                ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo -e "                │${m[16]}│${m[17]}│${m[18]}│${m[19]}│${m[20]}│${m[21]}│${m[22]}│${m[23]}│"
    echo -e "                ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo -e "                │${m[24]}│${m[25]}│${m[26]}│${m[27]}│${m[28]}│${m[29]}│${m[30]}│${m[31]}│"
    echo -e "                ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo -e "                │${m[32]}│${m[33]}│${m[34]}│${m[35]}│${m[36]}│${m[37]}│${m[38]}│${m[39]}│"
    echo -e "                ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo -e "                │${m[40]}│${m[41]}│${m[42]}│${m[43]}│${m[44]}│${m[45]}│${m[46]}│${m[47]}│"
    echo -e "                ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo -e "                │${m[48]}│${m[49]}│${m[50]}│${m[51]}│${m[52]}│${m[53]}│${m[54]}│${m[55]}│"
    echo -e "                ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo -e "                │${m[56]}│${m[57]}│${m[58]}│${m[59]}│${m[60]}│${m[61]}│${m[62]}│${m[63]}│"
    echo -e "                └───┴───┴───┴───┴───┴───┴───┴───┘"
    echo ""
    echo ""
    echo -en "              1P: "
    echo "                          2P: 0"
    echo ""
    input_map1
}

input_map1(){
	read -n 1 opt 	
	if [[ $opt == '' ]]; then
		read -n 1 opt
			if [[ $opt == '[' ]] ;then
					read -n 1 opt
					if [ $opt == 'A' ] #up
					then
						if [ $map1_location == '-2' ]
							then
							map1_location=63
						elif [ $map1_location -le '7' ]
							then
							map1_location=`expr $map1_location + 56 `
						else
							map1_location=`expr $map1_location - 8`
						fi
					elif [ $opt == 'B' ] 
					then #down
						if [ $map1_location == '-2' ]
							then
							map1_location=63
						elif [ $map1_location -ge '56' ]
						then
							map1_location=`expr $map1_location - 56`
						else
						map1_location=`expr $map1_location + 8`
						fi
					elif [ $opt == 'C' ]
					then #right
						if [ $map1_location == '-2' ]
							then
							map1_location=63
						elif [ $map1_location == '63' ]
						then
							map1_location=63
						else
						map1_location=`expr $map1_location + 1`
						fi
					elif [ $opt == 'D' ] 
					then #left
						if [ $map1_location == '-2' ]
							then
								map1_location=63
						elif [ $map1_location == '0' ]
							then map1_location=0
						else
						map1_location=`expr $map1_location - 1`
						fi
					fi
				
				if [ m[$map1_location] == $b ];then
					is_blue=1
					blue_location=$map1_location
					m[$map1_location]=$w
				else
					m[$map1_location]=$w
					is_blue=0
				fi
	if [[ $is_blue == '0' ]]; then
		m[$map1_location]="   "
	elif [[ $is_blue == '1' ]]; then
		m[$blue_location]=$b
	fi	
			show_map1
			fi
	elif [[ $opt = `` ]];then
		is_blue=1
		blue_location=$map1_location
		m[$blue_location]=$b
		show_map1
	fi
}
show_map1
exit 0
