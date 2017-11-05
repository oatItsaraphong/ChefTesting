#cookbooks/my-company/attributes/default.rb

# this will create a new attribute. in the client node
# this allow the client node to have a node["company"]
# this can be call by anything within the node
default["company"] = "MY_COMPANY"