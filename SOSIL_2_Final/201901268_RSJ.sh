#!/bin/bash
tput civis #hide cursor

#To control background colour easyway: RED to BLUE, BLUE to RED
bcgJoin="[44m"	#background colour of Join button
bcgStart="[44m"	#background colour of Start button
bcgSignIn="[44m"	#background colour of Sign In button
bcgExit="[44m"	#background colour of Exit button
bcgSignOut="[44m"	#background colour of Sign Out button
bcgID="[44m"		#background colour of ID button
bcgDupCheck="[44m"	#background colour of Duplicate Check button
bcgPW="[44m"		#background colour of PW button
bcgLogin="[44m"	#background colour of Login button
bcg1pLogin="[44m"	#background colour of 1P Login button
bcg2pLogin="[44m"	#background colour of 2P Login button
bcgMap1="[44m"	#background colour of Map 1 button
bcgMap2="[44m"	#background colour of Map 2 button
mapThumbnail="[103m  [0m"	#background colour of Second Map Yellow Thumbnail
yellow="[103m   [0m"	#In game, Yellow square
white="[47m   [0m"		#In game, player's cursor
blue="[44m   [0m"		#In game, blue square
blank="[0m   [0m"		#In game, blank space
m=("   " "   " "   " "   " "   " "   " "   " "   " "   "	#Array that stores and expresses
        "   " "   " "   " "   " "   " "   " "   " "   " "   "	#the colour information of a map
        "   " "   " "   " "   " "   " "   " "   " "   " "   "
        "   " "   " "   " "   " "   " "   " "   " "   " "   "
        "   " "   " "   " "   " "   " "   " "   " "   " "   "
        "   " "   " "   " "   " "   " "   " "   " "   " "   "
        "   " "   " "   " "   " "   " "   " "   " "   " "   "
        "   " "   " "   " "   " "   " "   " "   " "   " "   ")

nextLocation=0	#In game, the colour information of a map
isMoved=0	#check if the cursor has moved
isSecondMap=0	#check if the second map has chosen
isYellow=0	#When moving: whether the next position is yellow, when coloring: whether this is yellow
isBlue=0	#When moving: whether the next position is blue, when coloring: whether this is blue
pressOnlyOne=0	#prevents the count from increasing when the enter is pressed immediately after colouring

cursor=0	#Send which direction key was pressed
nowCursor=-1	#to store which button is currently highlighted
currentShow=0	#to store which screen is currently being displayed
cnt=0		#Distinguish between ID and PW in which field

file=`cat ./auth.txt`	#Save the path where the account information is located
data=`echo $file`	#Retrieve and save account information
splitData=`echo $data | tr "," " "` #Reorganize the imported account information according to the format
len=24		    #Saves the maximum input length of ID and PW
auth1p=0	    #Determine whether 1p is logged in
auth2p=0	    #Determine whether 2p is logged in
authSignIn=1	    #Determine whether SignIn is possible
idDup=0		    #Determining whether IDs of 1p and 2p are duplicated
isID=0		    #To determine if Id was found, to receive the next string as a password
isPW=0		    #To determine if Pw was found
isSignOut=0	    #Determine if you are currently Sign Out
isIdFind=0	    #	These are all
isPwFind=0	    #	variables to
isWinFind=0	    #	receive multipliers
isLoseFind=0	    #	and losses
currentLocation=-1  #Save current position in game (0~63)
ID1p=""		    #Temporarily store 1p ID, variable used in 'P1'
i=""		    #index access modifier
thatLine=""	    #store ID and PW in a format to delete rows of account information

usrDATA=""	    #collects and stores account information
usrWin=0	    #store user's wins
usrLose=0	    #store user's losses
usrID="ID"	    #show "ID" first and save user id
usrPW="PW"	    #show "PW" first and save user pw
showID="         ${usrID}         "	    #	to show
showPW="         ${usrPW}         "	    #	button
_showID="           ${usrID}           "    #	with
_showPW="           ${usrPW}           "    #	user data.
playerOne="1P LOGIN"			    #	And
playerTwo="2P LOGIN"			    #	these
_playerOne="   ${playerOne}   "		    #	are
_playerTwo="   ${playerTwo}   "		    #	same too.
win1p="0"	#   Load user's
lose1p="0"	#   wins and losses
win2p="0"	#   and
lose2p="0"	#   save
lobbyIdBlank=" ${playerOne}                                  "	    #At the lobby
lobbyWinBlank=" ${win1p}                                        "   #to show
lobbyLoseBlank=" ${lose1p}                                       "  #1p and 2p data
cnt1p=0		#1p's fill blank count
cnt2p=0		#2p's fill blank count
_cnt1p=${cnt1p}"                      "	#to show at equal intervals

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
    echo "               ID:${lobbyIdBlank}ID: ${playerTwo}"
    echo "               WIN:${lobbyWinBlank}WIN: ${win2p}"
    echo "               LOSE:${lobbyLoseBlank}LOSE: ${lose2p}"
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

show_map(){
    clear
    echo '                            _  _____  _    __  ____  __'
    echo '                           / \|_   _|/ \   \ \/ /\ \/ /'
    echo '                          / _ \ | | / _ \   \  /  \  / '
    echo '                         / ___ \| |/ ___ \  /  \  /  \ '
    echo '                        /_/   \_\_/_/   \_\/_/\_\/_/\_\'
    echo ''
    echo "                       ┌───┬───┬───┬───┬───┬───┬───┬───┐"
    echo "                       │${m[0]}│${m[1]}│${m[2]}│${m[3]}│${m[4]}│${m[5]}│${m[6]}│${m[7]}│"
    echo "                       ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo "                       │${m[8]}│${m[9]}│${m[10]}│${m[11]}│${m[12]}│${m[13]}│${m[14]}│${m[15]}│"
    echo "                       ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo "                       │${m[16]}│${m[17]}│${m[18]}│${m[19]}│${m[20]}│${m[21]}│${m[22]}│${m[23]}│"
    echo "                       ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo "                       │${m[24]}│${m[25]}│${m[26]}│${m[27]}│${m[28]}│${m[29]}│${m[30]}│${m[31]}│"
    echo "                       ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo "                       │${m[32]}│${m[33]}│${m[34]}│${m[35]}│${m[36]}│${m[37]}│${m[38]}│${m[39]}│"
    echo "                       ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo "                       │${m[40]}│${m[41]}│${m[42]}│${m[43]}│${m[44]}│${m[45]}│${m[46]}│${m[47]}│"
    echo "                       ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo "                       │${m[48]}│${m[49]}│${m[50]}│${m[51]}│${m[52]}│${m[53]}│${m[54]}│${m[55]}│"
    echo "                       ├───┼───┼───┼───┼───┼───┼───┼───┤"
    echo "                       │${m[56]}│${m[57]}│${m[58]}│${m[59]}│${m[60]}│${m[61]}│${m[62]}│${m[63]}│"
    echo "                       └───┴───┴───┴───┴───┴───┴───┴───┘"
    echo ''
    echo ''
    echo "                       1P: ${_cnt1p}2P: ${cnt2p}"
    mapMove
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
		show_map
	    fi
	    ;;
	    1) init_vars; init_cursor;
	    if [[ $currentShow = 6 ]]; then
		makeYellow
		show_map
	    else
		clear; exit;
	    fi
	    ;;
	    2) init_vars; init_cursor;
	    ;;
	    3) init_vars; init_cursor;
	    ;;
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
    if [[ $bcgStart = $bcgExit ]] && [[ $currentShow = 5 ]]; then
	nowCursor=0
    elif [[ $bcgMap1 = $bcgMap2 ]] && [[ $currentShow = 6 ]]; then
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
    isDup=0
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
    isIdFind=0; isDup=0; cnt=0; checked=0;
    for i in $splitData
    do
	checkIdHere="\""$usrID
	checkPwHere=$usrPW
	if [[ $i = $checkIdHere ]] && [[ $isIdFind = 0 ]]; then
	    isIdFind=1
	    checked=$cnt
	elif [[ $i = $checkPwHere ]] && [[ $isIdFind = 1 ]]; then
	    if [[ `expr $cnt - $checked` != 1 ]]; then
		break
	    fi
	    thatLine=$thatLine$checkPwHere
	    isPW=1
	    findWinLose
	    if [[ $currentShow = 3 ]]; then
		auth1p=1
	    elif [[ $currentShow = 4 ]]; then
		auth2p=1
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
	cnt=`expr $cnt + 1`
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

findWinLose(){
    isIdFind=0; isPwFind=0; isWinFind=0; isLoseFind=0;
    for i in $splitData
    do
	checkIdHere="\""$usrID
	checkPwHere=$usrPW
	if [[ $i = $checkIdHere ]] && [[ $isIdFind = 0 ]]; then
	    isIdFind=1
	elif [[ $i = $checkPwHere ]] && [[ $isIdFind = 1 ]] && [[ $isPwFind = 0 ]]; then
	    isPwFind=1
	elif [[ $isIdFind = 1 ]] && [[ $isPwFind = 1 ]]; then
	    if [[ $isWinFind = 1 ]]; then
		if [[ $currentShow = 3 ]]; then
		    lose1p=$i
		    lose1p=${lose1p%\"}
		    break
		elif [[ $currentShow = 4 ]]; then
		    lose2p=$i
		    lose2p=${lose2p%\"}
		    break
		fi
	    elif [[ $isWinFind = 0 ]]; then
		if [[ $currentShow = 3 ]]; then
		    win1p=$i
		elif [[ $currentShow = 4 ]]; then
		    win2p=$i
		fi
		isWinFind=1
	    fi	
	fi
    done
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
    if [[ $playerOne = $playerTwo ]]; then
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

mapMove(){
    isMoved=0
    read -n 1 input 
    if [[ $input == '' ]]
    then
	read -n 1 input 
	if [[ $input == '[' ]]
	then
	    read -n 1 input 
	    if [[ $currentLocation = -1 ]]; then
		currentLocation=63
		nextLocation=63
		isMoved=1
	    elif [[ $input == 'A' ]]
	    then
		if [[ `expr $currentLocation - 7` > 0 ]]; then
		    nextLocation=`expr $currentLocation - 8`
		    isMoved=1
		fi
	    elif [[ $input == 'B' ]]
	    then
		if [[ `expr $currentLocation + 8` < 64 ]] || [[ $currentLocation = 0 ]] || [[ $currentLocation = 1 ]]; then
		    nextLocation=`expr $currentLocation + 8`
		    isMoved=1
		fi
	    elif [[ $input == 'C' ]]
	    then
		if [[ `expr $currentLocation % 8` != 7 ]]; then
		    nextLocation=`expr $currentLocation + 1`
		    isMoved=1
		fi
	    elif [[ $input == 'D' ]]
	    then
		if [[ `expr $currentLocation % 8` != 0 ]]; then
		    nextLocation=`expr $currentLocation - 1`
		    isMoved=1
		fi
	    fi
	    checkTile
    	fi
    elif [[ $input = `` ]]; then
	fillBlank
    fi
    show_map
}

checkTile(){
    if [[ $isMoved = 1 ]]; then
	pressOnlyOne=0
	if [[ $isYellow = 1 ]]; then
	    m[$currentLocation]=$yellow
	    isYellow=0
	elif [[ $isBlue = 1 ]]; then
	    m[$currentLocation]=$blue
	    isBlue=0
	fi
	if [[ ${m[$nextLocation]} = $yellow ]]; then
	    isYellow=1
	elif [[ ${m[$nextLocation]} = $blue ]]; then
	    isBlue=1
	fi
	currentLocation=$nextLocation
	makeWhite	
    fi
}
mapMoveCnt(){
    cnt1p=`expr $cnt1p + 1`
    if [[ ${#cnt1p} > 1 ]]; then
	_cnt1p=${cnt1p}"                     "
    else	
	_cnt1p=${cnt1p}"                      "
    fi
}

makeWhite(){
    for i in {0..63}
    do
	if [[ ${m[$i]} != $yellow ]] && [[ ${m[$i]} != $blue ]]; then
	    m[$i]=$blank
	fi
    done
    m[$currentLocation]=$white
}

fillBlank(){
    if [[ $isBlue != 1 ]] && [[ $isYellow != 1 ]]; then
	m[$currentLocation]=$blue
	if [[ $pressOnlyOne = 0 ]]; then
	    mapMoveCnt
	    pressOnlyOne=1
	fi
    fi
}

makeYellow(){
    m[9]=$yellow
    m[14]=$yellow
    m[18]=$yellow
    m[21]=$yellow
    m[27]=$yellow
    m[28]=$yellow
    m[35]=$yellow
    m[36]=$yellow
    m[42]=$yellow
    m[45]=$yellow
    m[49]=$yellow
    m[54]=$yellow
    isSecondMap=1
}

clear
show_menu_main
