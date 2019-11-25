require_relative '../../lib/books_list.rb'
require_relative '../../lib/book.rb'

RSpec.describe BooksList do
  describe 'instances' do
    it 'adds books to users list' do
      books = BooksList.new(File.dirname(__FILE__) + '/test_books.json')
      books.reset_books_list
      book = Book.new('Water', 'Bill Patterson', 'Some publishing house')
      books.add_book(book)
      books_list = books.load_books
      expect(books_list.length).to eq(1)
      expect(books_list[0].title).to eq('Water')
    end
    it 'adds additional books to users list without reseting it' do
      books = BooksList.new(File.dirname(__FILE__) + '/test_books.json')
      books.reset_books_list
      book1 = Book.new('Water', 'Bill Patterson', 'Some publishing house')
      book2 = Book.new('Fire', 'John Patterson', 'Some publishing firm')
      books.add_book(book1)
      books.add_book(book2)
      books_list = books.load_books
      expect(books_list.length).to eq(2)
    end
  end
end
