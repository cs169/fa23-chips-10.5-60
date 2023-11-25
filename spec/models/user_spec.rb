# frozen_string_literal: true

require 'rails_helper'

describe User do
  before do
    @google = described_class.create(uid: '69', first_name: 'Peter', last_name: 'Griffin', provider: 'google_oauth2')
    @github = described_class.create(uid: '70', first_name: 'Brian', last_name: 'Griffin', provider: 'github')
  end

  it 'returns the name of a google user' do
    expect(@google.name).to eq('Peter Griffin')
  end

  it 'returns Google as oauth provider' do
    expect(@google.auth_provider).to eq('Google')
  end

  it 'finds a Google user from uid' do
    found = described_class.find_google_user('69')
    expect(found.name).to eq(@google.name)
  end

  it 'returns the name of a github user' do
    expect(@github.name).to eq('Brian Griffin')
  end

  it 'returns Github as oauth provider' do
    expect(@github.auth_provider).to eq('Github')
  end

  it 'finds a Github user from uid' do
    found = described_class.find_github_user('70')
    expect(found.name).to eq(@github.name)
  end
end
