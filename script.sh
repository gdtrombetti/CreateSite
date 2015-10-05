#!/bin/bash

# system_page - A script to produce an system information HTML file

cd /etc

echo "Navigating to etc file - Complete"

echo "What is the Server Name"
read serverName
echo "127.0.0.1       $serverName" >> hosts

echo "Added Document to hosts file"

cd /etc/apache2/extra

echo "What will the Document Root Be?"
read documentRoot

echo "Where would you like to add your ErrorLog"
read errLog

echo "Where would you like to add your Custom Log"
read customLog

echo "  <VirtualHost *:80>
						 DocumentRoot '$documentRoot'
						 ServerName $serverName
						 ErrorLog '$errLog'
						 CustomLog '$customLog' common
				<Directory />
						Require all granted
				</Directory>
				</VirtualHost>" >> httpd-vhosts.conf
if [ ! -d "$documentRoot" ]; then
		echo "Directory Root does not exists"
		mkdir "$documentRoot"
fi