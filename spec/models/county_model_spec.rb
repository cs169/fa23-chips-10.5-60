# frozen_string_literal: true

require 'rails_helper'

describe County do
  describe 'COUNTY FIPS TEST' do
    it 'builds a default county model with correct digits' do
      example_county = build(:county)
      expect(example_county.std_fips_code).to eq('069')
    end
  end
end
