# frozen_string_literal: true

require 'capybara/cucumber'

@@gavin = {
  name:            'Gavin Newsom',
  street:          '1303 10th Street',
  city:            'Sacramento',
  state:           'CA',
  zip:             '95814',
  political_party: 'Democratic Party',
  photo_url:       'http://www.ltg.ca.gov/images/newsimages/i2.png',
  title:           'Governor of California'
}

Before do
  Representative.create(@@gavin)
end

Given(/^I am on a representatives page$/) do
  visit '/representatives/1'
end

Then(/^I should see the representatives (.*), and "([^"]+)"\.$/) do |content_list, last_item|
  content_list.split(/\s*,\s*/).each do |content|
    page.should have_content(@@gavin[content[1..-2]])
  end
  page.should have_content(@@gavin[last_item])
end
