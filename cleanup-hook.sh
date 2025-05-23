#!/bin/bash

source .env
DNS_KEY="_acme-challenge"
REQUEST_BODY=$(cat <<EOF
{
  "filters": [
    {
      "name": "$DNS_KEY",
      "type": "TXT"
    }
  ]
}
EOF
)

curl --request DELETE \
  --url https://developers.hostinger.com/api/dns/v1/zones/$CERTBOT_DOMAIN \
  --header "Authorization: Bearer $BEARER_TOKEN" \
  --header 'Content-Type: application/json' \
  --data "$REQUEST_BODY" --silent --output /dev/null