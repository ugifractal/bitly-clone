require 'byebug'
get '/' do
	@urls = Url.last(5)
	@urls.reverse!
  erb :"static/index"
end

post '/urls' do
	@url = Url.new(long_url: params[:long_url])

	if @url.save
		redirect to '/'

	else
		@error = "That URL is invalid."
		@urls = Url.all
		erb :"static/index"
	end
end


get '/:short_url' do
  @url = Url.find_by(short_url: params[:short_url])
  if @url
    @url.click_count += 1
    @url.save	
    redirect "#{@url.long_url}"
  else
    redirect "/"
  end
end

post '/api_url' do
  content_type :json 
  @url = Url.new(long_url: params[:long_url]) 
 
  if @url.save
    {'status' => 'ok', 'url' => "http://s.snppt.com/#{@url.short_url}"}.to_json
  else
    {'status' => 'error'}.to_json
  end
end
