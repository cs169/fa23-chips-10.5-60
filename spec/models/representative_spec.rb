# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

describe Representative, :vcr do
  it 'check vcr works' do
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: 'berkeley')
    reps = Representative.civic_api_to_representative_params(result)
    reps.each { |rep|  puts rep.to_yaml }
  end
end

