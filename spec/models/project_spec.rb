require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) {FactoryGirl.create(:user)}
  let(:project) {FactoryGirl.create(:project, user: user)}

  it 'has a valid factory' do
    expect(project).to be_valid
  end

  it 'is invalid without name' do
    project.name = nil
    expect(project).not_to be_valid
  end

  it 'is invalid without a user' do
    project.name = "Project"
    project.user = nil
    expect(project).not_to be_valid
  end

  it 'is invalid without a goal' do
    project.goal = nil
    expect(project).not_to be_valid
  end
end
