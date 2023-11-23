# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

describe RepresentativesController, type: :request do
  before do
    mickey = {
      name:   'Mickey Mouse',
      street: '110th 1675 North Buena Vista Drive',
      city:   'The Magic Kingdom'
    }
    @mickey = Representative.create(mickey)
  end

  it 'loads the correct representative' do
    get '/representatives/1'
    expect(response).to render_template(:show)
    expect(response.body).to include('Mickey Mouse')
    expect(response.body).to include('110th 1675 North Buena Vista Drive')
    expect(response.body).to include('The Magic Kingdom')
  end
end
