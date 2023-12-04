#!/usr/bin/sh
DATA='{"user": {"email": "wayahead2009@live.com", "password": "WqA1yT2z", "password_confirmation": "WqA1yT2z"}}'
echo $DATA | jq
curl -X POST -H "Content-Type: application/json" -d "$DATA" "http://localhost:3000/api/v1/sign_ups" --trace-ascii -
