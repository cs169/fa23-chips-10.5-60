# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

describe Representative, :vcr do
  it 'creates valid representatives from api responses' do
    result = google_api_request('berkeley')
    reps = described_class.civic_api_to_representative_params(result)
    expect(reps).not_to be_nil
    expect(described_class.all.length).not_to be(0)
  end
end

def google_api_request(address)
  service = Google::Apis::CivicinfoV2::CivicInfoService.new
  service.key = Rails.application.credentials[:GOOGLE_API_KEY]
  service.representative_info_by_address(address: address)
end
