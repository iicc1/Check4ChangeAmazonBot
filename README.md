# Check4ChangeAmazonBot


[![https://github.com/iicc1/Check4ChangeAmazonBot](https://img.shields.io/badge/Coverage-92%25-blue.svg)](https://github.com/iicc1/Check4ChangeAmazonBot)


#####_Public source code for the Telegram bot_ [Check4ChangeAmazonBot](https://telegram.me/Check4ChangeAmazonBot)        
          
============
##### Based on __Telegram-bot-bash__: https://github.com/topkecleon/telegram-bot-bash          
##### Using the official __Telegram API__: https://core.telegram.org/bots
============

### __Information:__
(A little bit outdated, it has more functions now.)               
This bot tracks Amazon prices of your products all the time, this is intended to do with products that have very hight drops of price in short moments of time. Thing that usually occurs in Amazon.

When a change of price is detected, it will notify you and it will write it to a prices logfile which you can access everytime you want.

============
### __How to use the bot:__

(A little bit outdated, it has more functions now.)               
This bot can track up to six amazon products at the same time. Each product will be checked separately, has a different logfile and other configurations.

To use the bot, you need to provide the Amazon link of the product, but the link of the offer-listing of it. For example:
https://www.amazon.es/gp/offer-listing/B017T1LB2S

As product checking runs separately, commands are separated for the different tracking items:

`/check<1-6> <HereGoesAmazonLink>`  : It will start tracking that item.

`/seconds<1-6> <5-99999>`  : Time between checking price of the product (default is 20s).

`/cancel<1-6>`  : This cancels the specified tracking.

`/log<1-6>`  : Bot will upload the price logfile of the tracking.

- Use Notepad++ or similar to open the logfiles, otherwise the log will be shown in one line.
 
============
#### __Example:__

(A little bit outdated, it has more functions now.)              
`/check1 https://www.amazon.es/gp/offer-listing/B00P738MUU/ref=dp_olp_new?ie=UTF8&condition=new`
This will asign that tracking to the _check1_

To get the log of the tracking __1__:
`/log1`

To set time checking (20s default):
`/seconds1 40`
Here we have set __40__ seconds time check for the track __1__

`/cancel1`
Cancels the tracking of the track __1__


You can do this with up to 6 products, `/track2 xxxx` `/cancel4` `/seconds5 xxxx` `/log3` and so on.


The number of products can't be set more high because it will overload the server and Amazon could block the IP.
 
============
#### __Using source code:__

To use the bot by yourself, follow this instructions:

*Paste* the __TOKEN__ of your bot from @Botfather in _bashbot.sh_       

*Clone the repo:* `git clone https://github.com/iicc1/Check4ChangeAmazonBot`       

*Start the bot:* `bash bashbot.sh start`              

*Stop the bot:* `bash bashbot.sh stop`             
 
============

##### If you have any troubles, contact me in [Telegram](https://telegram.me/iicc1)






