require_relative '../../lib/google_books_api.rb'
require_relative '../../lib/book.rb'

RSpec.describe Book do
  describe 'instances' do
    it 'searches for a book on user input' do
      search_book = GoogleBooksApi.new
      books1 = search_book.search_books('winter')
      books2 = search_book.search_books('ljhsdlkjfhwsrwlfj')
      expect(books1.length).to eq(5)
      expect(books2.nil?).to eq(true)
    end
  end
end
