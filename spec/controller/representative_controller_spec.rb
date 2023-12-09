# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'checking index and show functionality:' do
    context 'SHOW' do
      #  let(:rep) { instance_double(Representative, id: 1) }
      #
      # it 'returns a successful response' do
      #  rep = Representative.create(name: 'Polly Pocket', title: 'Doll')
      #  get :show, params: { id: rep.id }
      #  expect(response).to render_template(:show)
      #  expect(assigns(:rep)).to eq(rep)
      #  expect(response).to be_successful
      # end

      it 'returns prompt if rep is nil' do
        get :show, params: { id: 'nil' }
        expect(response).to redirect_to(representatives_path)
        expect(flash[:alert]).to eq('Sorry, Representative Not Found!')
      end
    end

    context 'INDEX' do
      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
      
      #it 'returns a successful response' do
      #  get :index
      #  expect(response).to be_successful
      #end
    end
  end
end
