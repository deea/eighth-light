require_relative 'book.rb'
require_relative 'google_books_api'
require_relative 'books_list'

GBOOKS = GoogleBooksApi.new
BOOKS = BooksList.new(File.dirname(__FILE__) + '/books.json')

def ask_for_books
  puts "\n> What book would you like to add so that we can search for it?"
  keyword = gets.chomp
  books = GBOOKS.search_books(keyword)
  while books.nil?
    puts '> Enter a valid book title to look for'
    keyword = gets.chomp
    books = GBOOKS.search_books(keyword)
  end
  books
end

def list_books(books)
  books.each_with_index do |book, i|
    publisher = book.publisher != '' ? "(#{book.publisher})" : ''
    authors = book.authors != '' ? "by #{book.authors}" : ''
    puts "#{i + 1}. #{book.title} #{authors} #{publisher}"
  end
end

def google_results_display(books)
  puts "\n> Here are the book results:"
  list_books(books)
end

puts "\n"
puts '*' * 32
puts '*' + ' ' * 30 + '*'
puts '*  Welcome to your books List  *'
puts '*' + ' ' * 30 + '*'
puts '*' * 32

BOOKS.reset_books_list

action = ''

until action == 'q'
  puts "\n> l = list books"
  puts '> a = search and add book'
  puts '> q = quit'
  puts '> What would you like to do?'
  action = gets.chomp.downcase

  case action
  when 'l'
    books = BOOKS.load_books
    puts "\n> You currently have #{books.length} item(s) in your list"
    list_books(books)

  when 'a'
    books = ask_for_books
    google_results_display(books)
    puts "\n> Pick one to add to your list (give the number)"
    user_index = gets.chomp.to_i - 1
    book = books[user_index]
    BOOKS.add_book(book)
    puts "\n> Your book has been added"
  when 'q'
    puts "\n> Goodbye! \n"
  else
    puts '> I don\'t know what you mean'
  end
end
