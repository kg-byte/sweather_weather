require 'rails_helper'

RSpec.describe ImagesService do
  it 'returns image data', :vcr do
    data = ImagesService.get_image('denver')

    expect(data).to be_a(Hash)
    expect(data[:page]).to eq(1)
    expect(data[:total_results]).to eq(72)
    expect(data[:photos]).to be_an(Array)
    data[:photos].each do |photo|
      expect(photo[:id]).to be_an(Integer)
      expect(photo[:url]).to be_a(String)
      expect(photo[:photographer]).to be_a(String)
      expect(photo[:src]).to be_a(Hash)
      expect(photo[:src][:original]).to be_a(String)
    end
  end
end
