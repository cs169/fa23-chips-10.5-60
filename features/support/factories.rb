# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :representative do
    id { 1 }
    name { 'Gavin Newsom' }
    street { '1303 10th Street' }
    city { 'Sacramento' }
    state { 'CA' }
    zip { '95814' }
    political_party { 'Democratic Party' }
    photo_url { 'http://www.ltg.ca.gov/images/newsimages/i2.png' }
    title { 'Governor of California' }

    after(:create) do |representative|
      create_list(:news_item, 1, representative: representative)
    end
  end

  factory :news_item do
    title { "Newsom warns that young adults are not 'invincible' to Coronavirus" }
    description { 'Gavin Newsom says things about stuff' }
    link do
      'https://www.latimes.com/california/story/2020-07-06/' \
        'young-adult-who-think-they-are-invincible-hit-hard-' \
        'by-coronavirus-newsom-says'
    end
  end
end
