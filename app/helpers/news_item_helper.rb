# frozen_string_literal: true

module NewsItemHelper
  def replace_name_with_link(text, rep)
    link = link_to(rep.name, representative_path(rep))
    text.gsub(rep.name, link)
  end
end
