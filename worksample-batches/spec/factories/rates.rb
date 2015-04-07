FactoryGirl.define do
  factory :rate, class: 'Rate' do
    mode EasyPost::ApiMode::TEST
    shipment
    user
    service "Priority Mail"
    rate_cents 500
  end
end
