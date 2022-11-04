#!/bin/bash

nameAndScore=""
array=($nameAndScore)
score=""

outputInfo(){
    echo "*** 학생 ${array[0]}은(는) ${array[1]}점을 맞아 ${score}학점을 취득하였습니다."
    
}

calcScore(){
    if [[ ${array[1]} -ge "90" ]] && [[ ${array[1]} -le "100" ]]; then
	score="A"
    elif [[ ${array[1]} -ge "80" ]] && [[ ${array[1]} -le "89" ]]; then
	score="B"
    elif [[ ${array[1]} -ge "70" ]] && [[ ${array[1]} -le "79" ]]; then
	score="C"
    elif [[ ${array[1]} -ge "60" ]] && [[ ${array[1]} -le "69" ]]; then
	score="D"
    else
	score="F"
    fi
}

exitPrint(){
    echo "----------------------------------------------------"
    echo "*** 프로그램을 종료합니다."
    exit
}

inputInfo(){
    echo -n "<<이름과 점수를 입력하세요>> : "
    read nameAndScore
    array=($nameAndScore)
    if [[ ${array[0]} = "exit" ]] || [[ ${array[0]} = "EXIT" ]] || [[ ${array[0]} = "Exit" ]]; then
	exitPrint
    fi
    calcScore
}

while :
do
    echo "----------------------------------------------------"
    inputInfo
    echo "----------------------------------------------------"
    outputInfo
done
