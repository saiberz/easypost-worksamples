FactoryGirl.define do
  factory :shipment do
    mode :test
    sequence(:tracking_code) { |n| "000#{n}" }
    to_address
    from_address
    parcel
    user

    trait :production do
      mode :production
    end
    factory :shipment_production, traits: [:production]

    factory :shipment_purchased do
      postage_label
      selected_rate { create :rate }
      tracking_code { "EZ000001" }
    end

    factory :shipment_with_rates do
      rates { build_list :rate, 1 }
    end
  end

end

