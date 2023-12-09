# frozen_string_literal: true

Given(/^a rep "(.*?)" does exist in the database$/) do |name|
  Representative.find_or_create_by!(name: name)
end

Given(/^a rep "(.*?)" doesn't exist in the database$/) do |name|
  rep = Representative.where(name: name)
  rep.destroy_all
end

Then(/^I should see "(.*?)" in the list of reps$/) do |name|
  expect(page).to have_content(name)
end

Then(/^I should see the rep "(.*?)" in the database 1 time$/) do |name|
  expect(Representative.where(name: name).count).to eq(1)
end

# And (/^the rep with name "([^"]*)" should have the id "([^"]*)"$/) do |name, id|
# rep = Representative.find_by(name: name)
#
#  expect(rep).to be_present
#  expect(rep.index).to eq(id)
# end

Then(/^I should see the name "(.*?)"$/) do |name|
  expect(page).to have_content("Name: #{name}")
end

Then(/^I should see the political party "(.*?)"$/) do |pp|
  expect(page).to have_content("Political Party: #{pp}")
end

Then(/^I should see the rep "(.*?)" in the database$/) do |name|
  expect(Representative.where(name: name).count).to be_present
end

# possibly wrong path type:
When(/^I visit the reps page$/) do
  visit representatives_path
end

When(/^I add the rep "(.*?)"$/) do |name|
  name = OpenStruct.new(name: name)
  info = OpenStruct.new(officials: name, offices: ['somewhere'])

  Representative.civic_api_to_representative_params(info)
end
