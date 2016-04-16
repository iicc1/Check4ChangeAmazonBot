#!/bin/bash
# bashbot, the Telegram bot written in bash.
# Written by @topkecleon, Juan Potato (@awkward_potato), Lorenzo Santina (BigNerd95) and Daniil Gentili (@danog)
# https://github.com/topkecleon/telegram-bot-bash

# Depends on ./JSON.sh (http://github.com/dominictarr/./JSON.sh),
# which is MIT/Apache-licensed
# And on tmux (https://github.com/tmux/tmux),
# which is BSD-licensed


# This file is public domain in the USA and all free countries.
# If you're in Europe, and public domain does not exist, then haha.


TOKEN='TOKENHERE'
URL='https://api.telegram.org/bot'$TOKEN

FORWARD_URL=$URL'/forwardMessage'

MSG_URL=$URL'/sendMessage'
PHO_URL=$URL'/sendPhoto'
AUDIO_URL=$URL'/sendAudio'
DOCUMENT_URL=$URL'/sendDocument'
STICKER_URL=$URL'/sendSticker'
VIDEO_URL=$URL'/sendVideo'
VOICE_URL=$URL'/sendVoice'
LOCATION_URL=$URL'/sendLocation'
ACTION_URL=$URL'/sendChatAction'
FORWARD_URL=$URL'/forwardMessage'

FILE_URL='https://api.telegram.org/file/bot'$TOKEN'/'
UPD_URL=$URL'/getUpdates?offset='
GET_URL=$URL'/getFile'
OFFSET=0
declare -A USER MESSAGE URLS CONTACT LOCATION

send_message() {
	local chat="$1"
	local text="$(echo "$2" | sed 's/ mykeyboardstartshere.*//g;s/ myfilelocationstartshere.*//g;s/ mylatstartshere.*//g;s/ mylongstartshere.*//g')"

	local keyboard="$(echo "$2" | sed '/mykeyboardstartshere /!d;s/.*mykeyboardstartshere //g;s/ myfilelocationstartshere.*//g;s/ mylatstartshere.*//g;s/ mylongstartshere.*//g')"

	local file="$(echo "$2" | sed '/myfilelocationstartshere /!d;s/.*myfilelocationstartshere //g;s/ mykeyboardstartshere.*//g;s/ mylatstartshere.*//g;s/ mylongstartshere.*//g')"

	local lat="$(echo "$2" | sed '/mylatstartshere /!d;s/.*mylatstartshere //g;s/ mykeyboardstartshere.*//g;s/ myfilelocationstartshere.*//g;s/ mylongstartshere.*//g')"

	local long="$(echo "$2" | sed '/mylongstartshere /!d;s/.*mylongstartshere //g;s/ mykeyboardstartshere.*//g;s/ myfilelocationstartshere.*//g;s/ mylatstartshere.*//g')"

	if [ "$keyboard" != "" ]; then
		send_keyboard "$chat" "$text" "$keyboard"
		local sent=y
	fi
	if [ "$file" != "" ]; then
		send_file "$chat" "$file" "$text"
		local sent=y
	fi
	if [ "$lat" != "" -a "$long" != "" ]; then
		send_location "$chat" "$lat" "$long"
		local sent=y
	fi

	if [ "$sent" != "y" ];then
		res=$(curl -s "$MSG_URL" -F "chat_id=$chat" -F "text=$text")
	fi

}

send_markdown_message() {
	res=$(curl -s "$MSG_URL" -F "chat_id=$1" -F "text=$2" -F "parse_mode=markdown")
}


send_file() {
	[ "$2" = "" ] && return
	local chat_id=$1
	local file=$2
	#echo "$file" | grep -qE '/home/allowed/.*' || return
	local ext="${file##*.}"
	case $ext in 
		*)
			CUR_URL=$DOCUMENT_URL
			WHAT=document
			STATUS=upload_document
			;;
	esac
	send_action $chat_id $STATUS
	res=$(curl -s "$CUR_URL" -F "chat_id=$chat_id" -F "$WHAT=@$file" -F "caption=$3")
}


get_file() {
	[ "$1" != "" ] && echo $FILE_URL$(curl -s "$GET_URL" -F "file_id=$1" | ./JSON.sh -s | egrep '\["result","file_path"\]' | cut -f 2 | cut -d '"' -f 2)

}


# typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for location

send_action() {
	[ "$2" = "" ] && return 
	res=$(curl -s "$ACTION_URL" -F "chat_id=$1" -F "action=$2")
}


process_client() {

	USERNAMECHAT=`echo $res | sed 's/^.*\(username.*\)/\1/g' | cut -d '"' -f3`
	# User
	USER[USERNAME]=$(echo "$res" | egrep '\["result",0,"message","chat","username"\]' | cut -f 2 | cut -d '"' -f 2)
	# Document
	URLS[DOCUMENT]=$(get_file $(echo "$res" | egrep '\["result",0,"message","document","file_id"\]' | cut -f 2 | cut -d '"' -f 2))
	# Photo
	URLS[PHOTO]=$(get_file $(echo "$res" | egrep '\["result",0,"message","photo",.*,"file_id"\]' | cut -f 2 | cut -d '"' -f 2 | sed -n '$p'))
	NAME="$(basename ${URLS[*]} &>/dev/null)"

	# Tmux 
	copname="CO${USER[ID]}"

	if ! tmux ls | grep -q $copname; then
		[ ! -z ${URLS[*]} ] && {
			curl -s ${URLS[*]} -o $NAME
			send_file "${USER[ID]}" "$NAME" "$CAPTION"
			rm "$NAME"
		}
		[ ! -z ${LOCATION[*]} ] && send_location "${USER[ID]}" "${LOCATION[LATITUDE]}" "${LOCATION[LONGITUDE]}"
		
#==============================================================================================		
#==============================================================================================		
#==============================================================================================

ID=${USER[ID]}
LOG1=files/1_${ID}.log
LOG2=files/2_${ID}.log
LOG3=files/3_${ID}.log
LOG4=files/4_${ID}.log
LOG5=files/5_${ID}.log
LOG6=files/6_${ID}.log

RUN=config/run.config
CANCEL=config/cancels.config
FSEC=config/seconds.config
SEC=20


# ######### #
# FUNCTIONS #
# ######### #

cancel_check () {

	send_markdown_message "$ID" "*Tracking $1 stoped*"
	echo $ID_$1 >> $CANCEL
	grep -v $ID_$1 $RUN > $RUN.bak
	mv $RUN.bak $RUN
	exit 1		
}

send_log () {

	send_markdown_message "$ID" "*Sending log for Track ${1}*"
	send_action "$ID" "upload_document"
	send_file "$ID" "/home/ubuntu/Check4ChangeAmazonBot/files/${1}_${ID}.log" "Check4ChangeAmazonBot Price Log${1}"

}	

seconds_check () {

	TIME=`echo $MESSAGE | cut -d ' ' -f2`
	if [ -z "${TIME}" ]; then
		send_message "$ID" "Please, send a correct time."
		exit 0
	fi
	
	if [[ $TIME == *['!'@#\$%^\&*()_+a-zA-Z]* ]]; then
		send_message "$ID" "Please, send a correct time."
		exit 0
	fi
	
	if [ "$TIME" -gt 9999 ] || [ "$TIME" -le 4 ] ; then
		send_message "$ID" "Time check invalid."
		exit 0
	fi
	
	grep -v "$ID_$1_" $FSEC > $FSEC.bak
	mv $FSEC.bak $FSEC
	echo $ID_$1_$TIME >> $FSEC
	send_message "$ID" "Time check for product $1 set to $TIME."
}


check_link () {

	SEC=20
	LOG=files/${1}_${ID}.log
	
	grep -v $ID_$1 $CANCEL > $CANCEL.bak
	mv $CANCEL.bak $CANCEL
	LINK=`echo $MESSAGE | cut -d ' ' -f2`
	
	grep -e "$ID_$1" $RUN
	if [ $? == 0 ]; then
		send_message "$ID" "Please, cancel the tracking before starting a new one.
Write: /cancel$1"
		break	
	fi
	
	if [ -z "${LINK}" ]; then
		send_message "$ID" "Please, send the link correctly."
		break
	fi
	
	send_markdown_message "$ID" "*Tracking link:* *$LINK*"
	RELX=0
				
	rm ${LOG}
	echo "Link: $LINK" >> $LOG
	echo " " >> ${LOG}
	echo "telegram.me/Check4ChangeAmazonBot" >> ${LOG}
	echo " " >> ${LOG}
	echo "---- START MONITORING LOG ----" >> ${LOG}
	
	
	grep -e "$ID_$1_" $FSEC
	if [ $? == 0 ]; then
		SEC=$(grep -e "$ID_$1_" $FSEC | cut -d "_" -f 2 | head -1 )
	fi
	
	echo "$ID_$1" >> $RUN
		
	while true; do
	
		date=`date`
		REL=`curl -s $LINK | grep '<span class="a-size-large a-color-price olpOfferPrice a-text-bold">' | head -1 | cut -d ">" -f 2 | cut -d "<" -f1 | sed 's/^[[:space:]]*//' | cut -f 2 -d" "`
					
		if [ -z "$REL" ]; then
			sleep 2
			continue
		fi
		
		grep -e $ID_$1 $CANCEL
		if [ $? == 0 ]; then
			grep -v $ID_$1 $CANCEL > $CANCEL.bak
			mv $CANCEL.bak $CANCEL
			break
		fi		
		if [ "$REL" != "$RELX" ]; then
			if [ "$RELX" == "0" ]; then
				send_markdown_message "$ID" "*Current price:* $REL EUR"
				send_markdown_message "$ID" "*Checking time:* $SEC seconds"
				send_markdown_message "$ID" "*Started!"
				echo "$REL ------- $date" >> ${LOG}
				RELX=$REL
				continue
			fi
			echo "$REL ------- $date" >> ${LOG}
			send_markdown_message "$ID" "*Price for Track $1 has changed!*
_Old price:_ $RELX EUR
_New price:_ $REL EUR"
		fi
		sleep $SEC
		RELX=$REL
		
	done
}		

echo $MESSAGE | grep "^/check" 
if [ $? == 0 ]; then
	CHECK=`echo $MESSAGE | cut -d ' ' -f1`
	if [ $CHECK == "/check1" ]; then
		check_link "1"
	elif [ $CHECK == "/check2" ]; then
		check_link "2"
	elif [ $CHECK == "/check3" ]; then
		check_link "3"
	elif [ $CHECK == "/check4" ]; then
		check_link "4"
	elif [ $CHECK == "/check5" ]; then
		check_link "5"
	elif [ $CHECK == "/check6" ]; then
		check_link "6"
	fi
fi

echo $MESSAGE | grep "^/seconds" 
if [ $? == 0 ]; then
	CHECK=`echo $MESSAGE | cut -d ' ' -f1`
	if [ $CHECK == "/seconds1" ]; then
		seconds_check "1"
	elif [ $CHECK == "/seconds2" ]; then
		seconds_check "2"
	elif [ $CHECK == "/seconds3" ]; then
		seconds_check "3"
	elif [ $CHECK == "/seconds4" ]; then
		seconds_check "4"
	elif [ $CHECK == "/seconds5" ]; then
		seconds_check "5"
	elif [ $CHECK == "/seconds6" ]; then
		seconds_check "6"
	fi
fi

		case $MESSAGE in
				
			'/help')
			send_action "${USER[ID]}" "typing"
			send_markdown_message "${USER[ID]}" "*How to use the bot:*
This bot can track up to six amazon products at the same time. Each product will be checked separately, has a different logfile and other configurations.

To use the bot, you need to provide the Amazon link of the product, but the link of the offer-listing of it. For example:
https://www.amazon.es/gp/offer-listing/B017T1LB2S

As product checking runs separately, commands are separated for the different tracking items:

*/check<1-6> <HereGoesAmazonLink>*  : It will start tracking that item.

*/seconds<1-6> <5-99999>*  : Time between checking price of the product (default is 20s).

*/cancel<1-6>*  : This cancels the specified tracking.

*/log<1-6>*  : Bot will upload the price logfile of the tracking.

- Use Notepad++ or similar to open the logfiles, otherwise the log will be shown in one line.		
"			
			;;
			
			'/res')
				send_message "${USER[ID]}" "$res"
			;;

			'/id')		
			send_message "${USER[ID]}" ":D"
			;;

			'/start')
				send_action "${USER[ID]}" "typing"
				send_markdown_message "${USER[ID]}" "*Welcome* @$USERNAMECHAT
				
This bot tracks Amazon prices of your products all the time, this is intended to do with products that have very hight drops of price in short moments of time.

When a change of price is detected, it will notify you and it will write it to a prices logfile which you can access everytime you want.

*Please see* /help *to see the commands and detailed options avaliable.*

Source code avaliable at: https://github.com/iicc1/Check4ChangeAmazonBot

*By:* @iicc1"
				;;
			
			# Cancel
			'/cancel1')	
				cancel_check "1"
				;;
			'/cancel2')	
				cancel_check "2"
				;;
			'/cancel3')	
				cancel_check "3"
				;;
			'/cancel4')	
				cancel_check "4"
				;;
			'/cancel5')	
				cancel_check "5"
				;;
			'/cancel6')	
				cancel_check "6"
				;;
			
			# Log
			'/log1')	
				send_log "1"
				;;
			'/log2')	
				send_log "2"
				;;
			'/log3')	
				send_log "3"
				;;
			'/log4')	
				send_log "4"
				;;
			'/log5')	
				send_log "5"
				;;
			'/log6')	
				send_log "6"
				;;
				
			'')
				;;
			*)
				
		esac

	fi
}

# source the script with source as param to use functions in other scripts
while [ "$1" != "source" ]; do {

	res=$(curl -s $UPD_URL$OFFSET | ./JSON.sh -s)

	# Target
	USER[ID]=$(echo "$res" | egrep '\["result",0,"message","chat","id"\]' | cut -f 2)
	# Offset
	OFFSET=$(echo "$res" | egrep '\["result",0,"update_id"\]' | cut -f 2)
	# Message
	MESSAGE=$(echo "$res" | egrep '\["result",0,"message","text"\]' | cut -f 2 | cut -d '"' -f 2)
	
	OFFSET=$((OFFSET+1))

	if [ $OFFSET != 1 ]; then
		process_client&

	fi

}; done

