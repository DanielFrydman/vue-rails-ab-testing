# frozen_string_literal: true

module V1
  class TrackingDashboardController < ApplicationController
    def index
      charts = TrackingDashboardChartsGeneratorService.new(
        start_date:, end_date:, event_name:
      ).generate

      render json: { charts: }, status: :ok
    rescue StandardError => e
      render json: { message: "An error occurred: #{e}." }, status: :internal_server_error
    end

    def list_event_names
      render json: { event_names: Event.pluck(:event_name).uniq }, status: :ok
    rescue StandardError => e
      render json: { message: "An error occurred: #{e}." }, status: :internal_server_error
    end

    private

    def start_date
      params.require(:start_date)
    end

    def end_date
      params.require(:end_date)
    end

    def event_name
      params.require(:event_name)
    end
  end
end
