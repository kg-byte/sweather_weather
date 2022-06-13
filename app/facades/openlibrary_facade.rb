class OpenlibraryFacade
  def self.get_books(location, num)
    book_data = OpenlibraryService.get_books(location)
    books = book_data[:docs][0..num.to_i - 1].map { |data| Book.new(data) }
    { total_books_found: book_data[:numFound], books: books }
  end
end
