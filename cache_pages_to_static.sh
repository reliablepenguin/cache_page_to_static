#!/bin/bash

BASE_URL="https://pricesigns.roundabouttheatre.org"
BASE_PATH="/var/www/vhosts/pricesigns.roundabouttheatre.org/httpdocs"

cache_sign() {
 SHOW=$1
 URL=$BASE_URL/$SHOW/index.php

 echo -n "Fetching $URL ... "
 RESPONSE=$(curl --write-out '%{response_code}' --silent --output $BASE_PATH/$SHOW/static.new.html $URL)

 echo -n "$RESPONSE "

 if [ "$RESPONSE" == "200" ]
 then
  echo -n "OK"
   if [ -s "$BASE_PATH/$SHOW" ];
    then
     echo -n "... IS > 0 ... making live ... "
     cp $BASE_PATH/$SHOW/static.new.html $BASE_PATH/$SHOW/static.html
     echo "DONE"
    else
     echo "IS = 0 ... SKIPPING"
   fi
 else
    echo "BAD ... SKIPPING"
 fi

}

cache_sign steinberg2
cache_sign americanairlines2
cache_sign sondheim
exit


