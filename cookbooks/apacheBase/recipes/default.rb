#
# Cookbook:: apacheBase
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#install apache
# install apache
package "apache2" do
    action :install
end
#chef will take action if it require
#  tell what we want to happend not how
# ex. linux --> apt-get install apache2
# ex. centos --> yum install http..

#Start the apache service
#make sure the service start on reboot
service "apache2" do
    action [:enable, :start]
end
# :enable mean it will restart the servie on reboot
# [,] this is the ruby arrat 


#write homepage
cookbook_file "/var/www/index.html" do
    source "index.html"
    mode "0644"
end
# type = cookbook_file
# name = "/var/www/index.html"  //cilent local file
# parameter = source.. , mode...
# index.html will need to be in /files in cookbook