#!/bin/bash

######################
##  Danielle Ascoli ##
##	Gino Trombetti  ##
##	CSCI 435		##
##	Final Project	##
##	Linux script	##
######################

# system_page - A script to produce a local instance of a Website on an Apache server

######## If this was on a fresh install of Linux we would need to run these commands for PHP, MySQL, and Apache2
#sudo apt-get install php5-mysql or ---
#sudo aptitude install php5 apache2 mysql-server-5
cd /etc

echo "Navigating to etc file - Complete"

####### This  portion adds our local "URL" to our hosts file

echo "What is the Server Name"
read serverName
echo "127.0.0.1       $serverName" >> hosts

echo "Added Document to hosts file"



######## This portion prompts the user for information needed inorder to create a Virtual Host


cd /etc/apache2/extra

echo "What will the Document Root Be?"
read documentRoot

echo "Where would you like to add your ErrorLog"
read errLog

echo "Where would you like to add your Custom Log"
read customLog

######## Add our user inputs to our apache virtual hosts configuration file


echo " <VirtualHost *:80>
	DocumentRoot '$documentRoot'
	ServerName $serverName
	ErrorLog '$errLog'
	CustomLog '$customLog' common
	<Directory />
		Require all granted
	</Directory>
	</VirtualHost>" >> httpd-vhosts.conf
cd

######### Check if our document root exists,  if not create that directory



if [ ! -d "$documentRoot" ]; then
		echo "Directory Root does not exists"
		mkdir "$documentRoot"
fi

######### Lets move into our document root and create an index.php (site entry)


cd /$documentRoot
if [ ! -f "index.php" ]; then
	touch index.php
	echo "Created Site Entry Point"
	echo '<?php echo
	"Site Home Page";' >> index.php
else
	echo "index.php entry point already exists"
fi

######## Lets obtain some styles from our general code file


mkdir css
echo "Created CSS file"
cd ../general-code
if [ -d css ]; then
	cp -rf css $documentRoot
	echo "Found CSS directory -- Copying over to your site"
fi
######## In order to test our local webpage http://$serverName we must restart the Apache Server


sudo apachectl graceful
echo "Restarting Apache Server"
echo "Looking in general code file for database.php"

######## If site works, then we have a local version of a website running on an Apache Server! Yay


open "http://$serverName"


######## Now we need a database connection,  lets navigate to our general code file and copy over a default DB connection
######## Afer we add the connection file we will connect to database using shell commands
######## Then we choose a database name

cd ../general-code
if [ -f database.php ]; then
	 cp database.php $documentRoot
	echo "Found file database.php"
	read -p "What would you like your database to be called? " dbprompt
	mysql -u root -p -e "CREATE DATABASE $dbprompt;"
else
	echo "File database.php not found"
fi

cd $documentRoot

######### Now that we have a fully running local site,  lets change the entry point of our site to something prettier

read -p "Would you like to modify your site entry point (index.php) - Y / N ? " prompt

if [[ $prompt == "y" || $prompt == "Y" ]]; then
	echo "Entry Point Changed"
	else
		echo "Enjoy making your new Site!"
	fi

open "http://$serverName/css/index.html"
