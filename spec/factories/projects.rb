FactoryGirl.define do
  factory :project do
    name "Project"
    description "Project"
    goal "999.99"
    image "goal.jpg"
    video "youtube.com"
    expiration_data "2016-04-11 22:23:23"
    user nil
  end
end
