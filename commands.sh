#!/bin/bash
# Edit your commands in this file.

# This file is public domain in the USA and all free countries.
# Elsewhere, consider it to be WTFPLv2. (wtfpl.net/txt/copying)

if [ "$1" = "source" ];then
	# Edit the token in here
	TOKEN='182835165:AAH8j8TuQsb2VPuqIR2-_4m-AyRBFgnFDSo'
	# Set INLINE to 1 in order to receive inline queries.
	# To enable this option in your bot, send the /setinline command to @BotFather.
	INLINE=0
	# Set to .* to allow sending files from all locations
	FILE_REGEX='/home/user/allowed/.*'
else
	if ! tmux ls | grep -v send | grep -q $copname; then
		[ ! -z ${URLS[*]} ] && {
		curl -s ${URLS[*]} -o $NAME
			send_file "${USER[ID]}" "$NAME" "$CAPTION"
			rm "$NAME"
		}
		[ ! -z ${LOCATION[*]} ] && send_location "${USER[ID]}" "${LOCATION[LATITUDE]}" "${LOCATION[LONGITUDE]}"

		# Inline
		if [ $INLINE == 1 ]; then
			# inline query data
			iUSER[FIRST_NAME]=$(echo "$res" | sed 's/^.*\(first_name.*\)/\1/g' | cut -d '"' -f3 | tail -1)
			iUSER[LAST_NAME]=$(echo "$res" | sed 's/^.*\(last_name.*\)/\1/g' | cut -d '"' -f3)
			iUSER[USERNAME]=$(echo "$res" | sed 's/^.*\(username.*\)/\1/g' | cut -d '"' -f3 | tail -1)
			iQUERY_ID=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -1)
			iQUERY_MSG=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -6 | head -1)

			# Inline examples
			if [[ $iQUERY_MSG == photo ]]; then
				answer_inline_query "$iQUERY_ID" "photo" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg"
			fi

			if [[ $iQUERY_MSG == sticker ]]; then
				answer_inline_query "$iQUERY_ID" "cached_sticker" "BQADBAAD_QEAAiSFLwABWSYyiuj-g4AC"
			fi

			if [[ $iQUERY_MSG == gif ]]; then
				answer_inline_query "$iQUERY_ID" "cached_gif" "BQADBAADIwYAAmwsDAABlIia56QGP0YC"
			fi
			if [[ $iQUERY_MSG == web ]]; then
				answer_inline_query "$iQUERY_ID" "article" "Telegram" "https://telegram.org/"
			fi
		fi
	fi
	
	
	
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

#ls | grep $ID
#if [ $? != 0 ]; then
	# touch $LOG1
	# touch $LOG2
	# touch $LOG3
	# touch $LOG4
	# touch $LOG5
	# touch $LOG6
# fi

RUN=config/run.config
CANCEL=config/cancels.config
FSEC=config/seconds.config
SEC=20


# ######### #
# FUNCTIONS #
# ######### #

check_settings () {

# 1

RUN1=$(grep ${ID}_1 $RUN )
if [ $? == 1 ]; then
	RUN1=$(echo "Not running" )
else
	RUN1=$(echo "Running" )
fi

SEC1=$(grep ${ID}_1 $FSEC | cut -d '_' -f3 )
if [ -z "${SEC1}" ]; then
	SEC1=20
fi
LINK1=$(cat $LOG1 | head -1 )

# 2

RUN2=$(grep ${ID}_2 $RUN )
if [ $? == 1 ]; then
	RUN2=$(echo "Not running" )
else
	RUN2=$(echo "Running" )
fi

SEC2=$(grep ${ID}_2 $FSEC | cut -d '_' -f3 )
if [ -z "${SEC2}" ]; then
	SEC2=20
fi
LINK2=$(cat $LOG2 | head -1 )

# 3

RUN3=$(grep ${ID}_3 $RUN )
if [ $? == 1 ]; then
	RUN3=$(echo "Not running" )
else
	RUN3=$(echo "Running" )
fi

SEC3=$(grep ${ID}_3 $FSEC | cut -d '_' -f3 )
if [ -z "${SEC3}" ]; then
	SEC3=20
fi
LINK3=$(cat $LOG3 | head -1 )

# 4

RUN4=$(grep ${ID}_4 $RUN )
if [ $? == 1 ]; then
	RUN4=$(echo "Not running" )
else
	RUN4=$(echo "Running" )
fi

SEC4=$(grep ${ID}_4 $FSEC | cut -d '_' -f3 )
if [ -z "${SEC4}" ]; then
	SEC4=20
fi
LINK4=$(cat $LOG4 | head -1 )

# 5

RUN5=$(grep ${ID}_5 $RUN )
if [ $? == 1 ]; then
	RUN5=$(echo "Not running" )
else
	RUN5=$(echo "Running" )
fi

SEC5=$(grep ${ID}_5 $FSEC | cut -d '_' -f3 )
if [ -z "${SEC5}" ]; then
	SEC5=20
fi
LINK5=$(cat $LOG5 | head -1 )

# 6

RUN6=$(grep ${ID}_6 $RUN )
if [ $? == 1 ]; then
	RUN6=$(echo "Not running" )
else
	RUN6=$(echo "Running" )
fi

SEC6=$(grep ${ID}_6 $FSEC | cut -d '_' -f3 )
if [ -z "${SEC6}" ]; then
	SEC6=20
fi
LINK6=$(cat $LOG6 | head -1 )

send_markdown_message "$ID" "*Current settings:*
*Track 1:*
_State:_ $RUN1
_Checking Time:_ ${SEC1}s
$LINK1
*Track 2:*
_State:_ $RUN2
_Checking Time:_ ${SEC2}s
$LINK2
*Track 3:*
_State:_ $RUN3
_Checking Time:_ ${SEC3}s
$LINK3
*Track 4:*
_State:_ $RUN4
_Checking Time:_ ${SEC4}s
$LINK4
*Track 5:*
_State:_ $RUN5
_Checking Time:_ ${SEC5}s
$LINK5
*Track 6:*
_State:_ $RUN6
_Checking Time:_ ${SEC6}s
$LINK6
"

}

cancel_check () {

	send_markdown_message "$ID" "*Tracking $1 stoped*"
	echo ${ID}_${1} >> $CANCEL
	grep -v ${ID}_${1} $RUN > $RUN.bak
	mv $RUN.bak $RUN
	exit 1		
}

send_log () {

	send_markdown_message "$ID" "*Sending log for Track ${1}*"
	send_action "$ID" "upload_document"
	send_file "$ID" "/home/ubuntu/Check4ChangeAmazonBot/files/${1}_${ID}.txt" "Check4ChangeAmazonBot Price Log${1}"

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
	
	grep -v "${ID}_${1}_" $FSEC > $FSEC.bak
	mv $FSEC.bak $FSEC
	echo ${ID}_${1}_${TIME} >> $FSEC
	send_markdown_message "$ID" "Time check for product* $1 *set to* ${TIME}*."
}


check_link () {

	SEC=20
	LOG=files/${1}_${ID}.log
	
	grep -v $ID_$1 $CANCEL > $CANCEL.bak
	mv $CANCEL.bak $CANCEL
	LINK=`echo $MESSAGE | cut -d ' ' -f2`
	
	grep -e "${ID}_${1}" $RUN
	if [ $? == 0 ]; then
		send_message "$ID" "Please, cancel the tracking before starting a new one.
Write: /cancel$1"
		break	
	fi
	
	echo $LINK | grep -e "offer-listing"
	if [ $? != 0 ]; then
		send_markdown_message "$ID" "Please, send the *offer-listing* link of the product, like this: /check1 https://www.amazon.es/gp/offer-listing/B017T1LB2S "
		break
	fi
	
	if [ -z "${LINK}" ]; then
		send_message "$ID" "Please, send the link correctly."
		break
	fi
	
	send_markdown_message "$ID" "*Tracking link:* *$LINK*"
	RELX=0
				
	rm ${LOG}
	echo "_Link:_ ${LINK}" >> $LOG
	echo " " >> ${LOG}
	echo "telegram.me/Check4ChangeAmazonBot" >> ${LOG}
	echo " " >> ${LOG}
	echo "---- START MONITORING LOG ----" >> ${LOG}
	
	
	grep -e "${ID}_${1}_" $FSEC
	if [ $? == 0 ]; then
		SEC=$(grep -e "${ID}_${1}_" $FSEC | cut -d "_" -f 2 | head -1 )
	fi
	
	echo "${ID}_${1}" >> $RUN
		
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

*/settings*  :  To see the current status of all the tracks and configurations.

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
				echo ${USER[USERNAME]} ${USER[ID]} >> stats.txt
				send_action "${USER[ID]}" "typing"
				send_markdown_message "${USER[ID]}" "*Welcome* @${USER[USERNAME]}
				
This bot tracks Amazon prices of your products all the time, this is intended to do with products that have very hight drops of price in short moments of time.

When a change of price is detected, it will notify you and it will write it to a prices logfile which you can access everytime you want.

*Please see* /help *to see the commands and detailed options avaliable.*

Source code avaliable at: https://github.com/iicc1/Check4ChangeAmazonBot

*By:* @iicc1"
				;;
			
			# Settings
			'/settings')	
				check_settings
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

