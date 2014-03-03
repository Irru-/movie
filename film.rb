#!/usr/local/bin/ruby
#MovieWatchers
#Nick Gobee - Peter Dierx

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sinatra'
require 'sinatra/reloader'
require 'nokogiri'
require 'dm-aggregates'
require 'dm-core'
require 'dm-migrations'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-constraints'
require 'imdb'

also_reload "#{ settings.root }/film.rb"

class Film
  
  include DataMapper::Resource
  
  property :id,       Serial  # Serienummer
  property :titel,    String  # American Hustle
  property :bioscoop, String  # Pathe De Kuip
  property :datum,    Date    # 24-02-2014
  property :tijd,     Time    # 15:55
  property :zaal,     String  # 1
  property :rij,      Integer # 1
  property :stoel,    Integer # 8
  property :imdb,     String  # http://www.imdb.com/title/tt1800241/?ref_=nv_sr_1
  property :rating,   Integer # aantal sterren?
  property :info,     String  # Hele gave film
  property :poster,   String  # filespec bestandsnaam jpeg gescraped imdb
  property :snacks,   Integer # bedrag gesnacked :-)
  
end

configure :development do

  DataMapper.setup( :default, "sqlite3://#{ Dir.pwd }/database.sqlite3")

end

DataMapper.auto_migrate!
DataMapper.auto_upgrade!

get '/' do
  erb :index
end

post '/search' do
  p       = params[:film]
  titel   = p["titel"]

  @search_results = Imdb::Search.new(titel)

  erb :result
end

get '/search' do


  erb :result
end