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
  # pid = Process.spawn('vlc --extraintf rc --rc-host 127.0.0.1:9999')
  # Process.detach(pid)

  @@vlc = VLC::Client.new('127.0.0.1', 9999)
end


get '/' do
  @@vlc.connect
  erb :root
end

get '/play' do
    @@vlc.connect
    if @@vlc.playing?
      @@vlc.pause
    elsif not @@vlc.playing?
      @@vlc.play
    end
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
  @@vlc.volume = @@vlc.volume + 10
  redirect '/'
end

get '/voldown' do
  @@vlc.connect
  @@vlc.volume = @@vlc.volume - 10
  redirect '/'
end

get '/mute' do
  @@vlc.connect
  if @@vlc.volume == 0
    @@vlc.volume = @@volume
  else
    @@volume = @@vlc.volume
    @@vlc.volume = 0
  end
  redirect '/'
end

get '/fullscreen' do
  @@vlc.connect
  @@vlc.fullscreen
  redirect '/'
end

get '/showtime' do
  redirect '/'
end
