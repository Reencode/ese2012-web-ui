require 'rubygems'
require 'sinatra'
require 'tilt/haml'
require 'models/users/user.rb'
require 'controllers/main.rb'
require 'controllers/authentication.rb'

class App < Sinatra::Base

  use Authentication
  use Main

  enable :sessions
  set :public_folder,'app/public'

  configure :development do
    Users::User.named( 'ese' ).save()
    Users::User.named( 'Joel' ).save()
    Users::User.named( 'Aaron').save()
    Items::Item.feature("Magnifier",30,Users::User.by_name("ese")).save()
    Items::Item.feature("Cheddar Cheese from 1855",120,Users::User.by_name("ese")).save()
    Items::Item.feature("Tablespoon",30,Users::User.by_name("Joel")).save()

  end

end

# Now, run it
App.run!