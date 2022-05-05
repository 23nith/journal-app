require 'rails_helper'

RSpec.describe User, type: :model do
  it 'returns the name of the user' do
    # user = User.create(email: 'tester@email.com', password: 'password')
    user = build(:user, email: 'tester@email.com', password: 'password')

    expect(user.email).to eq 'tester@email.com'
  end
end
