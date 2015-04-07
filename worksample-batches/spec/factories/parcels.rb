FactoryGirl.define do
  factory :parcel do
    mode :test
    weight 12.0
    user

    factory :dimensioned_parcel do
      height 8.0
      width 6.5
      length 12.0
      predefined_package "PARCEL"
    end

    factory :dimensioned_letter do
      height 8.0
      width 6.5
      length 12.0
      predefined_package "LETTER"
    end

    factory :small_parcel do
      height 6.0
      width 4.0
      length 10.0
      predefined_package "SMALLPARCEL"
    end

    factory :letter do
      predefined_package "LETTER"
    end

    factory :heavy_parcel do
      weight 32.0
    end
  end

end

