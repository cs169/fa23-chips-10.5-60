# frozen_string_literal: true

require 'rails_helper'

describe MyEventsController, :vcr do
  before do
    User.create!(uid: '69', provider: 'google_oauth2')
    session[:current_user_id] = 1

    @event = instance_double(Event)
    allow(Event).to receive(:find).and_return(@event)
  end

  describe 'RENDER TEMPLATE TEST' do
    it 'handles a new event' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end

    it 'successfully renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'EDIT TEST' do
    it 'successfully renders the edit template' do
      get :edit, params: { id: 1 }
      expect(response).to render_template('edit')
    end
  end

  describe 'CREATE TESTS' do
    context 'with valid creation' do
      before do
        allow(Event).to receive(:new).and_return(@event)
        @event_attr = attributes_for(:event)
      end

      it 'successfully creates a new event' do
        allow(@event).to receive(:save).and_return(true)
        post :create, params: { event: @event_attr }
        expect(@event).to have_received(:save)
      end

      it 'redirects to the index page' do
        allow(@event).to receive(:save).and_return(true)
        post :create, params: { event: @event_attr }
        expect(response).to redirect_to(events_path)
      end
    end

    context 'with erroneous creation' do
      it 'redirects to new template' do
        allow(@event).to receive(:save).and_return(false)
        @event_attr = attributes_for(:event)
        post :create, params: { event: @event_attr }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'UPDATE TESTS' do
    context 'with valid update' do
      before do
        @event_attr = attributes_for(:event)
      end

      it 'successfully updates the event' do
        allow(@event).to receive(:update).and_return(true)
        put :update, params: { id: 69, event: @event_attr }
        expect(@event).to have_received(:update)
      end

      it 'redirects to the index page' do
        allow(@event).to receive(:update).and_return(true)
        put :update, params: { id: 69, event: @event_attr }
        expect(response).to redirect_to(events_path)
      end
    end

    context 'with erroneous update' do
      it 'redirects to edit template' do
        allow(@event).to receive(:update).and_return(false)
        @event_attr = attributes_for(:event)
        put :update, params: { id: 1, event: @event_attr }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE TESTS' do
    before do
      allow(@event).to receive(:destroy).and_return(true)
    end

    it 'successfully deletes the event' do
      delete :destroy, params: { id: 69 }
      expect(@event).to have_received(:destroy)
    end

    it 'redirects to the index page' do
      delete :destroy, params: { id: 69 }
      expect(response).to redirect_to(events_path)
    end
  end
end
