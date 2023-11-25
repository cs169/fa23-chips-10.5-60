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

  # This will create duplicates if the reps info changes
  # At a later date this could be modified to update information
  # if necessary.
  def self.get_rep_from_official(official, office)
    address = official&.address
    rep_attrs = {
      title:           safe_access(office, :name),
      ocdid:           safe_access(office, :division_id),
      name:            safe_access(official, :name),
      political_party: safe_access(official, :party),
      street:          safe_list_access(address, :line1),
      city:            safe_list_access(address, :city),
      state:           safe_list_access(address, :state),
      zip:             safe_list_access(address, :zip),
      photo_url:       safe_access(official, :photo_url)
    }
    Representative.find_or_create_by(rep_attrs)
  end

  def self.safe_access(object, attr)
    object&.public_send(attr) || ''
  end

  def self.safe_list_access(object, attr)
    object&.[](0)&.public_send(attr) || ''
  end
end
