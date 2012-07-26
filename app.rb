require "sinatra"
require 'sinatra/static_assets'
require 'mongoid'

require './models/user'

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
  erb :index
end

post '/post_user' do
  if (params[:email] != nil && params[:email] != "")
    User.get_or_create params[:email]
    return '{ "type_return" : "ok", "message" :  "" }'
  else
    return '{ "type_return" : "error", "message" :  "email invalid" }'  
  end
end

post '/upload' do
  demo_mode = false
  upload_dir = "public/uploads"
  
  if (!demo_mode)
    if params[:pic]
      filename = params[:pic][:filename]
      file = params[:pic][:tempfile]
  
      File.open(File.join(upload_dir, filename), 'wb') {|f| f.write file.read }
      
      return "{\"status\":\"File was uploaded successfuly!\"}"
    else
      return "{\"status\":\"error.\"}"  
    end
  else
    return "{\"status\":\"Uploads are ignored in demo mode.\"}"    
  end
end