# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(V1::TrackEventController, type: :controller) do
  describe 'POST #create' do
    let(:params) do
      {
        user_id: '123',
        event_name: 'sign_up',
        url: 'https://localhost:3000/',
        displayed_text_variation: 'A random text variation.'
      }
    end

    subject { post(:create, params:) }

    context 'when everything goes well' do
      it 'creates event' do
        expect { subject }.to(change { Event.count }.by(1))
      end

      it 'returns message' do
        subject
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to(eq('Event sign_up tracked.'))
      end

      it 'returns 201' do
        subject
        expect(response).to(have_http_status(:created))
      end
    end

    context 'when something goes wrong' do
      before do
        params.delete(:user_id)
      end

      it 'does not create event' do
        expect { subject }.not_to(change { Event.count })
      end

      it 'returns error message' do
        subject
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to(
          eq('An error occured: param is missing or the value is empty: user_id.')
        )
      end

      it 'returns 500' do
        subject
        expect(response).to(have_http_status(:internal_server_error))
      end
    end
  end
end
