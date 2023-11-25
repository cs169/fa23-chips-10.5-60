# frozen_string_literal: true

require 'capybara/cucumber'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes/cucumber'
  config.allow_http_connections_when_no_cassette = true
  config.ignore_localhost = true
  config.hook_into :webmock
  config.filter_sensitive_data('<GOOGLE_CIVIC_API_KEY>') { Rails.application.credentials[:GOOGLE_API_KEY] }
  config.default_cassette_options = {
    record: :new_episodes
  }
end

Before do |scenario|
  VCR.turn_off!(ignore_cassettes: true) if scenario.source_tag_names.include?('@real_http')
end

After do |scenario|
  VCR.turn_on! if scenario.source_tag_names.include?('@real_http')
end

Given('I move to the California Page') do
  visit '/state/CA'
end

Given('I navigate to the Orange County page') do
  visit '/state/CA/county/059'
end

Given('I move to the Florida Page') do
  visit '/state/FL'
end

Given('I navigate to the Orange County representatives page') do
  visit '/representatives'
end

Then('I should see myself be on the Florida state page') do
  expect(page).to have_current_path('/state/FL')
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    expect(page).to have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    expect(page).to have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

When /^(?:|I )go to (.+)$/ do |page_name|
  VCR.use_cassette('civicinfo_api') do
    visit path_to(page_name)
  end
end
