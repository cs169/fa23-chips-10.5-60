# frozen_string_literal: true

require 'rails_helper'

describe MapController, :vcr do
  describe 'COUNTRY MAP TESTS' do
    before do
      @jefferson = instance_double(State)
      allow(@jefferson).to receive(:std_fips_code).and_return(51)
      @puertorico = instance_double(State)
      allow(@puertorico).to receive(:std_fips_code).and_return(52)

      @states = [@jefferson, @puertorico]
      @indexed_states = { 51 => @jefferson, 52 => @puertorico }
    end

    it 'initializes variables locally' do
      allow(State).to receive(:all).and_return(@states)
      get :index
      expect(assigns(:states)).to eq(@states)

      expect(assigns(:states_by_fips_code)).to eq @indexed_states
      expect(State).to have_received(:all)
    end

    it 'renders an indexed template' do
      get :index
      expect(response).to render_template('index')
    end
  end

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

  describe 'COUNTY MAP TESTS' do
    # SETUP VARS
    let(:state_symbol) { 'WA' }

    let(:state) { instance_double(State, id: 69, counties: counties) }
    let(:county) { instance_double(County, name: 'Pierce County') }
    let(:counties) { instance_double(Array) }
    let(:representatives) { instance_double(Array) }

    before do
      allow(State).to receive(:find_by).with(symbol: state_symbol).and_return(state)
      allow(counties).to receive(:index_by).and_return('county_details')
      allow(Representative).to receive(:find).with(county.name).and_return(representatives)
    end

    context 'when state is found' do
      before do
        allow(controller).to receive(:get_requested_county).with(state.id).and_return(county)
        get :county, params: { state_symbol: state_symbol, std_fips_code: 69 }
      end

      it 'assigns @state' do
        expect(assigns(:state)).to eq(state)
      end

      it 'assigns @county' do
        expect(assigns(:county)).to eq(county)
      end

      it 'assigns @county_details' do
        expect(assigns(:county_details)).to eq('county_details')
      end
    end

    context 'when state is not found' do
      before do
        allow(State).to receive(:find_by).with(symbol: state_symbol).and_return(nil)
        get :county, params: { state_symbol: state_symbol, std_fips_code: 69 }
      end

      it 'handles state not found' do
        expect(assigns(:state)).to be_nil
      end
    end

    context 'when county is not found' do
      before do
        allow(controller).to receive(:get_requested_county).with(state.id).and_return(nil)
        get :county, params: { state_symbol: state_symbol, std_fips_code: 69 }
      end

      it 'handles county not found' do
        expect(assigns(:county)).to be_nil
      end
    end
  end
end
