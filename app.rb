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
  if params[:file]
    filename = params[:file][:filename]
    file = params[:file][:tempfile]

    File.open(File.join("/uploads", filename), 'wb') {|f| f.write file.read }
    
    return "ok"
  else
    return "not ok #{params[:param1]}"  
  end
end