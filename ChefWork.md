How chef work
================================================


What happend when Client Run
----------------------------------------------------------

Chef-Client -> 
1. Build node - using ohai
2. Authenticate
3. Sync cookbooks(expand run list) if run list is not modify then it does not download the runlist
4. Load cookbooks - load to memory and component
5. Convergen - Check and run recipe, walkthrought any each recipe in run list and check if it meet the desired state
    - Keep checking if it success
        - Yes - node.save
        - No - exception
6. Noiftication handler - can do anything (module), if exception occure send email to operation team, or use a recording 


Authentication
----------------------------------------------------------

Chef-server require keys:
- client.pem - private key for API client
- validation.pem - private key for OrganizationName-Validator

chef-client have client.pem in /etc/chef/

if __Yes__ 
    use client.pem to sign the request

if __No__ And have validation.pem in /etc/chef/
    Client request API client key from server
    Server will generate and send client.pem
    Use client.pem to sign the request

else
    Error 401

Create the new node
Assume the client(intend to be chef-client) node have no chef install

1. When bootstrap with knife, it will store the validation.pem(organizaion key) into the client.
2. The chef-client will use validation.pem to request an new client.pem from the chef-server

After chef-client have the client.pem, it will use client.pem to sign any request to the chef-server



Node
----------------------------------------------------------
Node - is any physical, virtual or cloud machines that is configured to be maintained by a chef.

Node are made up of Attributes
- Many are discoverd automatically (platform, ip, number of cpu)
- Other object in Chef ca also add Node attribure(cookbooks, roles, environment, recipes)
- Get attribute from __ohai__ Ex: sudo ohai | less



Each node must have a unique name within an organization

Chef will use the node name to derive the Fully Qualified Domain Name

Command:

    $ knife node list

This will list all the nodes name that are under this organization

    $ knife node show <node name>

This will list the detail of the specific nodes name

    $ knife node show <node name> <option>

* -l    This will list the detail in long list form - __ohai 
output__
* -Fj   format as JSON  (F = format, j = JSON)
* -a <attribute>    show a single attribue ex. -a fqdn

    $ knife search node "*:*" -a fqdn

Search the attribute in the node. "*:*" is solar query syntax format. "<key>:<value of a key>", __*__ = consider wildcard


More knife example:

    $ knife node show <nodename> -a memory

    $ knife node show <nodename> -a memory.total

-a memory will show all field under memory
-a memory.total will show total field in memory attribute

In html use ex index.html.erb:

    <%= node["memory"]["total"].to_i / 1024 %>

Show memory in MB format
**.erb = embeded ruby

Convergen
----------------------------------------------------------

To run the recipe the client will perform a convergence
It is a two step process
    1. Complie
    2. Execute

###Compile Phase
* Load all the cookbook from runlist
* Read Recipe
* Build a resource collection
    resource_colletion = [
        package["apache2"],
        service["apache2"],
        cookbook_file["/var/www/html/index.html"]
    ]

###Execution Phase
* Load the resource collection list
* Select one resource
* Check if the resource is in appropiate state?
        Yes - do nothing
* Move on to the next resource