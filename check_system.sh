#!/bin/bash


message="mysqlis down, check if restart happened successfully"
apiToken=@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
chatId=@@@@@@@@@@@@@

sendMysql() {
        curl -s \
        -X POST \
        https://api.telegram.org/bot$apiToken/sendMessage \
        -d text="$message" \
        -d chat_id=$chatId
}

messageApache="apache is down, check if restart happened successfully"

sendApache(){
         curl -s \
        -X POST \
        https://api.telegram.org/bot$apiToken/sendMessage \
        -d text="$messageApache" \
        -d chat_id=$chatId
}


sendSuccess(){
         curl -s \
        -X POST \
        https://api.telegram.org/bot$apiToken/sendMessage \
        -d text="success running" \
        -d chat_id=$chatId
}


MYSQL_STATUS=$(service mysql status | grep "running" > /dev/null; echo $?)
if [ "$MYSQL_STATUS" -eq "1" ]; then
        sudo service mysql restart
        sendMysql
  #push "WOOOT! MySQL service has stopped, quickly connect that service up again! ...or move to mongo, what ever you want."
fi;

APACHE_STATUS=$(service apache2 status | grep "active (running)" > /dev/null; echo $?)
if [ "$APACHE_STATUS" -eq "1" ]; then
        sudo service apache2  restart
        sendApache
 # push "WOOOT! Apache2 is not running, your pages are unreachebles! Ohhh, won't somebody please think of the children."
fi;
