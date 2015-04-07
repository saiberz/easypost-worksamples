FactoryGirl.define do
  factory :address, class: :address do
    mode :test
    user
  end

  factory :easy_post_address, parent: :address do
    name            "EasyPost"
    address_line_1  "118 2nd STREET"
    address_line_2  "4 FL"
    city            "SAN FRANCISCO"
    state           "CA"
    postal_code     "94105"
    phone           "415-123-4567"
  end

  factory :new_york_address, parent: :address do
    name            "George Costanza"
    address_line_1  "1 E 16th St."
    city            "BRONX"
    state           "NY"
    postal_code     "10451"
    phone           "(610) 937-4167"
  end

  factory :from_address, parent: :easy_post_address
  factory :to_address,   parent: :new_york_address

end

