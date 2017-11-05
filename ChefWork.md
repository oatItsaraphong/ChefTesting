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