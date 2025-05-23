#!/bin/bash

# These environment variables are provided by Certbot
# $CERTBOT_DOMAIN: The domain being authenticated
# $CERTBOT_VALIDATION: The validation string
# $CERTBOT_TOKEN: (not used here)

source .env

DNS_KEY="_acme-challenge"
DNS_VALUE="$CERTBOT_VALIDATION"


REQUEST_BODY=$(cat <<EOF
{
  "overwrite": true,
  "zone": [
    {
      "name": "$DNS_KEY",
      "records": [
        {
          "content": "$DNS_VALUE"
        }
      ],
      "ttl": 60,
      "type": "TXT"
    }
  ]
}
EOF
)

echo "Adding DNS record for $CERTBOT_DOMAIN with value $DNS_VALUE"
echo $REQUEST_BODY
echo "---------------------"

curl --request PUT \
  --url https://developers.hostinger.com/api/dns/v1/zones/$CERTBOT_DOMAIN \
  --header "Authorization: Bearer $BEARER_TOKEN" \
  --header 'Content-Type: application/json' \
  --data "$REQUEST_BODY" --silent --output /dev/null
