# frozen_string_literal: true

require 'rails_helper'

describe NewsItemsController, :vcr do
  describe 'GET #index' do
    before do
      @rep = Representative.create(name: 'John Cena')
      @article1 = NewsItem.create(title: 'Article 1', representative: @rep, link: 'https://google.com/news1', issue: 'Free Speech')
      @article2 = NewsItem.create(title: 'Article 2', representative: @rep, link: 'https://google.com/news2', issue: 'Immigration')
    end

    it 'assigns the articles to the representative' do
      get :index, params: { representative_id: @rep.id }
      expect(assigns(:news_items)).to eq([@article1, @article2])
    end
  end
end
