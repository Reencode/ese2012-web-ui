require 'rubygems'
require 'tilt/haml'
require 'models/users/user.rb'
require 'models/items/item.rb'

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
    haml :buy, :locals  => {          :time => Time.now ,
                                      :userList => Users::User.all,
                                      :buyer => session[:name],
                                      :seller => seller,
                                      :itemToBuy => itemToBuy,
                                      :allItemList => Items::Item.all
    }

  end

end