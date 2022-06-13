require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:api_keys).dependent(:destroy) }
  end
  describe 'validations' do
    subject { User.create(email: 'sample@email.com', password: 'abc') }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password }
  end
end
