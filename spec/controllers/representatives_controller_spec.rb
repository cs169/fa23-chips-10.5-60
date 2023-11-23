# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

describe RepresentativesController, type: :request do
  before do
    mickey = {
      name:            'Mickey Mouse',
      street:          '110th 1675 North Buena Vista Drive',
      city:            'The Magic Kingdom',
      state:           'FL',
      zip:             '32830',
      political_party: 'Republican Party',
      photo_url:       'https://upload.wikimedia.org/wikipedia/en/d/d4/Mickey_Mouse.png?20220210025314',
      title:           'Mouse'
    }
    @mickey = Representative.create(mickey)
  end

  it 'loads the correct representative' do
    get '/representatives/1'
    expect(response).to render_template(:show)
    expect(response.body).to include('Mickey Mouse')
  end
end
