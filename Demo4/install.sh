#!/bin/sh
yum install -y httpd
chkonfig httpd on
echo "<html><h1>Hello DevOps ^^</h2></html>" > /var/www/html/index.html
service httpd start 
