#!/bin/bash
tput civis #hide cursor

bcgJoin="[44m"
bcgStart="[44m"
bcgSignIn="[44m"
bcgExit="[44m"
bcgSignOut="[44m"
bcgID="[44m"
bcgDupCheck="[44m"
bcgPW="[44m"
bcgLogin="[44m"
bcg1pLogin="[44m"
bcg2pLogin="[44m"
bcgMap1="[44m"
bcgMap2="[44m"
mapThumbnail="[103m  [0m"
cursor=0
nowCursor=-1
currentShow=0
cnt=0

file=`cat ./auth.txt`
data=`echo $file`
splitData=`echo $data | tr "," " "`
#splitData=`echo $splitData | tr " " '\r\n'`
SIZE=20
auth1p=0
auth2p=0
authSignIn=1
authDup=1
idDup=0
isID=0
isPW=0
isSignOut=0
ID1p=""
i=""
thatLine=""

usrDATA=""
usrWin=0
usrLose=0
usrID="ID"
usrPW="PW"
showID="         ${usrID}         "
showPW="         ${usrPW}         "
_showID="           ${usrID}           "
_showPW="           ${usrPW}           "
playerOne="1P LOGIN"
playerTwo="2P LOGIN"
_playerOne="   ${playerOne}   "
_playerTwo="   ${playerTwo}   "
win1p="0"
lose1p="0"
win2p="0"
lose2p="0"
lobbyIdBlank=" ${playerOne}                                  "
lobbyWinBlank=" ${win1p}                                        "
lobbyLoseBlank=" ${lose1p}                                       "

init_vars(){
    bcgJoin="[44m"
    bcgSignIn="[44m"
    bcgExit="[44m"
    bcgSignOut="[44m"
    bcgID="[44m"
    bcgDupCheck="[44m"
    bcgPW="[44m"
    bcgLogin="[44m"
    bcgStart="[44m"
    bcg1pLogin="[44m"
    bcg2pLogin="[44m"
    bcgMap1="[44m"
    bcgMap2="[44m"
    isID=0
    isPW=0
}

init_cursor(){
    cursor=0
    nowcursor=-1
}

show_menu_main(){
    currentShow=0
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
    echo '                                               201901268 RSJ'
    echo ''
    echo "		     ${bcg1pLogin}${_playerOne}[0m" "        ${bcgSignIn}    SIGN IN    [0m"
    echo""
    echo "		     ${bcg2pLogin}${_playerTwo}[0m" "        ${bcgSignOut}    SIGN OUT   [0m"
    echo ''
    echo ''
    echo "                         ${bcgJoin}    JOIN    [0m" "   ${bcgExit}    EXIT    [0m"

    option_picked_main
}

show_menu_signIn(){
    currentShow=1
    clear
    echo '                        ____ ___ ____ _   _   ___ _   _ '
    echo '                       / ___|_ _/ ___| \ | | |_ _| \ | |'
    echo '                       \___ \| | |  _|  \| |  | ||  \| |'
    echo '                        ___) | | |_| | |\  |  | || |\  |'
    echo '                       |____/___\____|_| \_| |___|_| \_|'
    echo ''
    echo ''
    echo ''
    echo "                   ${bcgID}${showID}[0m" "   ${bcgDupCheck}  Duplicate check  [0m"
    echo ''
    echo "                   ${bcgPW}${showPW}[0m"
    echo ''
    echo ''
    echo "                          ${bcgSignIn}  SIGN IN  [0m""     ${bcgExit}   EXIT   [0m "

    option_picked_signIn
}

show_menu_signOut(){
    currentShow=2
    clear
    echo '                    ____ ___ ____ _   _    ___  _   _ _____ '
    echo '                   / ___|_ _/ ___| \ | |  / _ \| | | |_   _|'
    echo '                   \___ \| | |  _|  \| | | | | | | | | | |  '
    echo '                    ___) | | |_| | |\  | | |_| | |_| | | |  '
    echo '                   |____/___\____|_| \_|  \___/ \___/  |_|'
    echo ''
    echo ''
    echo ''
    echo "                           ${bcgID}${_showID}[0m"
    echo ''
    echo "                           ${bcgPW}${_showPW}[0m"
    echo ''
    echo ''
    echo ''
    echo "                         ${bcgSignOut}  SIGN OUT  [0m""     ${bcgExit}   EXIT   [0m "

    option_picked_signOut
}

show_menu_1pLogin(){
    currentShow=3
    clear
    echo '                      _ ____    _     ___   ____ ___ _   _'
    echo '                     / |  _ \  | |   / _ \ / ___|_ _| \ | |'
    echo '                     | | |_) | | |  | | | | |  _ | ||  \| |'
    echo '                     | |  __/  | |__| |_| | |_| || || |\  |'
    echo '                     |_|_|     |_____\___/ \____|___|_| \_|'
    echo ''
    echo ''
    echo ''
    echo "                           ${bcgID}${_showID}[0m"
    echo ''
    echo "                           ${bcgPW}${_showPW}[0m"
    echo ''
    echo ''
    echo ''
    echo "                          ${bcgLogin}   LOGIN   [0m""     ${bcgExit}   EXIT   [0m "
    option_picked_login
}

show_menu_2pLogin(){
    currentShow=4
    clear
    echo '                    ____  ____    _     ___   ____ ___ _   _'
    echo '                   |___ \|  _ \  | |   / _ \ / ___|_ _| \ | |'
    echo '                     __) | |_) | | |  | | | | |  _ | ||  \| |'
    echo '                    / __/|  __/  | |__| |_| | |_| || || |\  |'
    echo '                   |_____|_|     |_____\___/ \____|___|_| \_|'
    echo ''
    echo ''
    echo ''
    echo "                           ${bcgID}${_showID}[0m"
    echo ''
    echo "                           ${bcgPW}${_showPW}[0m"
    echo ''
    echo ''
    echo ''
    echo "                          ${bcgLogin}   LOGIN   [0m""     ${bcgExit}   EXIT   [0m "
    option_picked_login
}

show_menu_success(){
    clear
    echo ''
    echo ''
    echo ''
    echo ''
    echo ''
    echo ''
    echo ''
    echo '                    ____  _   _  ____ ____ _____ ____ ____  '
    echo '                   / ___|| | | |/ ___/ ___| ____/ ___/ ___| '
    echo '                   \___ \| | | | |  | |   |  _| \___ \___ \ '
    echo '                    ___) | |_| | |__| |___| |___ ___) |__) |'
    echo '                   |____/ \___/ \____\____|_____|____/____/ '
    sleep 5
    clear
    exit
}

show_menu_lobby(){
    currentShow=5
    clear
    echo '                            _  _____  _    __  ____  __'
    echo '                           / \|_   _|/ \   \ \/ /\ \/ /'
    echo '                          / _ \ | | / _ \   \  /  \  / '
    echo '                         / ___ \| |/ ___ \  /  \  /  \ '
    echo '                        /_/   \_\_/_/   \_\/_/\_\/_/\_\'
    echo '                          _     ___  ____  ______   __'
    echo '                         | |   / _ \| __ )| __ ) \ / /'
    echo '                         | |  | | | |  _ \|  _ \\ V /'
    echo '                         | |__| |_| | |_) | |_) || |'
    echo '                         |_____\___/|____/|____/ |_|'
    echo ''
    echo ''
    echo '		 _ ____				       	    ____  ____'
    echo '		/ |  _ \				   |___ \|  _ \'
    echo '		| | |_) |				     __) | |_) |'
    echo '		| |  __/				    / __/|  __/'
    echo '		|_|_|					   |_____|_|'
    echo ""
    echo "          ID:${lobbyIdBlank}ID: ${playerTwo}"
    echo "          WIN:${lobbyWinBlank}WIN: ${win2p}"
    echo "          LOSE:${lobbyLoseBlank}LOSE: ${lose2p}"
    echo ""
    echo ""
    echo ""
    echo "                         ${bcgStart}    START    [0m""     ${bcgExit}   EXIT   [0m "
    option_picked_select
    exit
}

show_menu_mapSelect(){
    currentShow=6
    clear
    echo '                            _  _____  _    __  ____  __'
    echo '                           / \|_   _|/ \   \ \/ /\ \/ /'
    echo '                          / _ \ | | / _ \   \  /  \  / '
    echo '                         / ___ \| |/ ___ \  /  \  /  \ '
    echo '                        /_/   \_\_/_/   \_\/_/\_\/_/\_\'
    echo '           __  __    _    ____    ____  _____ _     _____ ____ _____ '
    echo '          |  \/  |  / \  |  _ \  / ___|| ____| |   | ____/ ___|_   _|'
    echo '          | |\/| | / _ \ | |_) | \___ \|  _| | |   |  _|| |     | |  '
    echo '          | |  | |/ ___ \|  __/   ___) | |___| |___| |__| |___  | |  '
    echo '          |_|  |_/_/   \_\_|     |____/|_____|_____|_____\____| |_|  '
    echo ""
    echo ""
    echo "	  ┌──┬──┬──┬──┬──┬──┬──┬──┐	    ┌──┬──┬──┬──┬──┬──┬──┬──┐"
    echo "	  │  │  │  │  │  │  │  │  │	    │  │  │  │  │  │  │  │  │"
    echo "	  ├──┼──┼──┼──┼──┼──┼──┼──┤	    ├──┼──┼──┼──┼──┼──┼──┼──┤"
    echo "	  │  │  │  │  │  │  │  │  │	    │  │${mapThumbnail}│  │  │  │  │${mapThumbnail}│  │"
    echo "	  ├──┼──┼──┼──┼──┼──┼──┼──┤	    ├──┼──┼──┼──┼──┼──┼──┼──┤"
    echo "	  │  │  │  │  │  │  │  │  │	    │  │  │${mapThumbnail}│  │  │${mapThumbnail}│  │  │"
    echo "	  ├──┼──┼──┼──┼──┼──┼──┼──┤	    ├──┼──┼──┼──┼──┼──┼──┼──┤"
    echo "	  │  │  │  │  │  │  │  │  │	    │  │  │  │${mapThumbnail}│${mapThumbnail}│  │  │  │"
    echo "	  ├──┼──┼──┼──┼──┼──┼──┼──┤	    ├──┼──┼──┼──┼──┼──┼──┼──┤"
    echo "	  │  │  │  │  │  │  │  │  │	    │  │  │  │${mapThumbnail}│${mapThumbnail}│  │  │  │"
    echo "	  ├──┼──┼──┼──┼──┼──┼──┼──┤	    ├──┼──┼──┼──┼──┼──┼──┼──┤"
    echo "	  │  │  │  │  │  │  │  │  │	    │  │  │${mapThumbnail}│  │  │${mapThumbnail}│  │  │"
    echo "	  ├──┼──┼──┼──┼──┼──┼──┼──┤	    ├──┼──┼──┼──┼──┼──┼──┼──┤"
    echo "	  │  │  │  │  │  │  │  │  │	    │  │${mapThumbnail}│  │  │  │  │${mapThumbnail}│  │"
    echo "	  ├──┼──┼──┼──┼──┼──┼──┼──┤	    ├──┼──┼──┼──┼──┼──┼──┼──┤"
    echo "	  │  │  │  │  │  │  │  │  │	    │  │  │  │  │  │  │  │  │"
    echo "	  └──┴──┴──┴──┴──┴──┴──┴──┘	    └──┴──┴──┴──┴──┴──┴──┴──┘"
    echo ''
    echo "                 ${bcgMap1}   MAP 1   [0m""                       ${bcgMap2}   MAP 2   [0m "
    option_picked_select
}

show_map1(){
    clear
}

show_map2(){
    clear
}

option_picked_main(){
    read -n 1 input 
    if [[ $input == '' ]]
    then
	read -n 1 input 
	if [[ $input == '[' ]]
	then
	    read -n 1 input 
	    if [[ $input == 'A' ]]
	    then
		cursor=0
	    elif [[ $input == 'B' ]]
	    then
		cursor=1
	    elif [[ $input == 'C' ]]
	    then

		cursor=2
	    elif [[ $input == 'D' ]]
	    then
		cursor=3
	    fi
    	fi
    elif [[ $input = `` ]]; then
	case $nowCursor in
	    0) init_vars; init_cursor; show_menu_1pLogin;
	    ;;
	    1) init_vars; init_cursor; show_menu_signIn;
	    ;;
	    2) init_vars; init_cursor; show_menu_2pLogin;
	    ;;
	    3) init_vars; init_cursor; show_menu_signOut;
	    ;;
	    4) init_vars; init_cursor; authCheck; eraseBlankLobby; show_menu_lobby;
	    ;;
	    5) clear; exit
	esac
    fi
    calcCursor_main
}

option_picked_signIn(){
read -n 1 input 
    if [[ $input == '' ]]
    then
	read -n 1 input 
	if [[ $input == '[' ]]
	then
	    read -n 1 input 
	    if [[ $input == 'A' ]]
	    then
		cursor=0
	    elif [[ $input == 'B' ]]
	    then
		cursor=1
	    elif [[ $input == 'C' ]]
	    then
		cursor=2
	    elif [[ $input == 'D' ]]
	    then
		cursor=3
	    fi
    	fi
    elif [[ $input = `` ]]; then
	case $nowCursor in
	    0) cnt=0; enterString; cursor=8
	    ;;
	    1) init_vars; init_cursor; dupCheck; updateDatas; exit
		    #check the dups and print result and exit
	    ;;
	    2) cnt=1; enterString; cursor=9
	    ;;
	    3) init_vars; signInDup; updateDatas; clear; exit
	    ;;
	    4) clear; exit  #dup check and write Info. And exit
	    ;;
	esac
    fi
    calcCursor_signIn
}

option_picked_signOut(){
    read -n 1 input 
    if [[ $input == '' ]]
    then
	read -n 1 input 
	if [[ $input == '[' ]]
	then
	    read -n 1 input 
	    if [[ $input == 'A' ]]
	    then
		cursor=0
	    elif [[ $input == 'B' ]]
	    then
		cursor=1
	    elif [[ $input == 'C' ]]
	    then
		cursor=2
	    elif [[ $input == 'D' ]]
	    then
		cursor=3
	    fi
    	fi
    elif [[ $input = `` ]]; then
	case $nowCursor in
	    0) cnt=0; enterString; cursor=8
	    ;;
	    1) cnt=1; enterString; cursor=9
	    ;;
	    2) isSignOut=1; checkIDFirst;
	    ;;
	    3) clear; exit
	    ;;
	esac
    fi
    calcCursor_signOut
}

option_picked_login(){
    read -n 1 input 
    if [[ $input == '' ]]
    then
	read -n 1 input 
	if [[ $input == '[' ]]
	then
	    read -n 1 input 
	    if [[ $input == 'A' ]]
	    then
		cursor=0
	    elif [[ $input == 'B' ]]
	    then
		cursor=1
	    elif [[ $input == 'C' ]]
	    then
		cursor=2
	    elif [[ $input == 'D' ]]
	    then
		cursor=3
	    fi
    	fi
    elif [[ $input = `` ]]; then
	case $nowCursor in
	    0) cnt=0; enterString; cursor=9
	    ;;
	    1) cnt=1; enterString; cursor=9
	    ;;
	    2) checkIDFirst
	    if [[ $currentShow = 4 ]] && [[ $auth2p = 1 ]]; then
		updateDatas
		init_vars
		init_cursor
		echo "success"
		sleep 1
		show_menu_main
	    elif [[ $currentShow = 3 ]] && [[ $auth1p = 1 ]]; then
		updateDatas
		init_vars
		init_cursor
		echo "success"
		sleep 1
		show_menu_main
	    fi
	    ;;
	    3) clear; exit
	    ;;
	esac
    fi
    calcCursor_login
}

option_picked_select(){
    read -n 1 input 
    if [[ $input == '' ]]
    then
	read -n 1 input 
	if [[ $input == '[' ]]
	then
	    read -n 1 input 
	    if [[ $input == 'A' ]]
	    then
		cursor=0
	    elif [[ $input == 'B' ]]
	    then
		cursor=1
	    elif [[ $input == 'C' ]]
	    then
		cursor=2
	    elif [[ $input == 'D' ]]
	    then
		cursor=3
	    fi
    	fi
    elif [[ $input = `` ]]; then
	case $nowCursor in
	    0) init_vars; init_cursor; 
	    if [[ $currentShow = 5 ]]; then
		show_menu_mapSelect
	    elif [[ $currentShow = 6 ]]; then
		show_map1
	    fi
	    ;;
	    1) init_vars; init_cursor;
	    if [[ $currentShow = 6 ]]; then
		show_map2
	    else
		clear; exit; fi
	esac
    fi
    calcCursor_select
}

calcCursor_main(){
    if [[ $bcgExit = $bcgJoin ]] && [[ $bcgJoin = $bcgSignIn ]] && [[ $bcgSignIn = $bcgSignOut ]] && [[ $bcg1pLogin = $bcg2pLogin ]] && [[ $bcg1pLogin = $bcgSignIn ]] && [[ $bcg2pLogin = $bcgSignOut ]];
    then
	nowCursor=0
    elif [[ $cursor = 8 ]]; then
	nowCursor=0
	highlight
    elif [[ $cursor = 9 ]]; then
	nowCursor=1
	highlight
    elif [[ $cursor = 0 ]]; then
	nowCursor=`expr $nowCursor - 2`
	if [[ $nowCursor = -2 ]]; then
	    nowCursor=4
	elif [[ $nowCursor = -1 ]]; then
	    nowCursor=5
	fi
    elif [[ $cursor = 1 ]]; then
	nowCursor=`expr $nowCursor + 2`
	if [[ $nowCursor = 6 ]]; then
	    nowCursor=0
	elif [[ $nowCursor = 7 ]]; then
	    nowCursor=1
	fi
    elif [[ $cursor = 2 ]]; then
	nowCursor=`expr $nowCursor + 1`
	if [[ $nowCursor = 6 ]]; then
	    nowCursor=0
	fi
    elif [[ $cursor = 3 ]]; then
	nowCursor=`expr $nowCursor - 1`
	if [[ $nowCursor = -1 ]]; then
	    nowCursor=5
	fi
    fi
    highlight
}

calcCursor_signOut(){
    if [[ $bcgExit = $bcgID ]] && [[ $bcgID = $bcgPW ]] && [[ $bcgPW = $bcgSignOut ]]
    then #first highlighting
	nowCursor=0
    elif [[ $cursor = 8 ]]; then
	nowCursor=0
	highlight
    elif [[ $cursor = 9 ]]; then
	nowCursor=1
	highlight
    elif [[ $nowCursor = 0 ]]; then #from ID to somewhere
	if [[ $cursor = 0  ]]; then
	    nowCursor=3
	elif [[ $cursor = 1 ]]; then
	    nowCursor=1
	else
	    nowCursor=0
	fi
    elif [[ $nowCursor = 1 ]]; then #from PW to somewhere
	if [[ $cursor = 0  ]]; then
	    nowCursor=0
	elif [[ $cursor = 1 ]]; then
	    nowCursor=2
	else
	    nowCursor=1
	fi
    elif [[ $nowCursor = 2 ]]; then #from LOGIN to somewhere
	if [[ $cursor = 0  ]]; then
	    nowCursor=1
	elif [[ $cursor = 1 ]]; then
	    nowCursor=0
	else
	    nowCursor=3
	fi
    elif [[ $nowCursor = 3 ]]; then #from EXIT to somewhere
	if [[ $cursor = 0  ]]; then
	    nowCursor=1
	elif [[ $cursor = 1 ]]; then
	    nowCursor=0
	else
	    nowCursor=2
	fi
    fi
    highlight
}

calcCursor_signIn(){
    if [[ $bcgExit = $bcgID ]] && [[ $bcgID = $bcgPW ]] && [[ $bcgPW = $bcgSignIn ]] && [[ $bcgSignIn = $bcgDupCheck ]]
    then
	nowCursor=0
    elif [[ $cursor = 8 ]]; then
	nowCursor=0
	highlight
    elif [[ $cursor = 9 ]]; then
	nowCursor=2
	highlight
    elif [[ $nowCursor = 0 ]]
    then #from ID to somewhere
	if [[ $cursor = 0  ]]; then
	    nowCursor=3
	elif [[ $cursor = 1 ]]; then
	    nowCursor=2
	else
	    nowCursor=1
	fi;
    elif [[ $nowCursor = 1 ]]; then #from DupCheck to somewhere
	if [[ $cursor = 0  ]] || [[ $cursor = 1 ]]; then
	    nowCursor=4
	else
	    nowCursor=0
	fi
    elif [[ $nowCursor = 2 ]]; then #from PW to somewhere
	if [[ $cursor = 0  ]]; then
	    nowCursor=0
	elif [[ $cursor = 1 ]]; then
	    nowCursor=3
	elif [[ $cursor = 2 ]]; then
	    nowCursor=4
	elif [[ $cursor = 3 ]]; then
	    nowCursor=1
	fi
    elif [[ $nowCursor = 3 ]]; then #from SignIn to somewhere
	if [[ $cursor = 0  ]]; then
	    nowCursor=2
	elif [[ $cursor = 1 ]]; then
	    nowCursor=0
	else
	    nowCursor=4
	fi;
    elif [[ $nowCursor = 4 ]]; then #from Exit to somewhere
	if [[ $cursor = 0  ]] || [[ $cursor = 1 ]]; then
	    nowCursor=1
	else
	    nowCursor=3
	fi
    fi
    highlight
}

calcCursor_login(){
    if [[ $bcgExit = $bcgID ]] && [[ $bcgID = $bcgPW ]] && [[ $bcgPW = $bcgLogin ]]
    then #first highlighting
	nowCursor=0
    elif [[ $cursor = 9 ]]; then
	highlight
    elif [[ $nowCursor = 0 ]]; then #from ID to somewhere
	if [[ $cursor = 0  ]]; then
	    nowCursor=3
	elif [[ $cursor = 1 ]]; then
	    nowCursor=1
	else
	    nowCursor=0
	fi
    elif [[ $nowCursor = 1 ]]; then #from PW to somewhere
	if [[ $cursor = 0  ]]; then
	    nowCursor=0
	elif [[ $cursor = 1 ]]; then
	    nowCursor=2
	else
	    nowCursor=1
	fi
    elif [[ $nowCursor = 2 ]]; then #from LOGIN to somewhere
	if [[ $cursor = 0  ]]; then
	    nowCursor=1
	elif [[ $cursor = 1 ]]; then
	    nowCursor=0
	else
	    nowCursor=3
	fi
    elif [[ $nowCursor = 3 ]]; then #from EXIT to somewhere
	if [[ $cursor = 0  ]]; then
	    nowCursor=1
	elif [[ $cursor = 1 ]]; then
	    nowCursor=0
	else
	    nowCursor=2
	fi
    fi
    highlight
}

calcCursor_select(){
    if [[ $bcgMap1 = $bcgMap2 ]] && [[ $currentShow = 6 ]] || [[ $bcgStart = $bcgExit ]] && [[ $currentShow = 5 ]]; then
	nowCursor=0
    elif [[ $cursor = 2 ]]; then
	nowCursor=`expr $nowCursor + 1`
	if [[ $nowCursor > 1 ]]; then
	    nowCursor=0
	fi
    elif [[ $cursor = 3 ]]; then
	nowCursor=`expr $nowCursor - 1`
	if [[ $nowCursor < 0 ]]; then
	    nowCursor=1
	fi
    fi
    highlight
}

highlight(){
    init_vars
    if [[ $nowCursor = 0 ]] #1st button
    then
	if [[ $currentShow = 0 ]]; then
	    bcg1pLogin="[41m"
	elif [[ $currentShow = 5 ]]; then
	    bcgStart="[41m"
	elif [[ $currentShow = 6 ]]; then
	    bcgMap1="[41m"
	else
	    bcgID="[41m"; fi
   
    elif [[ $nowCursor = 1 ]]; then #2nd button
	if [[ $currentShow = 0 ]]; then
	    bcgSignIn="[41m"
	elif [[ $currentShow = 1 ]]; then
	    bcgDupCheck="[41m"
	elif [[ $currentShow = 5 ]]; then
	    bcgExit="[41m"
	elif [[ $currentShow = 6 ]]; then
	    bcgMap2="[41m"
	else
	    bcgPW="[41m"; fi

    elif [[ $nowCursor = 2 ]]; then #3rd button
	if [[ $currentShow = 0 ]]; then
	    bcg2pLogin="[41m"
	elif [[ $currentShow = 1 ]]; then
	    bcgPW="[41m"
	elif [[ $currentShow = 3 ]] || [[ $currentShow = 4 ]]; then
	    bcgLogin="[41m"
	else
	    bcgSignOut="[41m"; fi

    elif [[ $nowCursor = 3 ]]; then #4th button
	if [[ $currentShow = 0 ]]; then
	    bcgSignOut="[41m"
	elif [[ $currentShow = 1 ]]; then
	    bcgSignIn="[41m"
	else
	    bcgExit="[41m"; fi

    elif [[ $nowCursor = 4 ]]; then #5th button
	if [[ $currentShow = 0 ]]; then
	    bcgJoin="[41m"
	else
	    bcgExit="[41m"; fi
    elif [[ $nowCursor = 5 ]]; then
	bcgExit="[41m"
    fi
    case $currentShow in
        0) show_menu_main
	;;
	1) show_menu_signIn
	;;
	2) show_menu_signOut
	;;
	3) show_menu_1pLogin
	;;
	4) show_menu_2pLogin
	;;
	5) show_menu_lobby
	;;
	6) show_menu_mapSelect
    esac
}

dupCheck(){ 
    #For readability, I wrote a function that does the same thing multiple times.
    for i in $splitData
    do
	checkIdHere="\""$usrID
	if [[ $i = $checkIdHere ]]; then
	    echo "Same ID is already exist"
	    sleep 3
	    clear
	    exit
	fi
    done
    echo "You can register"
    sleep 3
    clear
    exit
}

signInDup(){
    for i in $splitData
    do
	checkIdHere="\""$usrID
	if [[ $i = $checkIdHere ]]; then
	    authSignIn=0
	    echo "This ID is already exist!"
	    sleep 3
	    break
	fi
    done
    if [[ $authSignIn = 1 ]]; then
	if [[ $usrID != "ID" ]] && [[ $usrPW != "PW" ]]; then
	    echo $usrDATA >> ./auth.txt
	    echo "SignIn Success"
	    sleep 3
	elif [[ $usrID = "ID" ]] || [[ $usrPW = "PW" ]]; then
	    echo "Please enter whole BLANKS"
	    sleep 2
	    show_menu_signIn
	fi
    fi	
}

checkIDFirst(){ 
    isID=0
    isPW=0
    #For readability, I wrote a function that does the same thing multiple times.
    for i in $splitData
    do
	checkIdHere="\""$usrID
	if [[ $i = $checkIdHere ]]; then
	    if [[ $currentShow = 4 ]]; then
		loginIdDupCheck
		if [[ $ID1p = $usrID ]] || [[ $idDup = 1 ]]; then
		    echo "This ID is already logged in"
		    sleep 3
		    clear
		    exit
		fi
	    fi
	    thatLine=$checkIdHere", " 
	    isID=1
	    ID1p=$usrID
	    if [[ $currentShow = 3 ]]; then
		playerOne=$usrID
	    elif [[ $currentShow = 4 ]]; then
		playerTwo=$usrID
	    fi
	    checkPWLast
	    loginIdDupCheck
	    if [[ $idDup = 1 ]]; then
		echo "This ID is already logged in"
		sleep 3
		exit
	    fi
	fi
    done
    if [[ $isID = 0 ]]; then
	if [[ $isSignOut = 1 ]]; then
	    echo "Unauthorized User"
	else	
	    echo "Login Failed. ID isn't match."
	fi
	sleep 3
	clear
	exit
    fi
}

checkPWLast(){ 
    #For readability, I wrote a function that does the same thing multiple times.
    for i in $splitData
    do
	checkIdHere=$usrPW
	if [[ $i = $checkIdHere ]]; then
	    thatLine=$thatLine$checkIdHere
	    isPW=1
	    if [[ $currentShow = 3 ]]; then
		auth1p=1
	    elif [[ $currentShow = 4 ]]; then
		auth2p=1
#show_menu_success
	    elif [[ $isSignOut = 1 ]]; then
		sed -i "/${thatLine}/d" ./auth.txt
		echo "User has been deleted"
		sleep 3
		clear
		exit
	    fi
	    eraseBlankPlayerId
	    break
	fi
    done
    if [[ $isPW = 0 ]]; then
	if [[ $isSignOut = 1 ]]; then
	    echo "Unauthorized User"
	else	
	    echo "Login Failed. Password isn't match."
	fi
	sleep 3
	clear
	exit
    fi
}

enterString(){
    read inputData
    echo $cnt
    if [[ $cnt = 0 ]]; then
	usrID=$inputData
    elif [[ $cnt = 1 ]]; then
	usrPW=$inputData
    fi
    usrDATA="\"$usrID, $usrPW, $usrWin, $usrLose\""
    eraseBlank
}

updateDatas(){
    usrID="ID"
    usrPW="PW"
#data=`echo $file`
#splitData=`echo $data | tr "," " "`
#splitData=`echo $splitData | tr " " '\r\n'`
    cnt=0
    eraseBlank
    cnt=1
    eraseBlank
}

authCheck(){
    if [[ $auth1p = 1 ]] && [[ $auth2p = 1 ]]; then
	return
    else
	echo "Not all logged in!"
	sleep 3
	clear
	exit
    fi
}

eraseBlank(){
    len=24
    if [[ $currentShow = 1 ]]; then
	len=20
    fi
    if [[ $cnt = 0 ]]; then
	if [[ $currentShow = 1 ]]; then
	    showID=""
	    charTime=${#usrID}
	    blankTime=`expr $len - $charTime`
	    front=`expr $blankTime / 2 + $blankTime % 2`
	    back=`expr $blankTime / 2`
	    while [[ $front > 0 ]]
	    do
		showID=$showID" "
		front=`expr $front - 1`
	    done
	    showID=$showID$usrID
	    while [[ $back > 0 ]]
	    do
		showID=$showID" "
		back=`expr $back - 1`
	    done
	else
	    _showID=""
	    charTime=${#usrID}
	    blankTime=`expr $len - $charTime`
	    front=`expr $blankTime / 2 + $blankTime % 2`
	    back=`expr $blankTime / 2`
	    while [[ $front > 0 ]]
	    do
		_showID=$_showID" "
		front=`expr $front - 1`
	    done
	    _showID=$_showID$usrID
	    while [[ $back > 0 ]]
	    do
		_showID=$_showID" "
		back=`expr $back - 1`
	    done
	fi
    elif [[ $cnt = 1 ]]; then
	if [[ $currentShow = 1 ]]; then
	showPW=""
	charTime=${#usrPW}
	blankTime=`expr $len - $charTime`
	front=`expr $blankTime / 2 + $blankTime % 2`
	back=`expr $blankTime / 2`
	while [[ $front > 0 ]]
	do
	    showPW=$showPW" "
	    front=`expr $front - 1`
	done
	showPW=$showPW$usrPW
	while [[ $back > 0 ]]
	do
	    showPW=$showPW" "
	    back=`expr $back - 1`
	done
	else
	    _showPW=""
	    charTime=${#usrPW}
	    blankTime=`expr $len - $charTime`
	    front=`expr $blankTime / 2 + $blankTime % 2`
	    back=`expr $blankTime / 2`
	    while [[ $front > 0 ]]
	    do
		 _showPW=$_showPW" "
		front=`expr $front - 1`
	    done
	    _showPW=$_showPW$usrPW
	    while [[ $back > 0 ]]
	    do
		_showPW=$_showPW" "
		back=`expr $back - 1`
	    done
	fi
    fi   
}

eraseBlankPlayerId(){
    len=14
    if [[ $currentShow = 3 ]]; then
        _playerOne=""
        charTime=${#playerOne}
        blankTime=`expr $len - $charTime`
        front=`expr $blankTime / 2 + $blankTime % 2`
        back=`expr $blankTime / 2`
        while [[ $front > 0 ]]
        do
	    _playerOne=$_playerOne" "
	    front=`expr $front - 1`
	done
	_playerOne=$_playerOne$playerOne
	while [[ $back > 0 ]]
	do
	    _playerOne=$_playerOne" "
	    back=`expr $back - 1`
	done
    elif [[ $currentShow = 4 ]]; then
        _playerTwo=""
        charTime=${#playerTwo}
        blankTime=`expr $len - $charTime`
        front=`expr $blankTime / 2 + $blankTime % 2`
        back=`expr $blankTime / 2`
        while [[ $front > 0 ]]
        do
	    _playerTwo=$_playerTwo" "
	    front=`expr $front - 1`
	done
	_playerTwo=$_playerTwo$playerTwo
	while [[ $back > 0 ]]
	do
	    _playerTwo=$_playerTwo" "
	    back=`expr $back - 1`
	done
    fi
}

loginIdDupCheck(){
    if [[ $playerOne = $playerTwo ]] || [[ $inputData = $playerOne ]] || [[ $inputData = $playerTwo ]]; then
	idDup=1
    fi
}

eraseBlankLobby(){
    lobbyIdBlank=" ${playerOne}"
    lobbyWinBlank=" ${win1p}"
    lobbyLoseBlank=" ${lose1p}"

    len=`expr 41 - ${#playerOne}` #ID
    while [[ $len > 0 ]]
    do
	lobbyIdBlank=$lobbyIdBlank" "
	len=`expr $len - 1`
    done
    len=`expr 40 - ${#win1p}` #Win
    while [[ $len > 0 ]]
    do
	lobbyWinBlank=$lobbyWinBlank" "
	len=`expr $len - 1`
    done
    len=`expr 39 - ${#lose1p}` #Lose
    while [[ $len > 0 ]]
    do
	lobbyLoseBlank=$lobbyLoseBlank" "
	len=`expr $len - 1`
    done
}

clear
show_menu_main
