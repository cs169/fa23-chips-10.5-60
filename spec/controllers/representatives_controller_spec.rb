# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

describe RepresentativesController, type: :request do
  before do
    gavin = {
      name:            'Gavin Newsom',
      street:          '1303 10th Street',
      city:            'Sacramento',
      state:           'CA',
      zip:             '95814',
      political_party: 'Democratic Party',
      photo_url:       'http://www.ltg.ca.gov/images/newsimages/i2.png',
      title:           'Governor of California'
    }
    @gavin = Representative.create(gavin)
  end

  it 'loads the correct representative' do
    get '/representatives/1'
    expect(response).to render_template(:show)
  end
end
