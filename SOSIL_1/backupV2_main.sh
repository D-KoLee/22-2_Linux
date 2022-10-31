#!/bin/bash

bcgJoin="[44m"
bcgSignIn="[44m"
bcgExit="[44m"
bcgSignOut="[44m"
cursor=0
nowCursor=-1

show_menu_main(){
    clear
    echo '                         ____   ___  ____ ___ _       _ '
    echo '                        / ___| / _ \/ ___|_ _| |     / |'
    echo '                        \___ \| | | \___ \| || |     | |'
    echo '                         ___) | |_| |___) | || |___  | |'
    echo '                        |____/ \___/|____/___|_____| |_|'
    echo '                            _  _____  _    __  ____  __'
    echo '                           / \|_   _|/ \   \ \/ /\ \/ /'
    echo '                          / _ \ | | / _ \   \  /  \  / '
    echo '                         / ___ \| |/ ___ \  /  \  /  \ '
    echo '                        /_/   \_\_/_/   \_\/_/\_\/_/\_\'
    echo ''
    echo '                                               201901268 YSJ'
    echo ''
    echo "                       ${bcgJoin}    JOIN    [0m" "        ${bcgSignIn}    SIGN IN    [0m"
    echo""
    echo "                       ${bcgExit}    EXIT    [0m" "        ${bcgSignOut}    SIGN OUT   [0m"

    option_picked
}

show_menu_SignIn(){
    clear
    echo '                        ____ ___ ____ _   _   ___ _   _ '
    echo '                       / ___|_ _/ ___| \ | | |_ _| \ | |'
    echo '                       \___ \| | |  _|  \| |  | ||  \| |'
    echo '                        ___) | | |_| | |\  |  | || |\  |'
    echo '                       |____/___\____|_| \_| |___|_| \_|'
    echo ''
    echo ''
    echo "                   ${bcgID}         ID         [0m" "   ${bcgDupCheck}  Duplicate check  [0m"
    echo ''
    echo "                   ${bcgPW}         PW         [0m"
    echo ''
    echo ''
    echo "                          ${bcgSignIn}  SIGN IN  [0m""     ${bcgExit}   EXIT   [0m "

    option_picked
}

show_menu_SignOut(){
    clear
    echo '                    ____ ___ ____ _   _    ___  _   _ _____ '
    echo '                   / ___|_ _/ ___| \ | |  / _ \| | | |_   _|'
    echo '                   \___ \| | |  _|  \| | | | | | | | | | |  '
    echo '                    ___) | | |_| | |\  | | |_| | |_| | | |  '
    echo '                   |____/___\____|_| \_|  \___/ \___/  |_|'
    echo ''
    echo ''
    echo "                   ${bcgID}         ID         [0m" "   ${bcgDupCheck}  Duplicate check  [0m"
    echo ''
    echo "                   ${bcgPW}         PW         [0m"
    echo ''
    echo ''
    echo "                          ${bcgSignIn}  SIGN IN  [0m""     ${bcgExit}   EXIT   [0m "

    option_picked
}

show_menu_SignOut(){
    clear
    echo '                      _ ____    _     ___   ____ ___ _   _'
    echo '                     / |  _ \  | |   / _ \ / ___|_ _| \ | |'
    echo '                     | | |_) | | |  | | | | |  _ | ||  \| |'
    echo '                     | |  __/  | |__| |_| | |_| || || |\  |'
    echo '                     |_|_|     |_____\___/ \____|___|_| \_|'
    echo ''
    echo ''
    echo "                   ${bcgID}         ID         [0m" "   ${bcgDupCheck}  Duplicate check  [0m"
    echo ''
    echo "                   ${bcgPW}         PW         [0m"
    echo ''
    echo ''
    echo "                          ${bcgSignIn}  SIGN IN  [0m""     ${bcgExit}   EXIT   [0m "

    option_picked
}

show_menu_SignOut(){
    clear
    echo '                    ____ ___ ____ _   _    ___  _   _ _____ '
    echo '                   / ___|_ _/ ___| \ | |  / _ \| | | |_   _|'
    echo '                   \___ \| | |  _|  \| | | | | | | | | | |  '
    echo '                    ___) | | |_| | |\  | | |_| | |_| | | |  '
    echo '                   |____/___\____|_| \_|  \___/ \___/  |_|'
    echo ''
    echo ''
    echo "                   ${bcgID}         ID         [0m" "   ${bcgDupCheck}  Duplicate check  [0m"
    echo ''
    echo "                   ${bcgPW}         PW         [0m"
    echo ''
    echo ''
    echo "                          ${bcgSignIn}  SIGN IN  [0m""     ${bcgExit}   EXIT   [0m "

    option_picked
}

option_picked(){
    read -n 1 input 
    if [ $input == '' ]
    then
	read -n 1 input 
	if [ $input == '[' ]
	then
	    read -n 1 input 
	    if [ $input == 'A' ]
	    then
		cursor=-2
	    elif [ $input == 'B' ]
	    then
		cursor=2
	    elif [ $input == 'C' ]
	    then
		cursor=1
	    elif [ $input == 'D' ]
	    then
		cursor=-1
	    fi
    	fi
    elif [ $input = `` ]; then
	case $nowCursor in
	    0) exit;
	    ;;
	    1) show_menu_SignIn
	    ;;
	    2) exit;
	    ;;
	    3) exit;
	    ;;
	esac
    fi
    calcCursor
}

calcCursor(){
    temp=`expr $cursor + $nowCursor`
    if [[ $bcgExit = $bcgJoin ]] && [[ $bcgJoin = $bcgSignIn ]] && [[ $bcgSignIn = $bcgSignOut ]]
    then
	nowCursor=0
    elif [[ $nowCursor = 0 ]] && [[ $cursor = -2  ]]
    then
	nowCursor=2
    elif [[ $nowCursor = 1 ]] && [[ $cursor = -2 ]]
    then
	nowCursor=3
    elif [[ $nowCursor = 0 ]] && [[ $cursor = -1 ]]
    then
	nowCursor=3
    else
	nowCursor=`expr $temp % 4`
    fi
    highlight
}

highlight(){
    if [ $nowCursor = 0 ]
    then
	bcgExit="[44m"
	bcgSignIn="[44m"
	bcgSignOut="[44m"
	bcgJoin="[41m"
    elif [ $nowCursor = 1 ]
    then
	bcgJoin="[44m"
	bcgSignOut="[44m"
	bcgExit="[44m"
	bcgSignIn="[41m"
    elif [ $nowCursor = 2 ]
    then
	bcgSignIn="[44m"
	bcgJoin="[44m"
	bcgSignOut="[44m"
	bcgExit="[41m"
    elif [ $nowCursor = 3 ]
    then
	bcgJoin="[44m"
	bcgSignIn="[44m"
	bcgExit="[44m"
	bcgSignOut="[41m"
    fi
    show_menu_main
}

clear
show_menu_main
