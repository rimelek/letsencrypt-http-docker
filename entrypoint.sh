#!/bin/bash

LE_CERT=$1

: ${LE_EMAIL:?You must set the variable LE_EMAIL}

if [ "${LE_CERT}" == "" ]; then
   LE_CERT=$(ls /domains/); 
fi

for LE_CERT_i in ${LE_CERT}
do
  DOMAINS=$(sed '/^$/d;s/[[:blank:]]//g' /domains/${LE_CERT_i} | sed ':a;N;$!ba;s/\s/ -d /g')
  if [ "${DOMAINS}" != "" ]; then
    certbot certonly \
      --expand \
      --email ${LE_EMAIL} \
      --non-interactive \
      --agree-tos \
      --standalone \
      --preferred-challenges http-01 \
      --http-01-port 9080 \
      --cert-name ${LE_CERT_i} \
      -d ${DOMAINS}
  fi
done
