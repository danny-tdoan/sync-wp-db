# Overview
A small utility to sync the database for wordpress multisite between server.

The script should be called from the server to which you want to migrate.

The utility takes care of:

1. Back up the current data base
2. Sync the database from the remote server to current server, e.g., from prod to dev
3. Import the database
4. Make necessary replacement of hostname for Wordpress to work due to the migration
