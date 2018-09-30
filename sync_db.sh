#/bin/bash
source config.env

#TO PREVENT OPENING FIREWALL ON 3306 TO EVERYONE
#DEV SERVERS DONT HAVE A PUBLIC IP YET

read -p 'PROD Database username: ' db_user
read -p 'PROD Database password: ' db_pass
read -p 'PROD Database name: ' db_name

output="$db_name_`date +%Y.%m.%d_%H:%M:%S`.sql"
dump_cmd="mysqldump -u $db_user -p$db_pass $db_name > /tmp/$output"
echo $dump_cmd

echo "Connecting to $PROD_SERVER...\n"
`ssh root@$PROD_SERVER` << EOF
	eval $dump_cmd
EOF

echo "Finished dumping database"
echo "Bring database dump to dev..."
echo "Default destination directory is $DEFAULT_DB_DIR"
scp_cmd="scp root@$PROD_SERVER:/tmp/$output $DEFAULT_DB_DIR"
eval $scp_cmd


echo "Done."
