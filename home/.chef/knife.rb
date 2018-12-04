c_folder = ::File.dirname(__FILE__)
log_level              :info
log_location           STDOUT
# "node_name" is your username on the chef server.
# Change the value if it is not the same as your local username.
node_name              `whoami`.strip
# The file specified by "client_key" must contain the private key generated for
# your user on the chef server.
client_key             "#{c_folder}/#{ENV['FABRIC_AWS_ENVIRONMENT']}/user.pem"
validation_client_name 'chef-validator'
validation_key         "#{c_folder}/#{ENV['FABRIC_AWS_ENVIRONMENT']}/validator.pem"
cache_type             'BasicFile'
cookbook_path          ["#{ENV['CHEF_REPOSITORY']}/cookbooks"]
cache_options(:path => "#{c_folder}/checksums")
case ENV['FABRIC_AWS_ENVIRONMENT']
    when "staging"
        chef_server_url "https://staging-chef-server.bluevine.com/organizations/bluevine/"
    when "production"
        chef_server_url "https://prod-chef-server.bluevine.com/organizations/bluevine/"
    else
        chef_server_url "https://54.235.118.249/organizations/bluevine/"
    end

# START comment in after ssl
#if ENV['environment'] != 'development'
#    knife[:vault_mode] = 'client'
#    knife[:vault_admins] = Chef::Knife.new.rest.get_rest("groups/vault-admins")["users"]
#end
# END comment in after ssl
