# frozen_string_literal: true

require 'rails_helper'

describe CampaignFinanceController, :vcr do
  describe 'CAMPAIGN FINANCE CONTROLLER TESTS' do
    let(:category) { 'pac-total' }
    let(:controller) { described_class.new }
    let(:cycle) { '2020' }
    let(:params) { { cycle: cycle, category: category } }
    # from https://projects.propublica.org/api-docs/campaign-finance/candidates/#candidates
    let(:names) do
      [
        'GARDNER, CORY',
        'PETERS, GARY',
        'MCCONNELL, MITCH',
        'TILLIS, THOM R. SEN.',
        'HOYER, STENY',
        'CORNYN, JOHN SEN',
        'DAINES, STEVEN',
        'NEAL, RICHARD E MR.',
        'PERDUE, DAVID',
        'COLLINS, SUSAN M.',
        'JONES, DOUG',
        'SMITH, TINA',
        'DAVIS, RODNEY L',
        'WARNER, MARK ROBERT',
        'MCSALLY, MARTHA',
        'ERNST, JONI K',
        'WALDEN, GREGORY P. MR.',
        'GRAHAM, LINDSEY O.',
        'SHAHEEN, JEANNE',
        'CLYBURN, JAMES E.'
      ]
    end

    it 'get_api_response returns data' do
      results = controller.get_api_response(cycle, category)
      expect(results).to have_key('results')
      results['results'] do |result|
        expect(names).to include?(result.name)
      end
    end

    context 'when validate_params rejects' do
      it 'years outside range' do
        get :search, params: { cycle: 1900, category: 'pac-total' }
        expect(response).to have_http_status(:redirect)
      end

      it 'non years for cycle' do
        get :search, params: { cycle: 'hippo', category: 'pac-total' }
        expect(response).to have_http_status(:redirect)
      end

      it 'invalid category' do
        get :search, params: { cycle: 2020, category: 'cucumber' }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when search enpoint' do
      it 'returns list of campaign_finance models' do
        get :search, params: params
        expect(assigns(:campaign_finances)).not_to be_nil
        expect(response).to render_template('campaign_finance/search')
      end
    end
  end
end
