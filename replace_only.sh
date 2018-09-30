#/bin/bash

source config.env

echo "Search and Replace..."
#amsi.org.au replaced with dev (10.100.211.15)
#aprintern.amsi.org.au replaced with dev/aprintern

#use cli-phar to do search and replace
#http://wp-cli.org/
#https://www.kathirvel.com/changing-site-url-in-wordpress-wp-cli-tool/

#sample
#php wp-cli.phar search-replace 'events.amsi.org.au' '10.100.211.15/events' --network

echo $LOCAL_WWW

#the mapping between old and new URLs
while IFS="|" read -r prod_url dev_url
do
        echo "Replacing $prod_url with $dev_url"
        #php $LOCAL_WWW/wp-cli.phar search-replace $prod_url $dev_url --network --path=$LOCAL_WWW
        php $LOCAL_WWW/wp-cli.phar search-replace --path=$LOCAL_WWW --url=https://amsi.org.au https://$prod_url http://$dev_url --recurse-objects --network --skip-tables=wp_users --allow-root
done < "url_prod_to_dev.config"
