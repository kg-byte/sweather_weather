require 'rails_helper'

RSpec.describe ImpossibleRoute do 

  it 'exists and has attributes' do 
  	impossible_route = ImpossibleRoute.new('london,uk', 'denver,co')

  	expect(impossible_route).to be_a(ImpossibleRoute)
  	expect(impossible_route.start_city).to eq('london,uk')
  	expect(impossible_route.end_city).to eq('denver,co')
  	expect(impossible_route.travel_time).to eq('impossible route')
  end
end