# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

describe Representative, :vcr do
  it 'creates valid representatives from api responses' do
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: 'berkeley')
    reps = described_class.civic_api_to_representative_params(result)
    expect(reps).to_not be_nil
    expect(Representative.all.length).to_not be(0)
  end
end
