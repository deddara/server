wp_db = 'wordpress'
phpmyadmin_db = 'phpmyadmin'
username = 'admin'
userpassword = 'admin'
hostname = 'localhost'

service mysql start

mysql -e "CREATE USER '$username'@'$hostname' IDENTIFIED BY '$userpassword'"

mysql -e "CREATE DATABASE $phpmyadmin_db;"
mysql -e "GRANT ALL PRIVILEGES ON $phpmyadmin_db.* TO '$username'@'$hostname';"
mysql -e "FLUSH PRIVILEGES;"

mysql -e "CREATE DATABASE $wp_db;"
mysql -e "GRANT ALL PRIVILEGES ON $wp_db.* TO '$username'@'$hostname';"
mysql -e "FLUSH PRIVILEGES;"
