#!/bin/bash
# Edit your commands in this file.

# This file is public domain in the USA and all free countries.
# Elsewhere, consider it to be WTFPLv2. (wtfpl.net/txt/copying)

if [ "$1" = "source" ];then
	# Edit the token in here
	TOKEN='Put your token here!'
	# Set INLINE to 1 in order to receive inline queries.
	# To enable this option in your bot, send the /setinline command to @BotFather.
	INLINE=0
	# Set to .* to allow sending files from all locations
	#FILE_REGEX='/home/user/allowed/.*'
	fi
	
	
#==============================================================================================		
#==============================================================================================		
#==============================================================================================

# if [ -z "${USER[USERNAME]}" ], then
	# USER[USERNAME]=(USER[FIRST_NAME])
# fi

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

RUN=config/run.conf
CANCEL=config/cancels.conf
FSEC=config/seconds.conf
FMIN=config/minimums.conf
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

PRICE1=$(grep ${ID}_1 $FMIN | cut -d '_' -f3 )
if [ -z "${PRICE1}" ]; then
	PRICE1=$(echo "When price changes" )
else
	PRICE1=$(echo "If drops under ${PRICE1}EUR/GBP" )
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

PRICE2=$(grep ${ID}_2 $FMIN | cut -d '_' -f3 )
if [ -z "${PRICE2}" ]; then
	PRICE2=$(echo "When price changes" )
else
	PRICE2=$(echo "If drops under ${PRICE2}EUR/GBP" )
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

PRICE3=$(grep ${ID}_3 $FMIN | cut -d '_' -f3 )
if [ -z "${PRICE3}" ]; then
	PRICE3=$(echo "When price changes" )
else
	PRICE3=$(echo "If drops under ${PRICE3}EUR/GBP" )
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

PRICE4=$(grep ${ID}_4 $FMIN | cut -d '_' -f3 )
if [ -z "${PRICE4}" ]; then
	PRICE4=$(echo "When price changes" )
else
	PRICE4=$(echo "If drops under ${PRICE4}EUR/GBP" )
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

PRICE5=$(grep ${ID}_5 $FMIN | cut -d '_' -f3 )
if [ -z "${PRICE5}" ]; then
	PRICE5=$(echo "When price changes" )
else
	PRICE5=$(echo "If drops under ${PRICE5}EUR/GBP" )
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

PRICE6=$(grep ${ID}_6 $FMIN | cut -d '_' -f3 )
if [ -z "${PRICE6}" ]; then
	PRICE6=$(echo "When price changes" )
else
	PRICE6=$(echo "If drops under ${PRICE6}EUR/GBP" )
fi

LINK6=$(cat $LOG6 | head -1 )

send_markdown_message "$ID" "*Current settings:*

*Track 1:*
_State:_ $RUN1
_Checking Time:_ ${SEC1}s
_Price Alert:_ ${PRICE1}
$LINK1
*Track 2:*
_State:_ $RUN2
_Checking Time:_ ${SEC2}s
_Price Alert:_ ${PRICE2}
$LINK2
*Track 3:*
_State:_ $RUN3
_Checking Time:_ ${SEC3}s
_Price Alert:_ ${PRICE3}
$LINK3
*Track 4:*
_State:_ $RUN4
_Checking Time:_ ${SEC4}s
_Price Alert:_ ${PRICE4}
$LINK4
*Track 5:*
_State:_ $RUN5
_Checking Time:_ ${SEC5}s
_Price Alert:_ ${PRICE5}
$LINK5
*Track 6:*
_State:_ $RUN6
_Checking Time:_ ${SEC6}s
_Price Alert:_ ${PRICE6}
$LINK6
"

}

cancel_check () {

	send_markdown_message "$ID" "*Tracking $1 stopped*"
	echo ${ID}_${1} >> $CANCEL
	grep -v ${ID}_${1} $RUN > $RUN.bak
	mv $RUN.bak $RUN

	grep -v ${ID}_${1} $FSEC > $FSEC.bak
	mv $FSEC.bak $FSEC
	
	grep -v ${ID}_${1} $FMIN > $FMIN.bak
	mv $FMIN.bak $FMIN
	
	rm files/${1}_${ID}.log

	exit 1		
}

send_log () {

	send_markdown_message "$ID" "*Sending log for Track ${1}*"
	send_action "$ID" "upload_document"
	send_file "$ID" "files/${1}_${ID}.log" "Check4ChangeAmazonBot Price Log${1}"

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


min_check () {

	MIN=`echo $MESSAGE | cut -d ' ' -f2`
	if [ -z "${MIN}" ]; then
		send_message "$ID" "Please, send a correct minimum price."
		exit 0
	fi
	
	if [[ $MIN == *['!'@#\$%^\&*()_+a-zA-Z]* ]]; then
		send_message "$ID" "Please, send a correct minimum price."
		exit 0
	fi
	
	if [ "$MIN" -gt 99999 ] || [ "$MIN" -le 1 ] ; then
		send_message "$ID" "Minimum price invalid."
		exit 0
	fi
	
	grep -v "${ID}_${1}_" $FMIN > $FMIN.bak
	mv $FMIN.bak $FMIN
	echo ${ID}_${1}_${MIN} >> $FMIN
	send_markdown_message "$ID" "Minimum price for product* $1 *set to* ${MIN}EUR/GBP*."
}



check_link () {

	SPECIAL=0
	BADGE='EUR'
	SEC=20
	MIN=0
	LOG=files/${1}_${ID}.log
	
	grep -v $ID_$1 $CANCEL > $CANCEL.bak
	mv $CANCEL.bak $CANCEL
	ASIN=`echo $MESSAGE | cut -d ' ' -f2`
	COUNTRY=`echo $MESSAGE | cut -d ' ' -f3`
	
	grep -e "${ID}_${1}" $RUN
	if [ $? == 0 ]; then
		send_message "$ID" "Please, cancel the tracking before starting a new one.
Write: /cancel$1"
		break	
	fi
	
	if [ -z "${ASIN}" ]; then
		send_message "$ID" "Please, send the ASIN correctly."
		break
	fi
	
	echo $ASIN | grep -e "B0"
	if [ $? != 0 ]; then
		send_markdown_message "$ID" "Please, send the *ASIN* of the product with the country name, like this: /check1 B017T1LB2S ES"
		break
	fi
	
	if [ -z "${COUNTRY}" ]; then
		send_message "$ID" "Please, send the country code (ES UK DE FR IT) correctly, like this: /check1 B017T1LB2S ES"
		break
	fi
	
	if [ "$COUNTRY" = "ES" ] || [ "$COUNTRY" = "IT" ] || [ "$COUNTRY" = "DE" ] || [ "$COUNTRY" = "UK" ] || [ "$COUNTRY" = "FR" ]; then
	
		if [ "$COUNTRY" = "ES" ]; then
			LOCALE=es
			BADGE='EUR'
		fi
	
		if [ "$COUNTRY" = "IT" ]; then
			LOCALE=it
			BADGE='EUR'
		fi	
		
		if [ "$COUNTRY" = "DE" ]; then
			LOCALE=de
			BADGE='EUR'
		fi	
		
		if [ "$COUNTRY" = "UK" ]; then
			LOCALE=co.uk
			SPECIAL=1
			BADGE='GBP'
		fi	
		
		if [ "$COUNTRY" = "FR" ]; then
			LOCALE=fr
			BADGE='EUR'
		fi
		
	else 
		send_message "$ID" "Please, send the country code (ES UK DE FR IT) correctly, like this: /check1 B017T1LB2S ES"
		break
		
	fi
	
	LINK=https://www.amazon.${LOCALE}/gp/offer-listing/${ASIN}
	
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
		SEC=$(grep -e "${ID}_${1}_" $FSEC | cut -d "_" -f 3 | head -1 )
	fi

	grep -e "${ID}_${1}_" $FMIN
	if [ $? == 0 ]; then
		MIN=$(grep -e "${ID}_${1}_" $FMIN | cut -d "_" -f 3 | head -1 )
	else
		MIN=0
	fi
	
	echo "${ID}_${1}" >> $RUN
		
	while true; do

		# If price changes when running. Temporal solution.
		grep -e "${ID}_${1}_" $FSEC
		if [ $? == 0 ]; then
			SEC=$(grep -e "${ID}_${1}_" $FSEC | cut -d "_" -f 3 | head -1 )
		fi

		grep -e "${ID}_${1}_" $FMIN
		if [ $? == 0 ]; then
			MIN=$(grep -e "${ID}_${1}_" $FMIN | cut -d "_" -f 3 | head -1 )
		else
			MIN=0
		fi
	
		grep -e $ID_$1 $CANCEL
		if [ $? == 0 ]; then
			break
			exit
		fi	
	
		date=$(date)
					
		if [ "$SPECIAL" == "1" ]; then
			REL=`curl -s $LINK | grep '<span class="a-size-large a-color-price olpOfferPrice a-text-bold">' | head -1 | cut -d ">" -f 2 | cut -d "<" -f1 | sed 's/^[[:space:]]*//' | cut -c3- | cut -f 1 -d" "`
		
		else
			REL=`curl -s $LINK | grep '<span class="a-size-large a-color-price olpOfferPrice a-text-bold">' | head -1 | cut -d ">" -f 2 | cut -d "<" -f1 | sed 's/^[[:space:]]*//' | cut -f 2 -d" " | tr "," "."`

		fi

		if [ -z "$REL" ]; then
			sleep 2
			continue
		fi
		
	
		if [ "$REL" != "$RELX" ]; then
			if [ "$RELX" == "0" ]; then
				send_markdown_message "$ID" "*Current price:* $REL $BADGE"
				send_markdown_message "$ID" "*Checking time:* $SEC seconds"
				send_markdown_message "$ID" "*Running!*"
				echo "$REL ------- $date" >> ${LOG}
				RELX=$REL
				continue
			fi


			if [ "$MIN" == "0" ]; then
			send_markdown_message "$ID" "*Price for Track $1 has changed!*
_Old price:_ $RELX $BADGE
_New price:_ $REL $BADGE
$LINK"
			else
			    MATCH=$( echo "$MIN>$REL" | bc )
   				 if [ $MATCH -eq 1 ]; then

send_markdown_message "$ID" "*Price for Track $1 has changed!*
_Alert price:_ $MIN $BADGE
_New price:_ $REL $BADGE
$LINK"
   				 fi
			fi

		

			echo "$REL ------- $date" >> ${LOG}


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

echo $MESSAGE | grep "^/price" 
if [ $? == 0 ]; then
	CHECK=`echo $MESSAGE | cut -d ' ' -f1`
	if [ $CHECK == "/price1" ]; then
		min_check "1"
	elif [ $CHECK == "/price2" ]; then
		min_check "2"
	elif [ $CHECK == "/price3" ]; then
		min_check "3"
	elif [ $CHECK == "/price4" ]; then
		min_check "4"
	elif [ $CHECK == "/price5" ]; then
		min_check "5"
	elif [ $CHECK == "/price6" ]; then
		min_check "6"
	fi
fi

		case $MESSAGE in
				
			'/help')
			send_action "${USER[ID]}" "typing"
			send_markdown_message "${USER[ID]}" "*How to use the bot:*

This bot can track up to *six* Amazon products at the same time. Each product will be checked separately, has a different logfile and other configurations.

To use the bot, you need to provide the Amazon *ASIN* of the product wich can be taken from the link of the product.
For example, for this product: _https://www.amazon.es/dp/B013P2K9NC_ the *ASIN* is B013P2K9NC.
If you don't know how to take the ASIN of the product, send the Amazon link of the product to @ShurAmazonBot.

As product checking runs separately, commands are separated for the different tracking items:

*/check<1-6> <ASIN> <Country name>*  : It will start tracking that item with the number selected (1-6). Country names avaliable: *ES UK FR DE IT.*

*/seconds<1-6> <5-99999>*  : Time between checking price of the product (default is 20s). Optional field.

*/price<1-6> <0-999999>*  : You can set a minimum value for the price to get a notification (by default you will be notified allways if there is any change). Optional field.

*/cancel<1-6>*  : This cancels the specified tracking.

*/log<1-6>*  : Bot will upload the price logfile of the tracking.

*/settings*  :  To see the current status of all the tracks and configurations.

*Examples of commands:*

*/check2 B013P2K9NC ES *: This will be checking the price of the product B013P2K9NC in Spain
*/log1 * :  The log of track number 1 will be sent.
*/cancel6* :  The tracking 5 will stop to check prices.
*/secconds5 120*  : This will be set 120s to the tracking time of track 5. 
*/price1 56*  : You will only get notifications if price of track 1 drops over 56EUR/GBP

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

*Source code* avaliable at: https://github.com/iicc1/Check4ChangeAmazonBot

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

