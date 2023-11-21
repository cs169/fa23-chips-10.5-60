# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []
    rep_info.offices.each do |office|
      office.official_indices.each do |rep_idx|
        rep = get_rep_from_official(rep_info.officials[rep_idx], office)
        reps.push(rep)
      end
    end
    reps
  end

  def self.get_rep_from_official(official, office)
    address = official&.address
    rep_attrs = {
    title:           office&.division_id || '',
    ocdid:           office&.division_id || '',

    name:            official&.name || '',
    political_party: official&.party || '',

    street:          address&.[](0)&.line1 || '',
    city:            address&.[](0)&.city || '',
    state:           address&.[](0)&.state || '',
    zip:             address&.[](0)&.zip || '',

    photo_url:       official&.photo_url || ''
    }
    Representative.find_or_create_by(rep_attrs)
  end

end
