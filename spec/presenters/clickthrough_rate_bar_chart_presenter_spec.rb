# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClickthroughRateBarChartPresenter, type: :presenter do
  describe '#chart_data' do
    let(:total_uniq_page_views) do
      {
        'Control text' => 2,
        'Variation text' => 1
      }
    end
    let(:total_uniq_events) do
      {
        'Control text' => 1,
        'Variation text' => 1
      }
    end

    subject { described_class.new(total_uniq_page_views:, total_uniq_events:) }

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
                  data: [50.0, 100.0]
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
                  text: 'CTR Chart'
                },
                subtitle: {
                  display: true,
                  text: 'Clickthrough Rate per unique users by text variation in period (%)',
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
