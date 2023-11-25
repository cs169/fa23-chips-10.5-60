# frozen_string_literal: true

require 'rails_helper'

describe State do
  describe 'STATE FIPS TEST' do
    it 'builds a default state model with correct digits' do
      example_state = build(:state)
      expect(example_state.std_fips_code).to eq('69')
    end
  end
end
