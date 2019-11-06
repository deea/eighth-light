require 'json'
require 'open-uri'
require_relative 'book.rb'

def ask_for_books
  puts "\n> What book title would you like to add so that we can search for it?"
  keyword = gets.chomp
  books = Book.search_books(keyword)
  while books.nil?
    puts '> Enter a valid book title to look for'
    keyword = gets.chomp
    books = Book.search_books(keyword)
  end
  books
end

def existing_list_display(books)
  books.each_with_index do |book, position|
    puts "#{position + 1}. #{book.title}, #{book.authors} - #{book.publisher}"
  end
end

def google_results_display(books)
  puts "\n> Here are the book results:"
  books.each_with_index do |book, i|
    publisher = book.publisher ? "(#{book.publisher})" : ''
    puts "#{i + 1}. #{book.title} by #{book.authors} #{publisher}"
  end
end

puts "\n"
puts '*' * 32
puts '*' + ' ' * 30 + '*'
puts '*  Welcome to your books List  *'
puts '*' + ' ' * 30 + '*'
puts '*' * 32

action = ''

until action == 'q'
  puts "\n> You can list your books by typing l"
  puts '> add a book through searching for one by typing a'
  puts '> or quit by typing q'
  puts '> What would you like to do?'
  action = gets.chomp.downcase

  case action
  when 'l'
    books = Book.load_books
    puts "\n> You currently have #{books.length} item(s) in your list"
    existing_list_display(books)

  when 'a'
    books = ask_for_books
    google_results_display(books)
    puts "\n> Pick one to add to your list (give the number)"
    user_index = gets.chomp.to_i - 1
    book = books[user_index]
    Book.add_book(book)
    puts "\n> Your book has been added"
  when 'q'
    puts "\n> Goodbye! \n"
  else
    puts '> I don\'t know what you mean'
  end
end
