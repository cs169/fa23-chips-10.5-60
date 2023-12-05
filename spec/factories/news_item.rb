# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    sequence(:title) { |n| "Title ##{n}" }
    sequence(:link) { 'Example link' }
    description { 'This is an article.' }
    issue { 'Student Loans' }
    representative_id { FactoryBot.create(:representative).id }
  end
end
