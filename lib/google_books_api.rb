require 'net/http'
require 'json'
require 'open-uri'
require_relative './book'

# GoogleBooksApi class
class GoogleBooksApi
  def search_books(keyword)
    json = query_google(keyword)
    if json.key?('items')
      json['items'].first(5).map do |item|
        authors = item['volumeInfo']['authors'] ? item['volumeInfo']['authors'].join(', ') : ''
        Book.new(
          item['volumeInfo']['title'],
          authors,
          item['volumeInfo']['publisher']
        )
      end
    end
  end

  def query_google(keyword)
    url = "https://www.googleapis.com/books/v1/volumes?q=#{keyword}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
