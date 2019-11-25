require_relative '../../lib/book.rb'

RSpec.describe Book do
  describe 'instances' do
    it 'ensures book instance creation with correct attributes' do
      book = Book.new('Wind', 'James Patterson', 'Some publishing house')
      expect(book.title).to eq('Wind')
      expect(book.authors).to eq('James Patterson')
      expect(book.publisher).to eq('Some publishing house')
    end
  end
end
