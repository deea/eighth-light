require 'json'
require_relative './book'

# BooksList class
class BooksList
  attr_accessor :books

  def initialize(file_name)
    @file_name = file_name
    @books = load_books
  end

  def add_book(book)
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

  def write_json(json)
    File.open(@file_name, 'w') do |f|
      f.write JSON.pretty_generate(json)
    end
  end

  def load_books
    json = load_json
    json['books'].map do |book_json|
      Book.new(
        book_json['title'],
        book_json['authors'],
        book_json['publisher']
      )
    end
  end

  def load_json
    serialized_books = File.read(@file_name)
    JSON.parse(serialized_books)
  end

  def reset_books_list
    empty_list =
      {
        "books": []
      }
    write_json(empty_list)
  end
end
