require 'rails_helper'

RSpec.describe OpenlibraryFacade do 
  it 'returns a hash of different type of weathers' do 
  	book_data = JSON.parse(File.read('spec/fixtures/openlibrary_response.json'), symbolize_names: true)
  	allow(OpenlibraryService).to receive(:get_books).and_return(book_data)
  	results = OpenlibraryFacade.get_books('denver,co', 5)

  	expect(results).to be_a(Hash)
  	expect(results[:total_books_found]).to be_a(Integer)
  	expect(results[:books]).to be_all(Book)
  	expect(results[:books].count).to eq(5)
  	results[:books].each do |book|
  		expect(book.isbn).to be_an(Array)
  		expect(book.publisher).to be_an(Array)
  		expect(book.title).to be_a(String)
  	end
  end 
end