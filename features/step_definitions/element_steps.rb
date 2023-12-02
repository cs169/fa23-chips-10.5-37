# frozen_string_literal: true

# step defs for elements within the pages

require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'selectors'))

Then(/^the table should have (\d+) rows$/) do |expected_rows|
  within('table') do
    rows = all('tbody tr').count
    expect(rows).to eq(expected_rows.to_i)
  end
end

