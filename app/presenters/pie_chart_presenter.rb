# frozen_string_literal: true

class PieChartPresenter
  def initialize(hash)
    @labels = hash.keys
    @elements_length = hash.length
    @values = hash.values
  end

  def chart_data
    {
      labels: @labels,
      datasets: [
        {
          backgroundColor: colors[0..@elements_length - 1],
          data: @values
        }
      ]
    }
  end

  private

  def colors
    [
      '#37DE80', '#092F54', '#1f77b4', '#ff7f0e', '#d62728',
      '#9467bd', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf',
      '#1a9850', '#66c2a5', '#fc8d62', '#8da0cb', '#e78ac3',
      '#a6d854', '#ffd92f', '#e41a1c', '#377eb8', '#4daf4a'
    ]
  end
end
