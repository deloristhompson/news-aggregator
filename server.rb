# need main page
# need articles page(has list of all articles)
# each article should show the description, title, and url
# when user clicks on the URL it should take them to the relevant page inside of a new tab
# need articles/new page(has a form to submit a new article)
# (form accepts title, url, and description)
# should be saved to a CSV file
require 'sinatra'
require 'csv'
require 'pry'

set :bind, '0.0.0.0'

get '/' do
  erb :index
end

get '/articles' do

    @complete_article = CSV.read("news_aggregator.csv") do |row|
     row
    end
    # binding.pry
erb :show
end


post "/articles/:article_name" do

  article_title = params["article_title"]
  description = params["description"]
  url = params["url"]

  article = []
  article << article_title
  article << description
  article << url

  CSV.open("news_aggregator.csv", "a") do |csv|
    csv.puts(article)

  end

  redirect "/articles"
end

get "/articles/new" do
  erb :articles
end

get "/articles/:article_name" do
  @article_name = params[:article_name]
  erb :articles
end
