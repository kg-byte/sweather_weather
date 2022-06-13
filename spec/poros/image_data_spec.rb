require 'rails_helper'

RSpec.describe ImageData do
  it 'exists and has attributes' do
    params = {
      "id": 2_706_750,
      "width": 6240,
      "height": 4160,
      "url": 'https://www.pexels.com/photo/union-station-building-2706750/',
      "photographer": 'Thomas Ward',
      "photographer_url": 'https://www.pexels.com/@thomasleeward',
      "photographer_id": 220_769,
      "avg_color": '#777272',
      "src": {
        "original": 'https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg',
        "large2x": 'https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
        "large": 'https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
        "medium": 'https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&h=350',
        "small": 'https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&h=130',
        "portrait": 'https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800',
        "landscape": 'https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200',
        "tiny": 'https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
      },
      "liked": false,
      "alt": 'Union Station Building'
    }

    image = ImageData.new(params, 'denver,co')

    expect(image).to be_a(ImageData)
    expect(image.author).to eq('Thomas Ward')
    expect(image.image_url).to eq('https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg')
    expect(image.source).to eq('https://www.pexels.com/photo/union-station-building-2706750/')
    expect(image.location).to eq('denver,co')
    expect(image.logo).to eq('https://images.pexels.com/lib/api/pexels.png')
  end
end
