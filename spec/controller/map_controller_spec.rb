# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe MapController, type: :controller do
  before do
    @state = State.create!(name: 'Arizona', symbol: 'AZ', fips_code: 10, is_territory: 0, lat_min: 4, lat_max: 20,
                           long_min: 6, long_max: 9)

    @county = County.create(name: 'Yuma County', fips_code: 2)
  end

  describe 'INDEX' do
    it 'returns a successful response' do
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:states)).to eq([@state])
      expect(assigns(:states_by_fips_code)).not_to be_nil
    end

    it 'assigns states and fips_code' do
      get :index
      expect(assigns(:states)).to eq([@state])
      expect(assigns(:states_by_fips_code)).to eq({ @state.std_fips_code => @state })
    end
  end

  describe 'STATE' do
    it 'returns a successful response' do
      get :state, params: { state_symbol: @state.symbol }
      expect(response).to render_template(:state)
    end

    it 'assigns state and county_details' do
      get :state, params: { state_symbol: @state.symbol }
      expect(assigns(:state)).to eq(@state)
      expect(assigns(:county_details)).to eq(@state.counties.index_by(&:std_fips_code))
    end

    context 'handle_state_not_found method --> state does not exist test' do
      it 'redirects with an alert' do
        get :state, params: { state_symbol: 'invalid' }
        expect(response).to redirect_to(root_path)
        # whats up.. case (lol)
        expect(flash[:alert]).to eq("State 'INVALID' not found.")
      end
    end
  end

  describe 'COUNTY' do
    # it 'correctly redirects the user' do
    #  get :county, params: { state_symbol: @state.symbol, std_fips_code: @county.fips_code }
    #  expect(response).to render_template(search_representatives_path(address: @county.name))
    # end

    context 'handle_county_not_found method --> county does not exist' do
      it 'redirects with an alert' do
        get :county, params: { state_symbol: @state.symbol, std_fips_code: '2024' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("County with code '2024' not found for #{@state.symbol}")
      end
    end
  end
end
