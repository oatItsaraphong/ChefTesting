How to install and use chef



Step 1 Install Ruby
======================================================
Install Ruby In the workstation
https://rubyinstaller.org/downloads/

Step 2 Install workstation
======================================================
Install Chef Client in the workstation
https://downloads.chef.io/chef

Install Chef DK
https://downloads.chef.io/chefdk


Step 3 Setup chef-server
======================================================
Setup Chef Server (chef-repo)

Easy example
https://manage.chef.io/organizations/<orgname>/getting_started
Get and Starter Kit
  kit will contain key and some cookbook
  the kit will be for each oraganization
  extract the zip file

**verify if it running
**all command must be run in chef-repo

  check knife version --> knife --version
  check the client list -->  knife client list    //likely to have only one client - chef server
          organization-validator


Step 4 Setup AWS
======================================================
Set AWS

Set EC2 
  set Security Group - add TCP (ssh, http, https, custom tcp port 81-90)

Confirm the access to AWS using ssh connection


Step 5 What to know
=====================================================
Need to know from client
SSH username
SSH Pass
SSH port
IP address

sudo in client




Step 6 Bootstrap node using knife
====================================

This will link the chef-client(our target) to the chef-server.
It create a connection from chef-server to chef-clinet

**make sure the client is running 
**ohai - tool to collect system config data

All following action is perform from the workstation in chef-repo for the organization

in chef-ropo

* help 
knife bootstrap --help

knife boostrap FQDN (option)   //FQDN fully qualify domain name
                               // and actual chef-cli address
  --sudo
  -x SSH_user
  -P SSH_pass
  -p SSH_Port
  -N "nodeName"   //can be anything that tell you that is the node you working one
                  // from the chef-server

Ex. knife boostrap ec2-12-12-12--12.computer1.amazonaws.com --sudo -x user -P pass -p 22 -N "nodenaem"

Above command will conneect to chef-server(we are in chef-repo which connect to server)
The chef-server will connect to the chef-cli
All requirement will be install into client such as Ruby, chef-client , ohai and other
    chef and its all dependency

Can check by run in the client machine    Ex. --$ ohai
It should return all the information in the JSON format


Step 7 Start Cookbook
======================
COOKBOOK
================================

Cookbook  - package contain all recipes, files , templates and libraries
            to config a portion your infrastructure
          - likely to be 1:1 to a piece of software or functionality

Probmel need to be solve  -------------------------------------
Problem  : We need a web server configured to serve up our home page
Goal     : We can see the homepage in a web browser.

Need to complete
1. install Apache
2. Start the service and make sure it will start when machine bootstrap
3. Write out small homepage

Create Cookbook 
--------------------------------

Create cookbook(OLD not use)
  knife cookbook create <name of cookbook>
  Ex. knife cookbook create apacheBase

Create cookbook(New 12+)
  chef generate cookbook <cookbookname>
  Ex. chef generate cookbook apacheBase


Modify Recipes 
-------------------------------

the code will execute in order
In   chef-repo/apacheBase/recipes

Resoure in chef
template "/etc/haproxy/harproxy.cfg" do     
  source "happ"                                   
  owner "root"
  action [:enable, :start]
  notifies :restart, "service[harproxy]"
end

//template = type
// "/etc/ha....." = name
// source .., owner..    = parameter
// action = to put resource into desired State
// notificaion = send notificaion to other resource


Upload to cookbook server
----------------------------------

move the cookbook into cookbooks folder (if nesseary)
upload it by

knife cookbook upload <name>
Ex. knife cookbook upload apacheBase


Set a runlist
-------------------------------------------------

runlist - specify the policy for each node

in manage chef-server 
click the node / detail(tap)
runlist  > edit
add run list to the node

login to ssh to chef-client node
run >    sudo chef-client
it should perfom what specify in the cookbook

Checking
----------------------------------------
check aws for the website