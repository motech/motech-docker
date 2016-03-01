#!/bin/bash

# Run mysql
# We are doing this because of issues with D-BUS on Ubuntu based systems

tfile=`mktemp`
if [[ ! -f "$tfile" ]]; then
    return 1
fi

cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'mysql'@'localhost' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("password") WHERE user='mysql';

EOF

echo "Starting mysqld_safe 		*"
/usr/bin/mysqld_safe &

sleep 5s
ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock
echo "Save ip and password mysql	**"
chmod 777 $tfile
mysql < $tfile

echo "Exit from mysqld_safe		***"
mysqladmin -u root shutdown

echo "Starting motech			****"
/etc/init.d/motech start

echo "Starting mysqld		        *****"
runuser -l mysql -c 'mysqld --bind-address=127.0.0.1'

