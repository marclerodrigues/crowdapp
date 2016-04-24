require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) {FactoryGirl.create(:category)}
  it 'has a valid factory' do
    expect(category).to be_valid
  end

  it 'is invalid without name' do
    category.name = nil
    expect(category).not_to be_valid
  end
end
