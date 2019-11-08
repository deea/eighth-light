require 'net/http'
require 'json'
require 'open-uri'

# Book class
class Book
  FILE_PATH = File.dirname(__FILE__) + '/books.json'

  attr_reader :title, :authors, :publisher
  def initialize(title, authors, publisher)
    @title = title
    @authors = authors
    @publisher = publisher
  end

  def self.add_book(book)
    book =
      {
        "title": book.title.to_s,
        "authors": book.authors.to_s,
        "publisher": book.publisher.to_s
      }
    json = load_json
    json['books'] << book
    write_json(json)
  end

  def self.write_json(json)
    File.open(FILE_PATH, 'w') do |f|
      f.write JSON.pretty_generate(json)
    end
  end

  def self.load_books
    json = load_json
    json['books'].map do |book_json|
      Book.new(
        book_json['title'],
        book_json['authors'],
        book_json['publisher']
      )
    end
  end

  def self.search_books(keyword)
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

  def self.load_json
    serialized_books = File.read(FILE_PATH)
    JSON.parse(serialized_books)
  end

  def self.query_google(keyword)
    url = "https://www.googleapis.com/books/v1/volumes?q=#{keyword}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.reset_books_list
    empty_list =
      {
        "books": [

        ]
      }
    write_json(empty_list)
  end
end
