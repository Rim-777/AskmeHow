
role :app, %w{deployer@37.139.19.217}
role :web, %w{deployer@37.139.19.217}
role :db,  %w{deployer@37.139.19.217}

set :rails_env, :production
set :stage, :production

server '37.139.19.217', user: 'deployer', roles: %w{web app db}, primary: true



# Global options
# --------------

 set :ssh_options, {
   keys: %w(/Users/timur/.ssh/id_rsa),
   forward_agent: false,
   auth_methods: %w(publickey, password),
   port: 4321
 }


