# frozen_string_literal: true

Given /^there are representatives with names "([^"]*)" and "([^"]*)"$/ do |name1, name2|
  Representative.find_or_create_by!(name: name1)
  Representative.find_or_create_by!(name: name2)
end