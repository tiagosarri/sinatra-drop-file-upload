require "sinatra"
require 'sinatra/static_assets'

set :raise_errors, false
set :show_exceptions, false

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