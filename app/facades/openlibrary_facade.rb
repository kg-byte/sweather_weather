class OpenlibraryFacade
  class << self
    def get_books(location, num)
      { total_books_found: num_found(location), books: books(location, num) }
    end

    private

    def book_data(location)
      data ||= OpenlibraryService.get_books(location)
    end

    def books(location, num)
      book_data(location)[:docs][0..num.to_i - 1].map { |data| Book.new(data) }
    end

    def num_found(location)
      book_data(location)[:numFound]
    end
  end
end
