# frozen_string_literal: true

class BarChartPresenter
  def initialize(chart_title:, chart_subtitle:, hash: {})
    @labels = hash.keys
    @values = hash.values
    @chart_title = chart_title
    @chart_subtitle = chart_subtitle
  end

  def chart_data
    { **data, **chart_options }
  end

  private

  def data
    {
      data: {
        labels: @labels,
        datasets: [
          {
            label: '',
            backgroundColor: '#38dc81',
            data: @values
          }
        ]
      }
    }
  end

  def chart_options
    {
      chart_options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          **legend,
          **title,
          **subtitles
        }
      }
    }
  end

  def legend
    {
      legend: {
        display: false
      }
    }
  end

  def title
    {
      title: {
        display: true,
        text: @chart_title
      }
    }
  end

  def subtitles
    {
      subtitle: {
        display: true,
        text: @chart_subtitle,
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
  end
end
