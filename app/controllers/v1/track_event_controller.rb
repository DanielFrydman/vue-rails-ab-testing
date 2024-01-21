# frozen_string_literal: true

module V1
  class TrackEventController < ApplicationController
    def create
      Event.create!(user_id:, event_name:, url:, displayed_text_variation:)

      render json: { message: "Event #{event_name} tracked." }, status: :created
    rescue StandardError => e
      render json: { message: "An error occured: #{e}." }, status: :internal_server_error
    end

    private

    def user_id
      params.require(:user_id)
    end

    def event_name
      params.require(:event_name)
    end

    def url
      params.require(:url)
    end

    def displayed_text_variation
      params.require(:displayed_text_variation)
    end
  end
end
