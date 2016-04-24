class Project < ActiveRecord::Base
  validates :name, :user, :goal, presence: true
  belongs_to :user
  has_one :category
end
