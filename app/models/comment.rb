class Comment < ActiveRecord::Base
  validates :title, :body, presence: true
  belongs_to :user
  belongs_to :project
end
