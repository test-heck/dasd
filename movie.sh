movie=Dr.Strange

if [[ $(curl https://api.qfxcinemas.com/api/public/banners | jq -r '.data[] | select (.id==7721) | .buyTicket') =~ .*"true".* ]];
then
	curl -X POST --data-urlencode "payload={\"channel\": \"#test\", \"username\": \"webhookbot\", \"text\": \"This is posted to #test and $movie ayo\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
	echo 'yes'
else
	echo 'not available yet'
fi
