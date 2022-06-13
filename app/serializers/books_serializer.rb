class BooksSerializer 
  def self.format_books(weather, book_data, location)

  	{
  	   data: {
           id: nil,
         type: 'books',
   attributes: {
            destination: location,
               forecast: {
                        summary: weather.conditions,
                        temperature: weather.temperature.to_s + ' F'
                          },
      total_books_found: book_data[:total_books_found],
                  books: book_data[:books].map do |book|
                         {
                          isbn: book.isbn,
                         title: book.title,
                     publisher: book.publisher
                         }
                       end
  	           }
            }
    }
  end
end