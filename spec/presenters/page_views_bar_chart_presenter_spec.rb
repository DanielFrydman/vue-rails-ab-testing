# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PageViewsBarChartPresenter, type: :presenter do
  describe '#chart_data' do
    let(:hash) do
      {
        'Control text' => 1,
        'Variation text' => 2
      }
    end

    subject { described_class.new(hash) }

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
                  text: 'Page Views Chart'
                },
                subtitle: {
                  display: true,
                  text: 'Unique page views per user by text variation in period',
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
