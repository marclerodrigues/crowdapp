require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.build(:user)}
  it 'has a valid factory' do
    expect(user).to be_valid
  end

  it 'is invalid without email' do
    user.email = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without password' do
    user.password = nil
    user.encrypted_password = nil
    expect(user).not_to be_valid
  end
end
