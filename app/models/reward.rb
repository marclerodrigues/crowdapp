class Reward < ActiveRecord::Base
  validates :name, :value, presence: true
  belongs_to :project
end
