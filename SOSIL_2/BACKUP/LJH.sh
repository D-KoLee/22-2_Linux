#!/bin/bash
clear

width="═"
length="║"
topLeft="╔"
topMiddle="╦"
topRight="╗"
middleLeft="╠"
middle="╬"
middleRight="╣"
bottomLeft="╚"
bottomRight="╝"
bottomMiddle="╩"
userGameX=-1
userGameY=-1
space=' '
colorSpace="\033[43m$space\033[0m"
userColorSpace="\033[47m$space\033[0m"
selectColorSpace="\033[44m$space\033[0m"
cps="$colorSpace$colorSpace$colorSpace"

gameTurn=0
gameTurn2=0
SELECTX=()
SELECTY=()
selectX2=(1 2 3 4 3 4 2 1 6 5 1 2)
selectY2=(1 2 3 4 4 3 5 6 6 5 6 5)
arrLen=0
arrLen2=12

isRunning=1
nowPage=0
nowStartPageCursor=-1
nowAuthPageCursor=-1
nowSignOutPageCursor=-1
nowGamePageCursor=-1
nowGamePage=1
nowJoinPageCursor=-1
nowSelectPageCursor=-1

authId="ID"
authPassword="PS"
isId=0
isPs=0
isAuth=0

id1p="1PLOGIN"
password1p=""
id2p="2PLOGIN"
password2p=""

arrow=`printf "\033"`
file=`cat ./auth.txt`
database=`echo $file`
databaseArr=`echo $database | tr "\n ", "\n"`
dq=','

gameId="ID"
gamePassword="PS"
firstUserId=""
firstUserPassword=""
secondUserId=""
secondUserPassword=""
isDeletePointStart=0
isDeletePointEnd=0

abs()
{
    if [ $nowStartPageCursor -lt 0 ];then
	nowStartPageCursor=$(($nowStartPageCursor*-1))
	if [ $nowStartPageCursor -eq 1 ]; then
	    nowStartPageCursor=3
	fi
    fi
}
modStartPage()
{
    if [ $nowStartPageCursor -eq 6 ]; then
	nowStartPageCursor=0
    elif [ $nowStartPageCursor -eq 7 ]; then
	nowStartPageCursor=1
    fi
}
printMap1()
{
    i=0
    j=0
    map=$space
    useLine=0
    line=$space
    while [ $i -lt 9 ]
    do
	while [ $j -lt 8 ]
	do  
	    if [ $i -eq 8 ]; then
		userLine=0
		if [ $j -eq 0 ]; then
		    line=$line$bottomLeft$width$width$width$bottomMiddle
		elif [ $j -eq 7 ]; then
		    line=$line$width$width$width$bottomRight
		else
		    line=$line$width$width$width$bottomMiddle
		fi
	
		if [ $j -eq 0 ]; then
		    map=$map$bottomLeft$width$width
		elif [ $j -eq 7 ]; then
		    map=$map$bottomRight$width$width
		else
		    map=$map$width$width$width$width$width
		fi
		useLine=0
		j=$(($j + 1))
		continue
	    else
		k=0
	        canSet=1

		while [ $k -lt $arrLen ];
		do
		    if [ ${SELECTX[$k]} -eq $j ] && [ ${SELECTY[$k]} -eq $i ]; then
			canSet=0
		    fi
		    k=$(($k + 1))
		done
		if [ $canSet -eq 0 ]; then
		    map=$map$length$selectColorSpace$selectColorSpace$selectColorSpace
		elif [ $userGameY -eq $i ] && [ $userGameX -eq $j ]; then
		    map=$map$length$userColorSpace$userColorSpace$userColorSpace
		else
		    map=$map$length$space$space$space
		fi
		useLine=1
		if [ $j -eq 7 ]; then
		    map=$map$length
		fi
	    fi
	    if [ $i -eq 0 ] && [ $j -eq 0 ]; then
		line=$line$topLeft$width$width$width$topMiddle
	    elif [ $i -eq 0 ] && [ $j -eq 7 ]; then
		line=$line$width$width$width$topRight
	    elif [ $i -eq 0 ]; then
		line=$line$width$width$width$topMiddle
	    elif [ $j -eq 0 ]; then
		line=$line$middleLeft$width$width$width$middle
	    elif [ $j -eq 7 ]; then
		line=$line$width$width$width$middleRight
	    else
		line=$line$width$width$width$middle
	    fi
	    j=$(($j + 1))
	done
	
	if [ $i -eq 8 ]; then
	    echo -e "$line"
	fi
	if [ $useLine -eq 1 ]; then
	    echo -e "$line"
	    echo -e "$map"
	fi
	map=$space
	line=$space
	j=0
	i=$(($i + 1))
    done
}
printMap2()
{
    i=0
    j=0
    map=$space
    useLine=0
    line=$space
    while [ $i -lt 9 ]
    do
	while [ $j -lt 8 ]
	do  
	    if [ $i -eq 8 ]; then
		userLine=0
		if [ $j -eq 0 ]; then
		    line=$line$bottomLeft$width$width$width$bottomMiddle
		elif [ $j -eq 7 ]; then
		    line=$line$width$width$width$bottomRight
		else
		    line=$line$width$width$width$bottomMiddle
		fi
	
		if [ $j -eq 0 ]; then
		    map=$map$bottomLeft$width$width
		elif [ $j -eq 7 ]; then
		    map=$map$bottomRight$width$width
		else
		    map=$map$width$width$width$width$width
		fi
		useLine=0
		j=$(($j + 1))
		continue
	    else
		k=0
	        canSet=1

		while [ $k -lt $arrLen2 ];
		do
		    if [ ${selectX2[$k]} -eq $j ] && [ ${selectY2[$k]} -eq $i ]; then
			canSet=0
		    fi
		    k=$(($k + 1))
		done

		if [ $userGameY -eq $i ] && [ $userGameX -eq $j ]; then
		    map=$map$length$userColorSpace$userColorSpace$userColorSpace
		elif [ $i -eq 1 ] && [ $j -eq 1 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $i -eq 1 ] && [ $j -eq 6 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $i -eq 2 ] && [ $j -eq 2 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $i -eq 3 ] && [ $j -eq 3 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $i -eq 4 ] && [ $j -eq 4 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $i -eq 3 ] && [ $j -eq 4 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $i -eq 4 ] && [ $j -eq 3 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $i -eq 5 ] && [ $j -eq 2 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $i -eq 6 ] && [ $j -eq 1 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $i -eq 5 ] && [ $j -eq 5 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $i -eq 6 ] && [ $j -eq 6 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $i -eq 2 ] && [ $j -eq 5 ]; then
		    map=$map$length$colorSpace$colorSpace$colorSpace
		elif [ $canSet -eq 0 ]; then
		    map=$map$length$selectColorSpace$selectColorSpace$selectColorSpace
		else
		    map=$map$length$space$space$space
		fi
		useLine=1
		if [ $j -eq 7 ]; then
		    map=$map$length
		fi
	    fi
	    if [ $i -eq 0 ] && [ $j -eq 0 ]; then
		line=$line$topLeft$width$width$width$topMiddle
	    elif [ $i -eq 0 ] && [ $j -eq 7 ]; then
		line=$line$width$width$width$topRight
	    elif [ $i -eq 0 ]; then
		line=$line$width$width$width$topMiddle
	    elif [ $j -eq 0 ]; then
		line=$line$middleLeft$width$width$width$middle
	    elif [ $j -eq 7 ]; then
		line=$line$width$width$width$middleRight
	    else
		line=$line$width$width$width$middle
	    fi
	    j=$(($j + 1))
	done
	
	if [ $i -eq 8 ]; then
	    echo -e "$line"
	fi
	if [ $useLine -eq 1 ]; then
	    echo -e "$line"
	    echo -e "$map"
	fi
	map=$space
	line=$space
	j=0
	i=$(($i + 1))
    done
}
while [ $isRunning -eq 1 ]
do
    clear
    if [ $nowPage -eq 0 ];then
	echo ' '
	echo ' '
	echo ' '
	echo '			             ____   ___  ____ ___ _     _     '
        echo '			            / ___| / _ \/ ___|_ _| |   / |    '
        echo '			            \___ \| | | \___ \| || |   | |    '
        echo '		                     ___) | |_| |___) | || |___| |    '
        echo '			            |____/ \___/|____/___|_____|_|    '                                             
	echo '			              _  _____  _    __  ____  __     '
        echo '			             / \|_   _|/ \   \ \/ /\ \/ /     '
        echo '			            / _ \ | | / _ \   \  /  \  /      '
        echo '		    	           / ___ \| |/ ___ \  /  \  /  \      '
	echo '			          /_/   \_\_/_/   \_\/_/\_\/_/\_\     '
        echo ''
	echo '	                                             202000985 LJH  '  
	echo ''
	echo ''

	if [ $nowStartPageCursor -eq -1 ]; then
	    echo -e "\t\t\033[44m\t     $id1p     \033[0m\t\t\033[44m\t     SIGN IN     \033[0m"    
	    echo ''
	    echo -e "\t\t\033[44m\t     $id2p     \033[0m\t\t\033[44m\t     SIGN OUT    \033[0m"
	    echo ''
	    echo -e "\t\t\t\t\033[44m\t     JOIN     \033[0m\033[44m\t     EXIT     \033[0m"
	elif [ $nowStartPageCursor -eq 0 ]; then	
	    echo -e "\t\t\033[41m\t     $id1p     \033[0m\t\t\033[44m\t     SIGN IN     \033[0m"    
	    echo ''
	    echo -e "\t\t\033[44m\t     $id2p     \033[0m\t\t\033[44m\t     SIGN OUT    \033[0m"
	    echo ''
	    echo -e "\t\t\t\t\033[44m\t     JOIN     \033[0m\033[44m\t     EXIT     \033[0m"
	elif [ $nowStartPageCursor -eq 1 ]; then  
	    echo -e "\t\t\033[44m\t     $id1p     \033[0m\t\t\033[41m\t     SIGN IN     \033[0m"    
	    echo ''
	    echo -e "\t\t\033[44m\t     $id2p     \033[0m\t\t\033[44m\t     SIGN OUT    \033[0m"
	    echo ''
	    echo -e "\t\t\t\t\033[44m\t     JOIN     \033[0m\033[44m\t     EXIT     \033[0m"
	elif [ $nowStartPageCursor -eq 2 ]; then
	    echo -e "\t\t\033[44m\t     $id1p     \033[0m\t\t\033[44m\t     SIGN IN     \033[0m"    
	    echo ''
	    echo -e "\t\t\033[41m\t     $id2p     \033[0m\t\t\033[44m\t     SIGN OUT    \033[0m"
	    echo ''
	    echo -e "\t\t\t\t\033[44m\t     JOIN     \033[0m\033[44m\t     EXIT     \033[0m"
	elif [ $nowStartPageCursor -eq 3 ]; then
	    echo -e "\t\t\033[44m\t     $id1p     \033[0m\t\t\033[44m\t     SIGN IN     \033[0m"    
	    echo ''
	    echo -e "\t\t\033[44m\t     $id2p     \033[0m\t\t\033[41m\t     SIGN OUT    \033[0m"
	    echo ''
	    echo -e "\t\t\t\t\033[44m\t     JOIN     \033[0m\033[44m\t     EXIT     \033[0m"
	elif [ $nowStartPageCursor -eq 4 ]; then
	    echo -e "\t\t\033[44m\t     $id1p     \033[0m\t\t\033[44m\t     SIGN IN     \033[0m"    
	    echo ''
	    echo -e "\t\t\033[44m\t     $id2p     \033[0m\t\t\033[44m\t     SIGN OUT    \033[0m"
	    echo ''
	    echo -e "\t\t\t\t\033[41m\t     JOIN     \033[0m\033[44m\t     EXIT     \033[0m"
	elif [ $nowStartPageCursor -eq 5 ]; then
	    echo -e "\t\t\033[44m\t     $id1p     \033[0m\t\t\033[44m\t     SIGN IN     \033[0m"    
	    echo ''
	    echo -e "\t\t\033[44m\t     $id2p     \033[0m\t\t\033[44m\t     SIGN OUT    \033[0m"
	    echo ''
	    echo -e "\t\t\t\t\033[44m\t     JOIN     \033[0m\033[41m\t     EXIT     \033[0m"
	fi
	
	read -n 1 firstI
	if [ $firstI == `` ]; then
	    if [ $nowStartPageCursor -eq 0 ]; then
		nowPage=1
		nowGamePage=1
	    elif [ $nowStartPageCursor -eq 1 ]; then
		nowPage=2
	    elif [ $nowStartPageCursor -eq 2 ]; then
		nowPage=1
		nowGamePage=2
	    elif [ $nowStartPageCursor -eq 3 ]; then
		nowPage=4
	    elif [ $nowStartPageCursor -eq 4 ]; then
		nowPage=5
	    elif [ $nowStartPageCursor -eq 5 ]; then
		nowPage=3
	    fi
	elif [ $firstI == $arrow ];then
	    read -n 1 secondI
	    if [ $secondI = '[' ]; then
		read -n 1 userStartPageInput
		if [ $nowStartPageCursor -eq -1 ]; then
		    nowStartPageCursor=0
		else
		    if [[ $userStartPageInput == "A" ]]; then
			nowStartPageCursor=$(($nowStartPageCursor-2))
			abs
			modStartPage
		    elif [[ $userStartPageInput == "B" ]]; then
			nowStartPageCursor=$(($nowStartPageCursor+2))
			abs
			modStartPage
		    elif [ $userStartPageInput == 'C' ]; then
			nowStartPageCursor=$(($nowStartPageCursor+1))
			abs
			modStartPage
		    elif [ $userStartPageInput == 'D' ]; then
			nowStartPageCursor=$(($nowStartPageCursor-1))
			abs
			modStartPage
		    fi
		fi
	    fi
	fi
    elif [ $nowPage -eq 7 ]; then
	echo '    _  _____  _    __  ____  __'
	echo '   / \|_   _|/ \   \ \/ /\ \/ /'
	echo '  / _ \ | | / _ \   \  /  \  / '
	echo ' / ___ \| |/ ___ \  /  \  /  \ '
	echo '/_/   \_\_/_/   \_\/_/\_\/_/\_\'
	printMap1
	echo -e "1p : $gameTurn \t\t\t 2p : $gameTurn2"
	
	read -n 1 firstI
	if [ $firstI == $space ]; then

	    k=0
	    canSet=1
	    while [ $k -lt $arrLen ];
	    do
		if [ "${SELECTX[$k]}" -eq $userGameX ] && [ "${SELECTY[$k]}" -eq $userGameY ]; then
		    canSet=0
		fi
		k=$(($k + 1))
	    done
	    if [ $canSet -eq 1 ]; then
		SELECTX[$arrLen]=$userGameX
		SELECTY[$arrLen]=$userGameY
		arrLen=$(($arrLen + 1))
		gameTurn=$(($gameTurn + 1))
		echo -e "hiiiiii $arrLen"
	    fi
	elif [ $firstI == $arrow ];then
	    read -n 1 secondI
	    if [ $secondI = '[' ]; then
		read -n 1 userInput
		if [ $userGameX -eq -1 ]; then
		    userGameX=7
		    userGameY=7
		else
		    if [ $userInput == "A" ]; then
			if [ $userGameY -eq 0 ]; then
			    userGameY=0
			else
			    userGameY=$(($userGameY - 1))
			fi
		    elif [ $userInput == "B" ]; then
			if [ $userGameY -eq 7 ]; then
			    userGameY=7
			else
			    userGameY=$(($userGameY + 1))
			fi
		    elif [ $userInput == 'D' ]; then
			if [ $userGameX -eq 0 ]; then
			    userGameX=0
			else
			    userGameX=$(($userGameX - 1))
			fi
		    elif [ $userInput == 'C' ]; then
			if [ $userGameX -eq 7 ]; then
			    userGameX=7
			else
			    userGameX=$(($userGameX + 1))
			fi
		    fi
		fi
	    fi
	fi
    elif [ $nowPage -eq 8 ]; then
	
	echo '    _  _____  _    __  ____  __'
	echo '   / \|_   _|/ \   \ \/ /\ \/ /'
	echo '  / _ \ | | / _ \   \  /  \  / '
	echo ' / ___ \| |/ ___ \  /  \  /  \ '
	echo '/_/   \_\_/_/   \_\/_/\_\/_/\_\'
	printMap2
	echo -e "1p : $gameTurn \t\t\t 2p : $gameTurn2"
	
	read -n 1 firstI
	if [ $firstI == $space ]; then

	    k=0
	    canSet=1
	    while [ $k -lt $arrLen2 ];
	    do
		if [ "${selectX2[$k]}" -eq $userGameX ] && [ "${selectY2[$k]}" -eq $userGameY ]; then
		    canSet=0
		fi
		k=$(($k + 1))
	    done
	    if [ $canSet -eq 1 ]; then
		selectX2[$arrLen2]=$userGameX
		selectY2[$arrLen2]=$userGameY
		arrLen2=$(($arrLen2 + 1))
		gameTurn=$(($gameTurn + 1))
	    fi
	elif [ $firstI == $arrow ];then
	    read -n 1 secondI
	    if [ $secondI = '[' ]; then
		read -n 1 userInput
		if [ $userGameX -eq -1 ]; then
		    userGameX=7
		    userGameY=7
		else
		    if [ $userInput == "A" ]; then
			if [ $userGameY -eq 0 ]; then
			    userGameY=0
			else
			    userGameY=$(($userGameY - 1))
			fi
		    elif [ $userInput == "B" ]; then
			if [ $userGameY -eq 7 ]; then
			    userGameY=7
			else
			    userGameY=$(($userGameY + 1))
			fi
		    elif [ $userInput == 'D' ]; then
			if [ $userGameX -eq 0 ]; then
			    userGameX=0
			else
			    userGameX=$(($userGameX - 1))
			fi
		    elif [ $userInput == 'C' ]; then
			if [ $userGameX -eq 7 ]; then
			    userGameX=7
			else
			    userGameX=$(($userGameX + 1))
			fi
		    fi
		fi
	    fi
	fi
    elif [ $nowPage -eq 6 ]; then
	echo ''
	echo ''

	echo '			    _  _____  _    __  ____  __'
	echo '			   / \|_   _|/ \   \ \/ /\ \/ /'
        echo '			  / _ \ | | / _ \   \  /  \  /'
        echo '			 / ___ \| |/ ___ \  /  \  /  \'
        echo '			/_/   \_\_/_/   \_\/_/\_\/_/\_\'
	echo ''

        echo '		 __  __    _    ____    ____  _____ _     _____ ____ _____ '
        echo '		|  \/  |  / \  |  _ \  / ___|| ____| |   | ____/ ___|_   _|'
        echo '		| |\/| | / _ \ | |_) | \___ \|  _| | |   |  _|| |     | | '
        echo '		| |  | |/ ___ \|  __/   ___) | |___| |___| |__| |___  | |  '
        echo '		|_|  |_/_/   \_\_|     |____/|_____|_____|_____\____| |_|  '
	echo ''
	echo ''

	echo -e " ╔═══╦═══╦═══╦═══╦═══╦═══╦═══╦═══╗\t\t\t\t╔═══╦═══╦═══╦═══╦═══╦═══╦═══╦═══╗"
	echo -e " ║   ║   ║   ║   ║   ║   ║   ║   ║\t\t\t\t║   ║   ║   ║   ║   ║   ║   ║   ║"
	echo -e " ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣\t\t\t\t╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
	echo -e " ║   ║   ║   ║   ║   ║   ║   ║   ║\t\t\t\t║   ║$cps║   ║   ║   ║   ║$cps║   ║"	
	echo -e " ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣\t\t\t\t╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
	echo -e " ║   ║   ║   ║   ║   ║   ║   ║   ║\t\t\t\t║   ║   ║$cps║   ║   ║$cps║   ║   ║"
	echo -e " ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣\t\t\t\t╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
	echo -e " ║   ║   ║   ║   ║   ║   ║   ║   ║\t\t\t\t║   ║   ║   ║$cps║$cps║   ║   ║   ║"
	echo -e " ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣\t\t\t\t╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
	echo -e " ║   ║   ║   ║   ║   ║   ║   ║   ║\t\t\t\t║   ║   ║   ║$cps║$cps║   ║   ║   ║"	
	echo -e " ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣\t\t\t\t╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
	echo -e " ║   ║   ║   ║   ║   ║   ║   ║   ║\t\t\t\t║   ║   ║$cps║   ║   ║$cps║   ║   ║"
	echo -e " ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣\t\t\t\t╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
	echo -e " ║   ║   ║   ║   ║   ║   ║   ║   ║\t\t\t\t║   ║$cps║   ║   ║   ║   ║$cps║   ║"	
	echo -e " ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣\t\t\t\t╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"
	echo -e " ║   ║   ║   ║   ║   ║   ║   ║   ║\t\t\t\t║   ║   ║   ║   ║   ║   ║   ║   ║"
	echo -e " ╚═══╩═══╩═══╩═══╩═══╩═══╩═══╩═══╝\t\t\t\t╚═══╩═══╩═══╩═══╩═══╩═══╩═══╩═══╝"

	if [ $nowSelectPageCursor -eq -1 ]; then
	    echo -e "\033[44m\t     MAP 1     \033[0m\t\t\t\t\t\t\033[44m\t     MAP 2     \033[0m"    
	elif [ $nowSelectPageCursor -eq 0 ]; then
	    echo -e "\033[41m\t     MAP 1     \033[0m\t\t\t\t\t\t\033[44m\t     MAP 2     \033[0m"    
	elif [ $nowSelectPageCursor -eq 1 ]; then
	    echo -e "\033[44m\t     MAP 1     \033[0m\t\t\t\t\t\t\033[41m\t     MAP 2     \033[0m"    
	fi

	read -n 1 firstI
	if [ $firstI == $space ]; then
	    if [ $nowSelectPageCursor -eq 0 ]; then
		nowPage=7
	    elif [ $nowSelectPageCursor -eq 1 ]; then
		nowPage=8
	    fi
	elif [ $firstI == $arrow ];then
	    read -n 1 secondI
	    if [ $secondI = '[' ]; then
		read -n 1 userSelectPageInput
		if [ $nowSelectPageCursor -eq -1 ]; then
		    nowSelectPageCursor=0
		else
		    if [ $userSelectPageInput == "A" ]; then
			nowSelectPageCursor=$((($nowSelectPageCursor + 1) % 2))
		    elif [ $userSelectPageInput == "B" ]; then
			nowSelectPageCursor=$((($nowSelectPageCursor + 1) % 2))
		    elif [ $userSelectPageInput == 'C' ]; then
			nowSelectPageCursor=$((($nowSelectPageCursor + 1) % 2))
		    elif [ $userSelectPageInput == 'D' ]; then
			nowSelectPageCursor=$((($nowSelectPageCursor + 1) % 2))
		    fi
		fi
	    fi
	fi
    elif [ $nowPage -eq 5 ]; then
	if [ "$id1p" == "1PLOGIN" ] || [ "$id2p" == "2PLOGIN" ]; then
	    echo 'hi'  
	fi
	win1p=0
	lose1p=0
	win2p=0
	lose2p=0

	isAuth=0
	isId=0
	isPs=0
	k=0
	for d in $databaseArr
	do  
	    if [ $k -eq 1 ]; then
		break;
	    elif [ $isAuth -eq 1 ]; then
		if [ $k -eq 0 ]; then
		    lose1p=$d
		fi
		k=$(($k + 1))
		continue
	    fi
	    if [ $isId -eq 1 ] && [ $isPs -eq 1 ]; then
		isAuth=1
		win1p=$d
		echo -e "$d"
	    fi

	    if [ $isId -eq 1 ] && [ $d = "$password1p" ]; then
		isPs=1
	    elif [ $d = "\"$id1p" ]; then
		isId=1
	    else
		isId=0
		isPs=0
	    fi
	done
    
	isAuth=0
	isId=0
	isPs=0
	k=0
	for d in $databaseArr
	do  
	    if [ $k -eq 1 ]; then
		break;
	    elif [ $isAuth -eq 1 ]; then
		if [ $k -eq 0 ]; then
		    lose2p=$d
		fi
		k=$(($k + 1))
		continue
	    fi
	    if [ $isId -eq 1 ] && [ $isPs -eq 1 ]; then
		isAuth=1
		win2p=$d
	    fi

	    if [ $isId -eq 1 ] && [ $d = "$password2p" ]; then
		isPs=1
	    elif [ $d = "\"$id2p" ]; then
		isId=1
	    else
		isId=0
		isPs=0
	    fi
	done

	set1pSpace=""
	set2pSpace=""
	space=" "
	k=0
	while [ $k -lt $((${#id1p} - ${#win1p})) ]
	do
	    set1pSpace=$set1pSpace$space
	    k=$(($k + 1))
	done
	k=0
	while [ $k -lt $((${#id2p} - ${#win2p})) ]
	do
	    set2pSpace=$set2pSpace$space
	    k=$(($k + 1))
	done
	echo ''
	echo ''
	echo ''
	echo '                          / \|_   _|/ \    \ \/ /\ \/ /'
	echo '                         / _ \ | | / _ \    \  /  \  / '
	echo '                        / ___ \| |/ ___ \   /  \  /  \ '
	echo '                       /_/   \_\_/_/   \_\ /_/\_\/_/\_\'
	echo ''
	echo '                       _     ___  ____  ______   __'
	echo '                      | |   / _ \| __ )| __ ) \ / /'
	echo '                      | |  | | | |  _ \|  _ \\ V /' 
	echo '                      | |__| |_| | |_) | |_) || |'  
	echo '                      |_____\___/|____/|____/ |_|'  

	echo ''
	echo ''
	echo ''
	
	echo '           _ ____			     ____  ____'  
	echo '          / |  _ \			    |___ \|  _ \ '
	echo '          | | |_) |			      __) | |_) |'
	echo '          | |  __/		 	     / __/|  __/' 
	echo '	  |_|_|				    |_____|_|'
	echo ''
	echo ''

	echo -e "           1p   : $id1p \t\t\t  2p   : $id2p   "
	echo -e "           win  : $win1p\t\t\t   $set1pSpace win  : $win2p  "
	echo -e "           lose : $lose2p\t\t\t  $set2pSpace lose : $lose2p " 
	echo ''
	echo ''
	if [ $nowJoinPageCursor -eq -1 ]; then
	    echo -e "\t\t\033[44m\t   START   \033[0m\t\t\033[44m\t   EXIT    \033[0m"
	elif [ $nowJoinPageCursor -eq 0 ]; then
	    echo -e "\t\t\033[41m\t   START   \033[0m\t\t\033[44m\t   EXIT    \033[0m"
	elif [ $nowJoinPageCursor -eq 1 ]; then
	    echo -e "\t\t\033[44m\t   START   \033[0m\t\t\033[41m\t   EXIT    \033[0m"
	fi

	read -n 1 firstI
	if [ $nowJoinPageCursor -eq -1 ]; then
	    nowJoinPageCursor=0   
	elif [ $firstI == `` ]; then
	    if [ $nowJoinPageCursor == 0 ]; then
		nowPage=6
	    elif [ $nowJoinPageCursor == 1 ]; then
		clear
		exit 0
	    fi
	elif [ $firstI == $arrow ]; then
	    read -n 1 secondI
	    if [ $secondI == '[' ]; then
		read -n 1 signI
		if [ $signI == 'A' ] || [ $signI == 'B' ] || [ $signI == 'C' ] || [ $signI == 'D' ]; then
		    nowJoinPageCursor=$((($nowJoinPageCursor + 1) % 2))
		fi
	    fi
	fi

    elif [ $nowPage -eq 3 ]; then
	isRunning=0
    elif [ $nowPage -eq 4 ]; then
	
	echo ''
	echo ''
	echo ''
	echo '				 ____ ___ ____ _   _    ___  _   _ _____ '
        echo '				/ ___|_ _/ ___| \ | |  / _ \| | | |_   _|'
        echo '				\___ \| | |  _|  \| | | | | | | | | | |'  
        echo '				 ___) | | |_| | |\  | | |_| | |_| | | |' 
	echo '				|____/___\____|_| \_|  \___/ \___/  |_|' 
        echo ''                                                
	echo ''
	
	if [ $nowSignOutPageCursor -eq -1 ]; then
	    echo -e "\t\t\t\033[44m\t\t        $authId        \033[0m"
	    echo ''
	    echo -e "\t\t\t\033[44m\t\t        $authPassword        \033[0m"
	    echo ''
	    echo ''
	    echo -e "\t\t\033[44m\t     SIGN OUT     \033[0m\t\033[44m\t     EXIT     \033[0m"
	elif [ $nowSignOutPageCursor -eq 0 ]; then
	    echo -e "\t\t\t\033[41m\t\t        $authId        \033[0m"
	    echo ''
	    echo -e "\t\t\t\033[44m\t\t        $authPassword        \033[0m"
	    echo ''
	    echo ''
	    echo -e "\t\t\033[44m\t     SIGN OUT     \033[0m\t\033[44m\t     EXIT     \033[0m"
	elif [ $nowSignOutPageCursor -eq 1 ]; then
	    echo -e "\t\t\t\033[44m\t\t        $authId        \033[0m"
	    echo ''
	    echo -e "\t\t\t\033[41m\t\t        $authPassword        \033[0m"
	    echo ''
	    echo ''
	    echo -e "\t\t\033[44m\t     SIGN OUT     \033[0m\t\033[44m\t     EXIT     \033[0m"
	elif [ $nowSignOutPageCursor -eq 2 ]; then
	    echo -e "\t\t\t\033[44m\t\t        $authId        \033[0m"
	    echo ''
	    echo -e "\t\t\t\033[44m\t\t        $authPassword        \033[0m"
	    echo ''
	    echo ''
	    echo -e "\t\t\033[41m\t     SIGN OUT     \033[0m\t\033[44m\t     EXIT     \033[0m"
	elif [ $nowSignOutPageCursor -eq 3 ]; then
	    echo -e "\t\t\t\033[44m\t\t        $authId        \033[0m"
	    echo ''
	    echo -e "\t\t\t\033[44m\t\t        $authPassword        \033[0m"
	    echo ''
	    echo ''
	    echo -e "\t\t\033[44m\t     SIGN OUT     \033[0m\t\033[41m\t     EXIT     \033[0m"
	fi
	
	read -n 1 firstI
	if [ $firstI == `` ]; then
	    if [ $nowSignOutPageCursor -eq 0 ]; then
		read inputId
		authId=$inputId
	    elif [ $nowSignOutPageCursor -eq 1 ]; then
		read inputPs
		authPassword=$inputPs
	    elif [ $nowSignOutPageCursor -eq 2 ]; then
		i=0
		for d in $databaseArr
		do
		    if [ $isId -eq 1 ] && [ $isPs -eq 1 ];then
			isAuth=1
			isDeletePointEnd=$(($i + ${#d}))
			break
		    fi
		    if [ $isId -eq 1 ] && [ $d = $authPassword ]; then
			isPs=1
		    elif [ $d = "\"$authId" ]; then
			isId=1
			isDeletePointStart=$i
		    else
			isDeletePointEnd=0
			isDeletePointStart=0
			isId=0
			isPs=0
		    fi
		    i=$(($i + ${#d})) 
		done
		if [ $isAuth -eq 1 ]; then
		    isDeletePointStart=$(($isDeletePointStart - 1))
		    isDeletePointEnd=$(($isDeletePointEnd + 8))
		    databaseEnd=${#database}
		    frontData=${database:0:$isDeletePointStart}
		    endData=${database:$isDeletePointEnd}
		    echo $frontData$space$endData > ./auth.txt
		    sleep 1
		    isRunning=0
		else
		    isRunning=0
		fi
	    elif [ $nowSignOutPageCursor -eq 3 ]; then
		isRunning=0
	    fi
	elif [ $firstI == $arrow ]; then
	    read -n 1 secondI
	    if [ $secondI == '[' ]; then
		read -n 1 nowSignOutInput
		if [ $nowSignOutPageCursor -eq -1 ]; then
		    nowSignOutPageCursor=0
		elif [ $nowSignOutInput == "A" ]; then
		    if [ $nowSignOutPageCursor -eq 2 ] || [ $nowSignOutPageCursor -eq 3 ]; then
			nowSignOutPageCursor=1
		    elif [ $nowSignOutPageCursor -eq 1 ]; then
			nowSignOutPageCursor=0
		    elif [ $nowSignOutPageCursor -eq 0 ]; then
			nowSignOutPageCursor=3
		    fi
		elif [ $nowSignOutInput == "B" ]; then
		    if [ $nowSignOutPageCursor -eq 0 ]; then
			nowSignOutPageCursor=1
		    elif [ $nowSignOutPageCursor -eq 1 ]; then
			nowSignOutPageCursor=2
		    elif [ $nowSignOutPageCursor -eq 2 ] || [ $nowSignOutPageCursor -eq 3 ]; then
			nowSignOutPageCursor=0
		    fi	
		elif [ $nowSignOutInput == "C" ]; then
		    nowSignOutPageCursor=$(($nowSignOutPageCursor + 1))
		    if [ $nowSignOutPageCursor -eq 4 ]; then
			nowSignOutPageCursor=0
		    fi
		elif [ $nowSignOutInput == "D" ]; then
		    nowSignOutPageCursor=$(($nowSignOutPageCursor - 1))
		    if [ $nowSignOutPageCursor -eq -1 ]; then
			nowSignOutPageCursor=3
		    fi
		fi
	    fi
	fi

    elif [ $nowPage -eq 2 ]; then
	echo ''
	echo ''
	echo ''
	echo '				 ____ ___ ____ _   _   ___ _   _	' 
        echo '				/ ___|_ _/ ___| \ | | |_ _| \ | |	'
        echo '				\___ \| | |  _|  \| |  | ||  \| |	'
        echo '				 ___) | | |_| | |\  |  | || |\  |   '
        echo '				|____/___\____|_| \_| |___|_| \_|	'
	echo ''
	echo ''

	if [ $nowAuthPageCursor -eq -1 ];then
	    echo -e "\t\t\033[44m\t\t         $authId         \033[0m\t\033[44m DUPLICATE CHECK \033[0m"
	    echo ''
	    echo -e "\t\t\033[44m\t\t         $authPassword         \033[0m"
	    echo ''
	    echo ''
	    echo -e "\t\t\033[44m\t     SIGN IN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	elif [ $nowAuthPageCursor -eq 0 ];then
	    echo -e "\t\t\033[41m\t\t         $authId         \033[0m\t\033[44m DUPLICATE CHECK \033[0m"
	    echo ''
	    echo -e "\t\t\033[44m\t\t         $authPassword         \033[0m"
	    echo ''
	    echo ''
	    echo -e "\t\t\033[44m\t     SIGN IN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	elif [ $nowAuthPageCursor -eq 1 ];then
	    echo -e "\t\t\033[44m\t\t         $authId         \033[0m\t\033[41m DUPLICATE CHECK \033[0m"
	    echo ''
	    echo -e "\t\t\033[44m\t\t         $authPassword         \033[0m"
	    echo ''
	    echo ''
	    echo -e "\t\t\033[44m\t     SIGN IN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	elif [ $nowAuthPageCursor -eq 2 ];then
	    echo -e "\t\t\033[44m\t\t         $authId         \033[0m\t\033[44m DUPLICATE CHECK \033[0m"
	    echo ''
	    echo -e "\t\t\033[41m\t\t         $authPassword         \033[0m"
	    echo ''
	    echo ''
	    echo -e "\t\t\033[44m\t     SIGN IN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	elif [ $nowAuthPageCursor -eq 3 ];then
	    echo -e "\t\t\033[44m\t\t         $authId         \033[0m\t\033[44m DUPLICATE CHECK \033[0m"
	    echo ''
	    echo -e "\t\t\033[44m\t\t         $authPassword         \033[0m"
	    echo ''
	    echo ''
	    echo -e "\t\t\033[41m\t     SIGN IN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	elif [ $nowAuthPageCursor -eq 4 ];then
	    echo -e "\t\t\033[44m\t\t         $authId         \033[0m\t\033[44m DUPLICATE CHECK \033[0m"
	    echo ''
	    echo -e "\t\t\033[44m\t\t         $authPassword         \033[0m"
	    echo ''
	    echo ''
	    echo -e "\t\t\033[44m\t     SIGN IN     \033[0m\t\033[41m\t     EXIT     \033[0m"
	fi

	read -n 1 firstI
	if [ $firstI = `` ]; then
	    if [ $nowAuthPageCursor -eq 4 ]; then
		isRunning=0
	    elif [ $nowAuthPageCursor -eq 0 ]; then
		read inputId
		authId=$inputId
	    elif [ $nowAuthPageCursor -eq 1 ]; then
		for d in $databaseArr
		do
		    if [ $isId -eq 1 ] && [ $isPs -eq 1 ]; then
			isAuth=1
			break
		    fi
		    if [ $isId -eq 1 ] && [ $d = "$authPassword" ]; then
			isPs=1
		    elif [ $d = "\"$authId" ]; then
			isId=1
		    else
			isId=0
			isPs=0
		    fi
		done

		if [ $isAuth -eq 1 ]; then
		    echo -e "\t\t\t Already Authlized"
		    sleep 1
		    isRunning=0
		else
		    echo -e "\"$authId"
		    echo -e "\t\t\t $isAuth You can Sign In"
		    sleep 1
		    isRunning=0
		fi
	    elif [ $nowAuthPageCursor -eq 2 ]; then
		read inputPS
		authPassword=$inputPS
	    elif [ $nowAuthPageCursor -eq 3 ]; then
		for d in $databaseArr
		do
		    if [ $isId -eq 1 ] && [ $isPs -eq 1 ]; then
			isAuth=1
			break
		    fi
		    if [ $isId -eq 1 ] && [ $d = "$authPassword" ]; then
			isPs=1
		    elif [ $d = "\"$authId" ]; then
			isId=1
		    else
			isId=0
			isPs=0
		    fi
		done

		if [ $isAuth -eq 1 ]; then
		    isRunning=0
		else
		    userData="\"$authId, $authPassword, 0, 0\""
		    echo -e "$userData" >> ./auth.txt
		    sleep 1
		    isRunning=0
		fi
	    fi
	elif [ $firstI == $arrow ];then
	    read -n 1 secondI
	    if [ $secondI = "[" ];then
		read -n 1 authPageInput
		if [ $nowAuthPageCursor -eq -1 ]; then
		    nowAuthPageCursor=0
		elif [ $authPageInput == "A" ];then
		    if [ $nowAuthPageCursor -ge 3 ]; then
			nowAuthPageCursor=2
		    elif [ $nowAuthPageCursor -eq 2 ]; then
			nowAuthPageCursor=0
		    elif [ $nowAuthPageCursor -le 1 ]; then
			nowAuthPageCursor=$(($nowAuthPageCursor + 3))
		    fi
		elif [ $authPageInput == "B" ]; then
		    if [ $nowAuthPageCursor -le 1 ]; then
			nowAuthPageCursor=2
		    elif [ $nowAuthPageCursor -eq 2 ]; then
			nowAuthPageCursor=3
		    elif [ $nowAuthPageCursor -ge 3 ]; then
			nowAuthPageCursor=$(($nowAuthPageCursor - 3))
		    fi
		elif [ $authPageInput == "C" ]; then
		    nowAuthPageCursor=$(($nowAuthPageCursor + 1))
		    if [ $nowAuthPageCursor -eq 5 ]; then
			nowAuthPageCursor=0
		    fi
		elif [ $authPageInput == "D" ]; then
		    nowAuthPageCursor=$(($nowAuthPageCursor - 1))
		    if [ $nowAuthPageCursor -eq -1 ]; then
			nowAuthPageCursor=4
		    fi
		fi
	    fi
	fi
    elif [ $nowPage -eq 1 ]; then
	if [ $nowGamePage -eq 1 ]; then
	    echo ''
	    echo ''
	    echo ''
	    echo '			 _ ____    _     ___   ____ ___ _   _ '
            echo '			/ |  _ \  | |   / _ \ / ___|_ _| \ | |'
            echo '			| | |_) | | |  | | | | |  _ | ||  \| |'
            echo '			| |  __/  | |__| |_| | |_| || || |\  |'
            echo '			|_|_|     |_____\___/ \____|___|_| \_|'
	    echo ''
	    echo ''
	
	elif [ $nowGamePage -eq 2 ]; then
	    echo ''
	    echo ''
	    echo ''
	    echo '			 ____  ____    _     ___   ____ ___ _   _'
            echo '			|___ \|  _ \  | |   / _ \ / ___|_ _| \ | |'
            echo '			  __) | |_) | | |  | | | | |  _ | ||  \| |'
            echo '			 / __/|  __/  | |__| |_| | |_| || || |\  |'
            echo '			|_____|_|     |_____\___/ \____|___|_| \_|'
	    echo ''
	    echo ''
	elif [ $nowGamePage -eq 3 ]; then
	    echo ''
	    echo ''
	    echo ''
	    echo '			 ____  _   _  ____ ____ _____ ____ ____ ' 
            echo '			/ ___|| | | |/ ___/ ___| ____/ ___/ ___|'
            echo '			\___ \| | | | |  | |   |  _| \___ \___ \' 
            echo '			 ___) | |_| | |__| |___| |___ ___) |__) |'
            echo '			|____/ \___/ \____\____|_____|____/____/ '
	    echo ''
	    echo ''
	fi
	
	if [ $nowGamePage -eq 1 ] || [ $nowGamePage -eq 2 ]; then
	    if [ $nowGamePageCursor -eq -1 ]; then
		echo -e "\t\t\033[44m\t\t         $gameId         \033[0m\t"
		echo ''
		echo -e "\t\t\033[44m\t\t         $gamePassword         \033[0m"
		echo ''
		echo ''
		echo -e "\t\t\033[44m\t     LOGIN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	    elif [ $nowGamePageCursor -eq 0 ]; then
		echo -e "\t\t\033[41m\t\t         $gameId         \033[0m\t"
		echo ''
		echo -e "\t\t\033[44m\t\t         $gamePassword         \033[0m"
		echo ''
		echo ''
		echo -e "\t\t\033[44m\t     LOGIN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	    elif [ $nowGamePageCursor -eq 1 ]; then
		echo -e "\t\t\033[44m\t\t         $gameId         \033[0m\t"
		echo ''
		echo -e "\t\t\033[41m\t\t         $gamePassword         \033[0m"
		echo ''
		echo ''
		echo -e "\t\t\033[44m\t     LOGIN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	    elif [ $nowGamePageCursor -eq 2 ]; then
		echo -e "\t\t\033[44m\t\t         $gameId         \033[0m\t"
		echo ''
		echo -e "\t\t\033[44m\t\t         $gamePassword         \033[0m"
		echo ''
		echo ''
		echo -e "\t\t\033[41m\t     LOGIN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	    elif [ $nowGamePageCursor -eq 3 ]; then
		echo -e "\t\t\033[44m\t\t         $gameId         \033[0m\t"
		echo ''
		echo -e "\t\t\033[44m\t\t         $gamePassword         \033[0m"
		echo ''
		echo ''
		echo -e "\t\t\033[44m\t     LOGIN     \033[0m\t\033[41m\t     EXIT     \033[0m"
	    fi
	fi

	read -n 1 firstI
	if [ $nowGamePageCursor -eq -1 ]; then
	    nowGamePageCursor=0
	elif [ $firstI = `` ]; then
	    if [ $nowGamePage -eq 3 ]; then
		sleep 1
		isRunning=0
	    fi
	    if [ $nowGamePageCursor -eq 0 ]; then
		read inputId
		gameId=$inputId
	    elif [ $nowGamePageCursor -eq 1 ]; then
		read inputPs
		gamePassword=$inputPs
	    elif [ $nowGamePageCursor -eq 3 ]; then
		isRunning=0
	    elif [ $nowGamePageCursor -eq 2 ]; then
		isAuth=0
		isId=0
		isPs=0
		for d in $databaseArr
		do
		    if [ $isId -eq 1 ] && [ $isPs -eq 1 ]; then
			if [ $firstUserId = $secondUserId ] && [ $firstUserPassword = $secondUserPassword ]; then
			    break;
			fi
			isAuth=1
			break
		    fi

		    if [ $isId -eq 1 ] && [ $d = "$gamePassword" ]; then
			isPs=1
			if [ $nowGamePage -eq 1 ]; then
			    firstUserPassword=$d
			elif [ $nowGamePage -eq 2 ]; then
			    secondUserPassword=$d
			fi
		    elif [ $d = "\"$gameId" ]; then
			isId=1
			if [ $nowGamePage -eq 1 ]; then
			    firstUserId=$d
			elif [ $nowGamePage -eq 2 ]; then
			    secondUserId=$d
			fi
		    else
			firstUserId=""
			firstUserPassword=""
			isId=0
			isPs=0
		    fi
		done

		if [ $nowGamePage -eq 1 ] || [ $nowGamePage -eq 2 ];then
		    if [ $isAuth -eq 1 ]; then
			if [ $nowGamePage -eq 1 ]; then
			    id1p=$gameId
			    password1p=$gamePassword
			elif [ $nowGamePage -eq 2 ]; then
			    id2p=$gameId
			    password2p=$gamePassword
			fi
			gameId="ID"
			gamePassword="PS"
			nowGamePageCursor=-1
			nowPage=0
			nowStartPageCursor=-1
		    else
			sleep 1
			isRunning=0
		    fi
		fi
	    fi
	elif [ $firstI = $arrow ]; then
	    read -n 1 secondI
	    if [ $secondI = '[' ]; then
		read -n 1 gamePageInput
		if [ $gamePageInput = 'A' ]; then
		    if [ $nowGamePageCursor -eq 0 ]; then
			nowGamePageCursor=3
		    elif [ $nowGamePageCursor -eq 1 ]; then
			nowGamePageCursor=0
		    elif [ $nowGamePageCursor -eq 2 ] || [ $nowGamePageCursor -eq 3 ];then
			nowGamePageCursor=1
		    fi
		elif [ $gamePageInput = 'B' ]; then
		    if [ $nowGamePageCursor -eq 0 ]; then
			nowGamePageCursor=1
		    elif [ $nowGamePageCursor -eq 1 ]; then
			nowGamePageCursor=2
		    elif [ $nowGamePageCursor -eq 2 ] || [ $nowGamePageCursor -eq 3 ]; then
			nowGamePageCursor=0
		    fi
		elif [ $gamePageInput = 'C' ]; then
		    nowGamePageCursor=$(($nowGamePageCursor + 1))
		    if [ $nowGamePageCursor -eq 4 ]; then
			nowGamePageCursor=0
		    fi
		elif [ $gamePageInput = 'D' ]; then
		    nowGamePageCursor=$(($nowGamePageCursor - 1))
		    if [ $nowGamePageCursor -eq -1 ]; then
			nowGamePageCursor=3
		    fi
		fi
	    fi
	fi
    fi
done
clear
exit 0
