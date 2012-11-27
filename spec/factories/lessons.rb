# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    duration "2012-11-23 17:55:57"
    start_at "2012-11-23 17:55:57"
    completed ""
    student nil
    teacher nil
  end
end
