 
#! /bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
chmod 777 /var/www/html
echo "hello world" > /var/www/html/index.html
                