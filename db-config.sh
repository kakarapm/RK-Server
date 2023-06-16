#!/bin/bash

# Check if the password is provided as a command-line argument
if [ $# -eq 0 ]; then
    echo "Error: MySQL root password not provided."
    echo "Usage: ./autorun.sh <password>"
    exit 1
fi

PASSWORD=$1

# Update package lists
sudo apt-get update -y

# Install MySQL Server
sudo apt-get install mysql-server -y

# Execute MySQL commands
sudo mysql -u root -p"$PASSWORD"<<EOF
DROP USER 'root'@'localhost';
CREATE USER 'root'@'%' IDENTIFIED BY '$PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit
EOF

# Modify MySQL configuration
sed -i -e '/innodb_buffer_pool_size/ s/.*/innodb_buffer_pool_size = 1100M/' \
       -e '/innodb_log_file_size/ s/.*/innodb_log_file_size = 128M/' \
       -e '/key_buffer_size/ s/.*/key_buffer_size = 0/' \
       -e '/innodb_buffer_pool_instances/ s/.*/innodb_buffer_pool_instances = 1/' \
       -e '$a\innodb_buffer_pool_size = 1100M\ninnodb_log_file_size = 128M\nkey_buffer_size = 0\ninnodb_buffer_pool_instances = 1' \
       /etc/mysql/mysql.conf.d/mysqld.cnf

# Restart MySQL service
sudo service mysql restart
