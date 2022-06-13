require 'rails_helper'

RSpec.describe User do 
  describe 'associations' do 
  	it { should have_many(:api_keys).dependent(:destroy)}
  end
end