# frozen_string_literal: true

require 'capybara/cucumber'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes/cucumber'
  config.allow_http_connections_when_no_cassette = false
  config.ignore_localhost = true
  config.hook_into :webmock
  config.filter_sensitive_data('<GOOGLE_CIVIC_API_KEY>') { Rails.application.credentials[:GOOGLE_API_KEY] }
  config.default_cassette_options = {
    record: :new_episodes
  }
end

Before do
  create(:representative)
end

Before('@vcr') do |scenario|
  name = scenario.name.gsub(/[^0-9A-Za-z_]/, '_')
  VCR.insert_cassette(name)
end

After('@vcr') do
  VCR.eject_cassette
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
  expect(page).to have_link('Gavin Newsom')
end

Then(/^I should be able to navigate to their page$/) do
  click_link('Gavin Newsom')
  gavin = Representative.find_by(name: 'Gavin Newsom')
  expect(page).to have_content(gavin.name)
  expect(page).to have_content(gavin.title)
  expect(page).to have_content(gavin.political_party)
end
