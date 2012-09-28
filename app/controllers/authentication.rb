require 'tilt/haml'
require '../app/models/users/user'
require '../app/models/items/item'

class Authentication < Sinatra::Application

  get "/login" do
    haml :login
  end

  post "/login" do
    name = params[:username]
    password = params[:password]

    if name.nil? or password.nil?
      redirect '/login'
    end

    user = Users::User.by_name name

    if user.nil? or password != name
      redirect '/login'
    end

    session[:name] = name
    redirect '/'
  end


  get "/logout" do
    session[:name] = nil
    redirect '/login'
  end

  get "/buy" do
    haml :buy
  end

end