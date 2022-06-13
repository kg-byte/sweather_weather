require 'rails_helper'

RSpec.describe ApiKey do 
   describe 'associations' do 
  	it { should belong_to(:bearer)}
  end
	
end