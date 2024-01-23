# frozen_string_literal: true

module V1
  class TrackPageViewController < ApplicationController
    def create
      PageView.create!(user_id:, url:, displayed_text_variation:)

      render json: { message: 'Page view tracked.' }, status: :created
    rescue StandardError => e
      render json: { message: "An error occurred: #{e}." }, status: :internal_server_error
    end

    private

    def user_id
      params.require(:user_id)
    end

    def url
      params.require(:url)
    end

    def displayed_text_variation
      params.require(:displayed_text_variation)
    end
  end
end
