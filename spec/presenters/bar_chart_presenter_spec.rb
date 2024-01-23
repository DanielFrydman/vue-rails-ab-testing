# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BarChartPresenter, type: :presenter do
  describe '#chart_data' do
    let(:hash) do
      {
        'Control text' => 1,
        'Variation text' => 2
      }
    end
    let(:chart_title) { 'Random Chart' }
    let(:chart_subtitle) { 'Random Subtitle' }

    subject { described_class.new(hash:, chart_title:, chart_subtitle:) }

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
                  text: chart_title
                },
                subtitle: {
                  display: true,
                  text: chart_subtitle,
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
