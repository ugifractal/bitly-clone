require 'byebug'
get '/' do
	@urls = Url.all
  erb :"static/index"
end

post '/urls' do
	Url.create(long_url: params[:long_url])
	redirect to '/'
end


get '/:short_url' do
	@url = Url.find_by(short_url: params[:short_url])
	
	redirect "http://#{@url.long_url}"
end