#installe
	sudo apt update
	sudo apt install nginx libapache2-mod-php7.4
	sudo apt install php7.4-gd php7.4-mysql php7.4-curl php7.4-mbstring php7.4-intl
	sudo apt install php7.4-gmp php7.4-bcmath php-imagick php7.4-xml php7.4-zip

#mysql
	sudo apt install mariadb-server
	sudo /etc/init.d/mysql start
	sudo mysql -uroot -p

	CREATE USER 'oli'@'localhost' IDENTIFIED BY '___';
	CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
	GRANT ALL PRIVILEGES ON nextcloud.* TO 'oli'@'localhost';
	FLUSH PRIVILEGES;

	quit;
#SSL 
	a2enmod ssl
	a2enmod rewrite

	mkdir /etc/ssl/nginx
	cd /etc/ssl/nginx/
	openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out sim-nord.crt -keyout sim-nord.key

#installe nextcloud
	#https://download.nextcloud.com/server/releases/nextcloud-21.0.1.zip
	md5sum -c nextcloud-21.0.1.tar.bz2.md5 < nextcloud-21.0.1.tar.bz2
	sha256sum -c nextcloud-21.0.1.tar.bz2.sha256 < nextcloud-21.0.1.tar.bz2
	md5sum  -c nextcloud-21.0.1.zip.md5 < nextcloud-21.0.1.zip
	sha256sum  -c nextcloud-21.0.1.zip.sha256 < nextcloud-21.0.1.zip

	wget https://download.nextcloud.com/server/releases/nextcloud-21.0.1.tar.bz2
	wget https://download.nextcloud.com/server/releases/nextcloud-21.0.1.zip
	wget https://download.nextcloud.com/server/releases/nextcloud-21.0.1.tar.bz2.asc
	wget https://nextcloud.com/nextcloud.asc
	gpg --import nextcloud.asc
	gpg --verify nextcloud-21.0.1.tar.bz2.asc nextcloud-21.0.1.tar.bz2

	tar -xjvf nextcloud-21.0.1.tar.bz2
	unzip nextcloud-21.0.1.zip

	mkdir /var/www/nextcloud
	cp -r nextcloud /path/to/webserver/document-root
	cp -r nextcloud /var/www/nextcloud/ 