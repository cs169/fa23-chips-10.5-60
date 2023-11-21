# frozen_string_literal: true

require 'capybara'
require 'rspec'

When('/^I visit a representatives page$/') do
  visit '/representatives/1'
end

Then(/^I should see the representatives (.*,)+ and (.*)\.$/) do |elements|
  page.should have_content(elements)
end
