# frozen_string_literal: true

Given(/50 states exist/) do
  State.create!(
    name:         'California',
    symbol:       'CA',
    fips_code:    '06',
    is_territory: 0,
    lat_min:      '-124.409591',
    lat_max:      '-114.131211',
    long_min:     '32.534156',
    long_max:     '-114.131211'
  )
end

When(/I click "([^"]*)" on national map page/) do |string|
  visit "state/#{string}"
end

When(/^I click on county (.+)$/) do |county|
  visit search_representatives_path(county)
end