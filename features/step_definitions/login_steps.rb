# frozen_string_literal: true

require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'selectors'))

# When(/^Signed in with (.+)$/) do |provider|
#   OmniAuth.config.test_mode = true

#   user = {
#     'info'     => {
#       'name'  => 'John Smith',
#       'email' => 'john@gmail.com'
#     },
#     'uid'      => '66',
#     'provider' => ''
#   }
#   case provider
#   when 'Google'
#     user[:provider] = 'google_oauth2'
#   when 'Github'
#     user[:provider] = 'github'
#   end
#   OmniAuth.config.mock_auth[user[:provider].to_sym] = user
#   click_button('Sign in with #{user[:provider]}')
# end

When 'I am logged into Github' do
  User.create(uid: '11', provider: 'github', first_name: 'John', last_name: 'Smith', email: 'john@gmail.com')
end

Then 'I should see {string} as the auth provider' do |provider|
  name = provider == 'Google' ? 'Google Test User' : 'GitHub Test User'
  expect(page).to have_content(name)
end

When 'I click on {string}' do |link_name|
  click_link_or_button link_name
end

Then 'I should be redirected to the home page' do
  expect(page).to have_current_path('/')
end
