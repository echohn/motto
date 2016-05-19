require 'sinatra'
require 'yaml'
require 'json'
require 'motto'

set :motto, Motto.new

get '/motto' do
  headers site_headers
  {motto: settings.motto.sample}.to_json
end

get '/motto/:category' do
  headers site_headers
  category = params[:category].downcase
  if settings.motto.categories.include? category
    {motto: settings.motto.category(category)}.to_json
  else
    status 404
    {ERROR: "Not Found category: #{category}"}.to_json
  end
end

get '/motto_categories' do
  headers site_headers
  {categories: settings.motto.categories_detail}.to_json
end


def site_headers
  {"Access-Control-Allow-Origin" => '*'}
end



