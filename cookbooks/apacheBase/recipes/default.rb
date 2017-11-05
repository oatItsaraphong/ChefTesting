#
# Cookbook:: apacheBase
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Purpose:  To install apache2 
#           Apache must start on reboot
#           Put a file into the server



#-----------------------------------
#This get move to attributes/default.rb
# to manage it easier
#
#package_name = "apache2"
#service_name = "apache2"
#document_root = "/var/www"

#httpd == apache2 in CentOS
#this is for CentOS and RedHat
#if node["platform"] == "centos"
#    package_name = "httpd"
#    service_name = "httpd"
#    document_root = "/var/www/html"
#end
#---------------------------------------

#install apache
# install apache
#package package_name do

#this use the variale node["package_name"] from attributes/default.rb
package node["package_name"] do
    action :install
end
#chef will take action if it require
#  tell what we want to happend not how
# ex. linux --> apt-get install apache2
# ex. centos --> yum install http..

#Start the apache service
#make sure the service start on reboot

#service service_name do

#this use the variale node["service_name"] from attributes/default.rb
service node["service_name"] do
    action [:enable, :start]
end
# :enable mean it will restart the servie on reboot
# [,] this is the ruby arrat 


#write homepage
#cookbook_file "#{document_root}/index.html" do
#    source "index.html"
#    mode "0644"
#end

# #{doucment_root} = at runtime it will expand to the variable 
# type = cookbook_file
# name = "/var/www/index.html"  //cilent local file
# parameter = source.. , mode...
# index.html will need to be in /files in cookbook


#template allow to use erb file
#   erb = embeded ruby
#template "#{document_root}/index.html" do

#this use the variale node["document_root"] from attributes/default.rb
template "#{node["document_root"]}/index.html" do
    source "index.html.erb"
    mode "0644"
end
