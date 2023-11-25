# frozen_string_literal: true

require 'rails_helper'

describe LoginController, :vcr do
  describe 'LOGIN RENDER TESTS' do
    it 'redirects logged in users' do
      # simulate logged in when == 69
      session[:current_user_id] = 69
      get :login
      expect(response).to redirect_to(user_profile_path)
    end

    it 'renders the template to login if not logged in' do
      get :login
      expect(response).to render_template('login')
    end
  end

  describe 'LOGOUT TESTS' do
    it 'resets session data' do
      session[:current_user_id] = 69
      get :logout
      expect(session[:current_user_id]).to be_nil
    end

    it 'redirects on logout event' do
      get :logout
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'OAUTH TESTS' do
    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    end

    it 'generates a user from google oauth' do
      expect do
        get :google_oauth2
      end.to change(User, :count).by(1)
    end

    it 'generates a user from github oauth' do
      expect do
        get :github
      end.to change(User, :count).by(1)
    end
  end
end
