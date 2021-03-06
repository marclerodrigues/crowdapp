require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:project) {FactoryGirl.create(:project, user: FactoryGirl.create(:user))}
  let(:user){FactoryGirl.create(:user, email: "blabla@gmail.com")}
  let(:comment) {FactoryGirl.create(:comment, project: project, user: user)}
  it 'has a valid factory' do
    expect(comment).to be_valid
  end

  it 'is invalid without title' do
    comment.title = nil
    expect(comment).not_to be_valid
  end

  it 'is invalid without body' do
    comment.body = nil
    expect(comment).not_to be_valid
  end
=begin
  it 'is invalid without project' do
    comment.project = nil
    expect(comment).not_to be_valid
  end

  it 'is invalid without user' do
    comment.user = nil
    expect(comment).not_to be_valid
  end
=end
end
