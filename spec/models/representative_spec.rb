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

  describe '.civic_api_to_representative_params' do
    before do
      george = {
        title:           'President',
        ocdid:           'id1',
        name:            'George Washington',
        political_party: '',
        street:          '',
        city:            '',
        state:           '',
        zip:             '',
        photo_url:       ''
      }
      described_class.find_or_create_by(george)
    end

    let(:rep_info) do
      temp_offices = [OpenStruct.new({ name: 'President', division_id: 'id1', official_indices: [0] }),
                      OpenStruct.new({ name: 'VP', division_id: 'id2', official_indices: [1] })]
      temp_officials = [OpenStruct.new({ name: 'George Washington' }), OpenStruct.new({ name: 'Kamala Harris' })]
      OpenStruct.new({ officials: temp_officials, offices: temp_offices })
    end

    context 'when the official already exists' do
      it 'will not create a duplicate rep' do
        expect { described_class.civic_api_to_representative_params(rep_info) }
          .to change(described_class, :count).by(1)
      end
    end
  end
end

def google_api_request(address)
  service = Google::Apis::CivicinfoV2::CivicInfoService.new
  service.key = Rails.application.credentials[:GOOGLE_API_KEY]
  service.representative_info_by_address(address: address)
end
