FactoryGirl.define do
  factory :postage_label do
    rate
    user
    mode EasyPost::ApiMode::TEST
  end
end

