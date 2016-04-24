FactoryGirl.define do
  factory :comment do
    title "First Comment"
    body "MyComment"
    user_id nil
    project_id nil
  end
end
