require 'sinatra'
require 'vlc-client'
#========================================= SETTINGS SECTION ============================================================
# Start application on custom port
if /[\D]+/.match(ARGV[0])
  set :port, 4567
else
  if not ARGV[0].nil?
    set :port, ARGV[0].to_i
  else
    set :port, 4567
  end
end

set :bind => '0.0.0.0'
set :views => "#{File.dirname(__FILE__)}/views"

configure do
  @@vlc = VLC::Client.new('127.0.0.1', 9999)
end


get '/' do
  @@vlc.connect
  erb :root
end

get '/play' do
    @@vlc.connect
    @@vlc.play
    redirect '/'
end

get '/pause' do
    @@vlc.connect
    @@vlc.pause
    redirect '/'
end

get '/#prev' do
  puts 'prev!!!'
end

get '/#next' do
  puts 'next!!!'
end

get '/volup' do
  @@vlc.connect
  volume = @@vlc.volume
  @@vlc.volume = volume + 10
  redirect '/'
end

get '/voldown' do
  @@vlc.connect
  volume = @@vlc.volume
  @@vlc.volume = volume - 10
  redirect '/'
end

get '/fullscreen' do
  @@vlc.connect
  @@vlc.fullscreen
  redirect '/'
end