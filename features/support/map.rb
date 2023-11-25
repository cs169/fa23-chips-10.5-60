# frozen_string_literal: true

FactoryBot.define do
  factory :county do
    name { 'Orange' }
    fips_code { 59 }
    fips_class { 59 }
  end

  factory :state do
    name { 'California' }
    symbol { 'CA' }
    is_territory { 1 }
    lat_min { 1 }
    lat_max { 1 }
    long_min { 1 }
    long_max { 1 }
    fips_code { 69 }
  end
end
