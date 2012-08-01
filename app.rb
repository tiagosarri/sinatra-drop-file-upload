require "sinatra"
require 'sinatra/static_assets'
require 'mongoid'

require './models/user'
require './models/photo'
require './uploaders/avatar_uploader'

enable :sessions
set :raise_errors, false
set :show_exceptions, false

configure do
  Mongoid.load!("./config/mongoid.yml")
end

helpers do
  def host
    request.env['HTTP_HOST']
  end

  def scheme
    request.scheme
  end

  def url_no_scheme(path = '')
    "//#{host}#{path}"
  end

  def url(path = '')
    "#{scheme}://#{host}#{path}"
  end

end

get "/" do
  #@temp = Photo.all
  @temp = nil
  #Photo.all.destroy
  erb :index
end

post '/post_user' do
  if (params[:email] != nil && params[:email] != "")
    user = User.get_or_create params[:email]
    
    if (user != nil)
      session[:user_id] = user.id
      photos = Photo.load_by_user user.id
    end
    return "{ \"type_return\" : \"ok\", \"photos\" :  #{photos.to_json} }"
  else
    return '{ "type_return" : "error", "message" :  "email invalid" }'  
  end
end

post '/upload' do
  demo_mode = false
  upload_dir = "public/uploads"
  
  if (!demo_mode)
    if params[:pic]
      Photo.create! :user_id => session[:user_id], :avatar => params[:pic] 
      #File.open(File.join(upload_dir, filename), 'wb') {|f| f.write file.read }
      return "{\"status\":\"File was uploaded successfuly!\"}"  
    else
      return "{\"status\":\"error.\"}"  
    end
  else
    return "{\"status\":\"Uploads are ignored in demo mode.\"}"    
  end
end