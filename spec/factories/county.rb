# frozen_string_literal: true

FactoryBot.define do
  factory :county do
    name { 'Alameda' }
    fips_code { 69 }
    fips_class { 69 }
  end
end
