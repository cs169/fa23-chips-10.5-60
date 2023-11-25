# frozen_string_literal: true

require 'rails_helper'

describe MapController, :vcr do
  describe 'STATE MAP TESTS' do
    before do
      @alameda = instance_double(County)
      allow(@alameda).to receive(:std_fips_code).and_return(69)
      @pierce = instance_double(County)
      allow(@pierce).to receive(:std_fips_code).and_return(70)

      @counties = [@alameda, @pierce]
      @indexed_counties = { 69 => @alameda, 70 => @pierce }
      @california = instance_double(State)
      allow(@california).to receive(:counties).and_return(@counties)
    end

    it 'redirects if given a nonexistent state' do
      allow(State).to receive(:find_by).with(symbol: 'XD').and_return(nil)
      get :state, params: { state_symbol: 'XD' }
      expect(assigns(:state)).to be_nil
      expect(response).to redirect_to root_path
    end

    context 'when fetching a real state' do
      before do
        allow(State).to receive(:find_by).with(symbol: 'CA').and_return(@california)
      end

      it 'initializes variables locally' do
        get :state, params: { state_symbol: 'CA' }
        expect(assigns(:state)).to eq(@california)
        expect(assigns(:county_details)).to eq(@indexed_counties)
        expect(State).to have_received(:find_by).with(symbol: 'CA')
        expect(@california).to have_received(:counties)
      end

      it 'renders an indexed template' do
        get :state, params: { state_symbol: 'CA' }
        expect(response).to render_template('state')
        expect(State).to have_received(:find_by).with(symbol: 'CA')
        expect(@california).to have_received(:counties)
      end
    end
  end
end
