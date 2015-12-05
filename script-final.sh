

#!/bin/bash

# system_page - A script to produce an system information HTML file
#sudo apt-get install php5-mysql or ---
#sudo aptitude install php5 apache2 mysql-server-5
cd /etc

echo "Navigating to etc file - Complete"

echo "What is the Server Name"
read serverName
echo "127.0.0.1       $serverName" | sudo tee -a hosts

echo "Added Document to hosts file"

cd /etc/apache2/extra

echo "What will the Document Root Be?"
read documentRoot

echo "Where would you like to add your ErrorLog"
read errLog

echo "Where would you like to add your Custom Log"
read customLog

echo " <VirtualHost *:80>
						DocumentRoot '$documentRoot'
						 ServerName $serverName
						 ErrorLog '$errLog'
						 CustomLog '$customLog' common
				<Directory />
						Require all granted
				</Directory>
				</VirtualHost>" | sudo tee -a httpd-vhosts.conf
cd
cd sites
if [ ! -d "$documentRoot" ]; then
		echo "Directory Root does not exists"
		mkdir "$documentRoot"
fi
cd /$documentRoot
if [ ! -f "index.php" ]; then
	touch index.php
	echo "Created Site Entry Point"
else
	echo "index.php entry point already exists"
fi
echo '<?php echo
 "Site Home Page";' >> index.php
sudo apachectl graceful
echo "Looking in general code file for database.php"
open "http://opsys.l"
cd ../general-code
if [ -f database.php ]; then
	 cp database.php ../opsys-final
	 echo "Found file database.php"
else 
	echo "File database.php not found"
fi

read -p "Would you like to modify your site entry point (index.php) - Y / N ? " prompt
if [[ $prompt == "y" || $prompt == "Y" ]]; then
	echo "Removing Contents of index.php"
	> index.php
else
fi
open "http://opsys.l"

