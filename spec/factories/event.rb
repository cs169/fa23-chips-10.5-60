# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    county_id { 69 }
    start_time { 69.days.from_now }
    end_time { 70.days.from_now }
    name { 'Harvest Festival' }
    description { 'Celebration' }
  end
end
