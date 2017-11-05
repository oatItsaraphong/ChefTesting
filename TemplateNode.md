Template
===========================
Template run from cookbooks/<cookbook_name>/templates/default/<file.type.erb>

Template will traslate .erb into a usable format in specific type. (made the enbeded ruby into string format for the specific file type)

Template can be centralize .erb file using cookbooks/<cookbook_name>/attributes/default.rb. It us




Example Use of Template:
------------------------------------
In html use ex index.html.erb:

    <%= node["memory"]["total"].to_i / 1024 %>

Show memory in MB format
**.erb = embeded ruby

Ex. :
    <body>
        <h1>Hello from <%= node["fqdn"] %> ! </h1>
        <p>
            This server AWS has <%= node["memory"]["total"].to_i / 1024 %> MB memory
        </p>
    </body>    

Command related to __knife__:

    $ knife node show <nodename> -a memory
    $ knife node show <nodename> -a memory.total

-a memory will show all field under memory
-a memory.total will show total field in memory attribute


Create a new Attribute for the node
---------------------

Create a new attribute is an easy and fast way to set some varible in the client node

    $ <h1>Hello from <%= node["fqdn"] %> ! </h1>

node["fqdn"] is a standard attribute in the node which __ohai__ will be able to extract, but we can create a new attribute to use.

    $ <h1>It from <%= node["company"] %> ! </h1>
    $ <h2>Hello from <%= node["fqdn"] %> ! </h2>

node["company"] is not a stardard attribue in the node and ohai cannot resolve it. We can create a new attribute by using declare an new attribute in cookbook/my-company/attributes/default.rb

    default["company"] = "MY_COMPANY"

__It is idea to create it with a new cookbook so it is centrailize__

This introduce a dependency problem where __apacheBase__ is __my-company__ so we need to create a dependency on __apacheBase__

In cookbooks/apacheBase/metadata.rb add   __depends 'my-company'__  __Warning: This is a bad way to solve this problem.__ If you add the cookbook as a dependency then you do not need to add the dependency to the runlist. Ex. apacheBase will be in the runlist but my-company will not. Chef-client will be about to use anything in my-company without my-compnay in the run list.


File Location
-----------------------
Source for each type:
- cookbook_file - 'source' located in 'files' directory
- template - 'source' located in 'templates' dir