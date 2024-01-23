# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsBarChartPresenter, type: :presenter do
  describe '#chart_data' do
    let(:hash) do
      {
        'Control text' => 1,
        'Variation text' => 2
      }
    end
    let(:event_name) { 'sign_up' }

    subject { described_class.new(hash:, event_name:) }

    it 'returns the chart data in a hash' do
      expect(subject.chart_data).to(
        eq(
          {
            data: {
              labels: ['Control text', 'Variation text'],
              datasets: [
                {
                  label: '',
                  backgroundColor: '#38dc81',
                  data: [1, 2]
                }
              ]
            },
            chart_options: {
              responsive: true,
              maintainAspectRatio: false,
              plugins: {
                legend: {
                  display: false
                },
                title: {
                  display: true,
                  text: 'Sign up Chart'
                },
                subtitle: {
                  display: true,
                  text: 'Unique Sign up events per user by text variation in period',
                  color: '#092F54',
                  font: {
                    size: 12,
                    family: 'tahoma',
                    weight: 'normal',
                    style: 'italic'
                  },
                  padding: {
                    bottom: 10
                  }
                }

              }
            }
          }
        )
      )
    end
  end
end
