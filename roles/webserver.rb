#roles/webserver.rb

name "webserver"
description "Web Server"
run_list "recipe[my-company]","recipe[apacheBase]"

default_attributes({
    "company" => "MyNewCompany"

})