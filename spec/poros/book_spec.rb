require 'rails_helper'

RSpec.describe Book do
  it 'exists and has attributes' do
    params = {
      "key": '/works/OL8503198W',
      "type": 'work',
      "seed": [
        '/books/OL10909613M',
        '/works/OL8503198W',
        '/authors/OL2843451A'
      ],
      "title": 'Denver, Co',
      "title_suggest": 'Denver, Co',
      "has_fulltext": false,
      "edition_count": 1,
      "edition_key": [
        'OL10909613M'
      ],
      "publish_date": [
        'January 2001'
      ],
      "publish_year": [
        2001
      ],
      "first_publish_year": 2001,
      "isbn": %w[
        9780762507849
        0762507845
      ],
      "last_modified_i": 1_338_943_517,
      "ebook_count_i": 0,
      "publisher": [
        'Universal Map Enterprises'
      ],
      "language": [
        'eng'
      ],
      "author_key": [
        'OL2843451A'
      ],
      "author_name": [
        'Universal Map'
      ],
      "publisher_facet": [
        'Universal Map Enterprises'
      ],
      "_version_": 1_715_096_877_364_412_420,
      "author_facet": [
        'OL2843451A Universal Map'
      ]
    }

    book = Book.new(params)
    expect(book).to be_a(Book)
    expect(book.isbn).to eq(%w[9780762507849 0762507845])
    expect(book.title).to eq('Denver, Co')
    expect(book.publisher).to eq(['Universal Map Enterprises'])
  end
end
