require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    before do
      described_class.find_or_create_by(name: 'George Washington', ocdid: 'id1', title: 'President')
    end

    let(:rep_info) do
      temp_offices = [OpenStruct.new({ name: 'President', division_id: 'id1', official_indices: [0] }),
                      OpenStruct.new({ name: 'VP', division_id: 'id2', official_indices: [1] })]
      temp_officials = [OpenStruct.new({ name: 'George Washington' }), OpenStruct.new({ name: 'Kamala Harris' })]
      OpenStruct.new({ officials: temp_officials, offices: temp_offices })
    end

    context 'when the official already exists' do
      it 'will not create a duplicate rep' do
        expect { Representative.civic_api_to_representative_params(rep_info) }
          .to change(described_class, :count).by(1)
      end
    end
  end
end
