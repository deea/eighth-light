require_relative '../../lib/book.rb'

RSpec.describe Book do
  describe 'instances' do
    it 'ensures book instance creation with correct attributes' do
      book = Book.new('Wind', 'James Patterson', 'Some publishing house')
      expect(book.title).to eq('Wind')
      expect(book.authors).to eq('James Patterson')
      expect(book.publisher).to eq('Some publishing house')
    end

    it 'adds books to users list' do
      Book.reset_books_list
      book = Book.new('Water', 'Bill Patterson', 'Some publishing house')
      Book.add_book(book)
      books = Book.load_books
      expect(books.length).to eq(1)
      expect(books[0].title).to eq('Water')
    end

    it 'adds additional books to users list without reseting it' do
      Book.reset_books_list
      book1 = Book.new('Water', 'Bill Patterson', 'Some publishing house')
      book2 = Book.new('Fire', 'John Patterson', 'Some publishing firm')
      Book.add_book(book1)
      Book.add_book(book2)
      books = Book.load_books
      expect(books.length).to eq(2)
    end

    it 'searches for a book on user input' do
      books1 = Book.search_books('winter')
      books2 = Book.search_books('ljhsdlkjfhwsrwlfj')
      expect(books1.length).to eq(5)
      expect(books2.nil?).to eq(true)
    end
  end
end
