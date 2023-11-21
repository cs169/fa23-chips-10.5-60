# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      #checks for existing rep in Representative, creates new one if doesn't exist
      already_existing_rep = Representative.find_by(title:title_temp, ocdid: ocdid_temp)
      if !already_existing_rep
        rep = Representative.create!({ name: official.name, ocdid: ocdid_temp, title: title_temp })
        reps.push(rep)
      else
        reps.push(already_existing_rep)
    end

    reps
  end
end
