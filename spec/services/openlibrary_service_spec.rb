require 'rails_helper'

RSpec.describe OpenlibraryService, :vcr do
  it 'returns books based on location' do
    data = OpenlibraryService.get_books('denver, co')

    expect(data).to be_a(Hash)
    expect(data[:numFound]).to be_an(Integer)
    expect(data[:docs]).to be_an(Array)
    expect(data[:docs][0][:title]).to eq('Denver, Co')
    expect(data[:docs][0][:isbn]).to eq(%w[9780762507849 0762507845])
    expect(data[:docs][0][:publisher]).to eq(['Universal Map Enterprises'])
  end
end
