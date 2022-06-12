require 'rails_helper'

RSpec.describe ImagesFacade do 
  it 'returns an ImageData object' do 
  	data = JSON.parse(File.read('spec/fixtures/images_response.json'), symbolize_names: true)
  	
  	allow(ImagesService).to receive(:get_image).and_return(data)
  	image = ImagesFacade.get_image('denver,co')
  	
    expect(image).to be_a(ImageData)
  	expect(image.author).to eq("Thomas Ward")
    expect(image.image_url).to eq("https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg")
    expect(image.source).to eq("https://www.pexels.com/photo/union-station-building-2706750/")
    expect(image.location).to eq("denver,co")
    expect(image.logo).to eq("https://images.pexels.com/lib/api/pexels.png")

  end
end