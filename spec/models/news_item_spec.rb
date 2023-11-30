# frozen_string_literal: true

require 'rails_helper'

describe NewsItem do
  describe 'find news items for given rep' do
    let(:representative) { create(:representative) }
    let(:news_item) { create(:news_item, link: 'google.com/news', issue: 'Student Loans', representative: representative) }

    it 'returns news for a given rep' do
      news_item
      expect(described_class.find_for(representative.id).title).to eq('Title #1')
    end
  end
end
