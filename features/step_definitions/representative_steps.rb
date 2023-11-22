# frozen_string_literal: true

require 'capybara/cucumber'

Before do
  gavin = {
    name:            'Gavin Newsom',
    street:          '1303 10th Street',
    city:            'Sacramento',
    state:           'CA',
    zip:             '95814',
    political_party: 'Democratic Party',
    photo_url:       'http://www.ltg.ca.gov/images/newsimages/i2.png',
    title:           'Governor of California'
  }
  Representative.create(gavin)
end

Given(/^I am on a representatives page$/) do
  visit '/representatives/1'
end

Given(/^I am on a the search page$/) do
  visit '/search/berkeley'
end

Given(/^I am on a the news feed for a particular representative$/) do
  visit '/representatives/1/news_items'
end

Given(/^I see a representatives name$/) do
  expect(page).to have_content('Gavin Newsom')
end

Then(/^I should see the representatives (.*) and "([^"]+)"\.$/) do |content_list, last_item|
  gavin = Representative.find_by(name: 'Gavin Newsom')
  content_list.split(/\s*,\s*/).each do |content|
    unquoted = content.gsub!(/"/, '|')
    expect(page).to have_content(gavin.public_send(unquoted.parameterize.underscore.to_sym))
  end
  expect(page).to have_content(gavin.public_send(last_item.parameterize.underscore.to_sym))
end

Then(/^I should see a link to their page$/) do
  expect(page).to have_link('Gavin Newsom', href: '/representatives/1')
end

Then(/^I should be able to navigate to their page$/) do
  click_link('Gavin Newsom')
  expect(page).to have_current_path('/representatives/1')
  expect(page).to have_content('Gavin Newsom')
end
