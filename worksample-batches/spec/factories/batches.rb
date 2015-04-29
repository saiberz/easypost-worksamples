FactoryGirl.define do
  factory :batch do
    mode :test
    user
    state :created
  end
end

