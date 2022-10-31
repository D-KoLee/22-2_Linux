#!/bin/bash
clear

isRunning=1
nowPage=0
nowStartPageCursor=-1
nowAuthPageCursor=-1
nowSignOutPageCursor=-1
nowGamePageCursor=-1
nowGamePage=1

authId="ID"
authPassword="PS"
isId=0
isPs=0
isAuth=0

arrow=`printf "\033"`
file=`cat ./auth.txt`
database=`echo $file`
databaseArr=`echo $database | tr "\n ", "\n"`
dq=','
space=' '

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
    if [ $nowStartPageCursor -eq 4 ]; then
	nowStartPageCursor=0
    elif [ $nowStartPageCursor -eq 5 ]; then
	nowStartPageCursor=1
    fi
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
	    echo -e "\t\t\033[44m\t     JOIN     \033[0m\t\t\033[44m\t     SIGN IN     \033[0m"    
	    echo ''
	    echo -e "\t\t\033[44m\t     EXIT     \033[0m\t\t\033[44m\t     SIGN OUT    \033[0m"	
	elif [ $nowStartPageCursor -eq 0 ]; then
	    echo -e "\t\t\033[41m\t     JOIN     \033[0m\t\t\033[44m\t     SIGN IN     \033[0m"
	    echo ''
	    echo -e "\t\t\033[44m\t     EXIT     \033[0m\t\t\033[44m\t     SIGN OUT    \033[0m"
	elif [ $nowStartPageCursor -eq 1 ]; then
	    echo -e "\t\t\033[44m\t     JOIN     \033[0m\t\t\033[41m\t     SIGN IN     \033[0m"
	    echo ''
	    echo -e "\t\t\033[44m\t     EXIT     \033[0m\t\t\033[44m\t     SIGN OUT    \033[0m"
	elif [ $nowStartPageCursor -eq 2 ]; then
	    echo -e "\t\t\033[44m\t     JOIN     \033[0m\t\t\033[44m\t     SIGN IN     \033[0m"
	    echo ''
	    echo -e "\t\t\033[41m\t     EXIT     \033[0m\t\t\033[44m\t     SIGN OUT    \033[0m"
	elif [ $nowStartPageCursor -eq 3 ]; then
	    echo -e "\t\t\033[44m\t     JOIN     \033[0m\t\t\033[44m\t     SIGN IN     \033[0m"
	    echo ''
	    echo -e "\t\t\033[44m\t     EXIT     \033[0m\t\t\033[41m\t     SIGN OUT    \033[0m"
	fi
	
	read -n 1 firstI
	if [ $firstI == `` ]; then
	    if [ $nowStartPageCursor != -1 ]; then
		nowPage=$(($nowStartPageCursor + 1))
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
			isDeletePointEnd=$(($i + 2))
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
		    i=$(($i + 1)) 
		done

		if [ $isAuth -eq 1 ]; then
		    isDeletePointStart=$(($isDeletePointStart / 4 * 13))
		    isDeletePointEnd=$(($isDeletePointEnd / 4 * 13))
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
		echo -e "\t\t\033[44m\t     SIGN IN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	    elif [ $nowGamePageCursor -eq 0 ]; then
		echo -e "\t\t\033[41m\t\t         $gameId         \033[0m\t"
		echo ''
		echo -e "\t\t\033[44m\t\t         $gamePassword         \033[0m"
		echo ''
		echo ''
		echo -e "\t\t\033[44m\t     SIGN IN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	    elif [ $nowGamePageCursor -eq 1 ]; then
		echo -e "\t\t\033[44m\t\t         $gameId         \033[0m\t"
		echo ''
		echo -e "\t\t\033[41m\t\t         $gamePassword         \033[0m"
		echo ''
		echo ''
		echo -e "\t\t\033[44m\t     SIGN IN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	    elif [ $nowGamePageCursor -eq 2 ]; then
		echo -e "\t\t\033[44m\t\t         $gameId         \033[0m\t"
		echo ''
		echo -e "\t\t\033[44m\t\t         $gamePassword         \033[0m"
		echo ''
		echo ''
		echo -e "\t\t\033[41m\t     SIGN IN     \033[0m\t\033[44m\t     EXIT     \033[0m"
	    elif [ $nowGamePageCursor -eq 3 ]; then
		echo -e "\t\t\033[44m\t\t         $gameId         \033[0m\t"
		echo ''
		echo -e "\t\t\033[44m\t\t         $gamePassword         \033[0m"
		echo ''
		echo ''
		echo -e "\t\t\033[44m\t     SIGN IN     \033[0m\t\033[41m\t     EXIT     \033[0m"
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
			gameId="ID"
			gamePassword="PS"
			nowGamePageCursor=-1
			nowGamePage=$(($nowGamePage + 1))
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
