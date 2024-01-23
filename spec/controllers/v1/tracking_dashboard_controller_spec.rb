# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(V1::TrackingDashboardController, type: :controller) do
  describe 'GET #index' do
    let(:params) do
      {
        start_date: Time.zone.now,
        end_date: Time.zone.tomorrow,
        event_name: 'sign_up'
      }
    end

    subject { post(:index, params:) }

    context 'when everything goes well' do
      let(:displayed_text_variation) { Faker::ChuckNorris.fact }
      let(:url) { Faker::Internet.url }

      before do
        create(:page_view, displayed_text_variation:, url:)
        create(:event, displayed_text_variation:, url:)
      end

      it 'returns data' do
        subject
        response_body = JSON.parse(response.body)
        expect(response_body).to(have_key('charts'))
        expect(response_body['charts']).to(have_key('total_ctr_chart'))
        expect(response_body['charts']).to(have_key('unique_ctr_chart'))
        expect(response_body['charts']).to(have_key('total_page_views_chart'))
        expect(response_body['charts']).to(have_key('unique_page_views_chart'))
        expect(response_body['charts']).to(have_key('total_events_chart'))
        expect(response_body['charts']).to(have_key('unique_events_chart'))
      end

      it 'returns 200' do
        subject
        expect(response).to(have_http_status(:ok))
      end
    end

    context 'when something goes wrong' do
      before do
        allow_any_instance_of(PageViewsBarChartPresenter).to(
          receive(:chart_data)
        ).and_raise(StandardError, 'Error x')
      end

      it 'returns error message' do
        subject
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to(
          eq(
            'An error occurred: Error x.'
          )
        )
      end

      it 'returns 500' do
        subject
        expect(response).to(have_http_status(:internal_server_error))
      end
    end
  end

  describe 'GET #list_event_names' do
    let(:params) { { event_name: 'sign_up' } }

    subject { post(:list_event_names, params:) }

    before do
      create(:event)
    end

    context 'when everything goes well' do
      it 'returns list' do
        subject
        response_body = JSON.parse(response.body)
        expect(response_body).to(have_key('event_names'))
      end

      it 'returns 200' do
        subject
        expect(response).to(have_http_status(:ok))
      end
    end

    context 'when something goes wrong' do
      let(:model_double) { double('Event') }

      before do
        stub_const('Event', model_double)
        allow(model_double).to(receive(:pluck)).and_raise(StandardError, 'Error x')
      end

      it 'returns error message' do
        subject
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to(
          eq(
            'An error occurred: Error x.'
          )
        )
      end

      it 'returns 500' do
        subject
        expect(response).to(have_http_status(:internal_server_error))
      end
    end
  end
end
