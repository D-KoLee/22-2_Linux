#!/bin/bash

bcgJoin="[44m"
bcgSignIn="[44m"
bcgExit="[44m"
bcgSignOut="[44m"
cursor=0
nowCursor=-1

show_menu(){
    clear
    echo "$temp $nowCursor $cursor"
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
#    elif [ $input == "" ]
#    then
    else
	case $nowCursor in
	    0) exit;
	    ;;
	    1) ./signIn.sh
	    ;;
	    2) exit;
	    ;;
	    3) exit;
	    ;;
	esac
    fi
#    read -n 3 input 
#    if [ $input == '[A' ]
#    then
#        cursor=-2
#    elif [ $input == '[B' ]
#    then
#        cursor=2
#    elif [ $input == '[C' ]
#    then
#        cursor=1
#    elif [ $input == '[D' ]
#    then
#        cursor=-1
#   fi
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
    show_menu
}

clear
show_menu

#while [ $opt != '' ]
#    do
#    if [ $opt = '' ]; then
#	exit;
#    else
#	case $opt in
#	    A) clear;
#		option_picked "Option 1 Picked";
#		printf "sudo mounted"
#		show_menu;
#	    ;;
#	    B) exit;
#	    ;;
#	    9) clear;
#		option_picked "Pick an option from the menu";
#		show_menu;
#	    ;;
#	esac
#    fi
#done
