# frozen_string_literal: true

FactoryBot.define do
  factory :representative do
    name { 'John Cena' }
    ocdid { '69' }
    title { 'Wrestler' }
  end
end
