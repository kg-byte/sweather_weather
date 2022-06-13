class OpenlibraryFacade 
  def self.get_books(location, num)
  	book_data = OpenlibraryService.get_books(location)[:docs]
  	books = book_data[0..num-1].map {|data| Book.new(data)}
  end
end