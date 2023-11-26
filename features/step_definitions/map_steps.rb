# frozen_string_literal: true

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

Before('@vcr') do |scenario|
  name = scenario.name.gsub(/[^ ]/, '_')
  VCR.insert_cassette(name)
end

After('@vcr') do
  VCR.eject_cassette
end

Before do
  Rails.application.load_seed
end

Given('I move to the California Page') do
  visit '/state/CA'
end

Then(/^I navigate to the "([^"]+)" page$/) do |county|
  county = county.gsub(' ', '_')
  within_table('actionmap-state-counties-table') do
    find("a##{county}").click
  end
end

def finished_jquery_requests?
  evaluate_script '(typeof jQuery === "undefined") || (jQuery.active == 0)'
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
  expect(page).to have_content(text)
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  expect(page).to_not have_content(text)
end
