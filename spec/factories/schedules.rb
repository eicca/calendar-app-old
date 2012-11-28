# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    teacher nil
    title "MyString"
    start_at "2012-11-28 18:39:37"
    end_at "2012-11-28 18:39:37"
    recurring false
  end
end
