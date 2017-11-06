ROLE
========================
Role alloy you to encapsulate the runlists and attributes required for a server to "be" what you think it is

It make the identical nodes easier to config without repeating

Create Roll
-------------------
Create /chef-repo/roles/<anyname>.rb:

    webserver.rb

Or
    $ knife role create webserver.rb

File in:

    name "webserver"
    description "Web Server"
    run_list "recipe[my-company]","recipe[apache]"
    #similar effect to the meta data depends

    default_attributes({
        "company" => "MyNewCompany"
    })

__run_list__ will tell the role what recipes the node need, this is a prefer place to add in dependecy

__"company" => "MyNewCompany"__ do the same thing as my-company recipe, but this will take precedence over cookbook. There are more place to made a new attributes

** recipe[apache::default] == recipe[apache]. If there are more than one recipe in the cookbook we can sepecify by recipe[apache::addOtherWeb]


Upload the Role
------------------------
Upload the role into chef-server

    $ knife role from file <rolename>.rb

    $ knife role from file webserver.rb

Modify
---------------------------
Using the web interface to modify the runlist.
Add roles to the node, but do not forget to remove other cookbook so it do not have redundancy


Other useful commands
------------------------
Show specific role information. will also show the various version in the server

    $ knife role show <rolename>

Show all the roles in the organization

    $ knife role list

Delete a role

    $ knife role delete <role name>


ENVIRONMENT
========================
Environment reflect your patterns and workflow
- Development
- Testing
- Staging
- Production
- etc.

Enivronment may include attributes necessary for config the infrastructure in that environment
Ex. The version of Chef cookbooks to be used 

Best Practise
----------------------
If you need to share a cookbooks or roles, you likely want an Environment than an organization.

Environment allow for isolating resources within a single organization.

Organization - do not share any cookbook 
Environment - allow to share a cookbook


Create Environment
---------------------------
Create folder if needed /chef-repo/environments/

Create a file /environments/<name>.rb:

    name "dev"
    description "For development"
    cookbook "apacheBase", "= 0.2.0"

__cookbook__ allow to do the version control. We can chage the version in the cookbook metadata.rb


Upload cookbook
---------------------------
