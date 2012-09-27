require 'tilt/haml'
require '../app/models/users/user'
require '../app/models/items/item'

class Main < Sinatra::Application

  get "/" do

    redirect '/login' unless session[:name]

    haml :welcome, :locals  => {      :time => Time.now ,
                                      :userList => Users::User.all,
                                      :current_name => session[:name],
                                      :allItemList => Items::Item.all }
  end

  get '/profile/:p_owner' do
     redirect '/login' unless session[:name]

    haml :profile, :locals  => {      :time => Time.now ,
                                      :userList => Users::User.all,
                                      :current_name => session[:name],
                                      :allItemList => Items::Item.all,
                                      :profile_owner => params[:p_owner] }
  end

  get '/change_status/:item_id' do
    redirect '/login' unless session[:name]
    Items::Item.by_id(params[:item_id].to_i).change_state


    haml :welcome, :locals  => {      :time => Time.now ,
                                      :userList => Users::User.all,
                                      :current_name => session[:name],
                                      :allItemList => Items::Item.all}
  end



get '/buy/:item_id' do
  redirect '/login' unless session[:name]



  haml :buy, :locals  => {      :time => Time.now ,
                                    :userList => Users::User.all,
                                    :current_name => session[:name],
                                    :allItemList => Items::Item.all,
                                    :itemToBuy => Items::Item.by_id(params[:item_id].to_i)}
end

end

