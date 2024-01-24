# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(TrackingDashboardChartsGeneratorService, type: :services) do
  describe '#generate' do
    let!(:event) { create(:event, url: 'https://fake-url.com') }
    let!(:page_view) { create(:page_view, url: 'https://fake-url.com') }
    let(:event_name) { event.event_name }
    let(:start_date) { Time.zone.yesterday.to_s }
    let(:end_date) { Time.zone.tomorrow.to_s }

    subject { described_class.new(start_date:, end_date:, event_name:) }

    it 'returns total and unique charts (page views, events and ctr)' do
      expect(subject.generate).to(
        eq(
          {
            unique_events_chart: {
              data: {
                labels: [event.displayed_text_variation],
                datasets: [
                  {
                    label: '',
                    backgroundColor: '#38dc81',
                    data: [1]
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
                    text: 'Unique Sign up Chart'
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
            },
            unique_page_views_chart: {
              data: {
                labels: [page_view.displayed_text_variation],
                datasets: [
                  {
                    label: '',
                    backgroundColor: '#38dc81',
                    data: [1]
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
                    text: 'Unique Page Views Chart'
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
            },
            unique_ctr_chart: {
              data: {
                labels: [page_view.displayed_text_variation],
                datasets: [
                  {
                    label: '',
                    backgroundColor: '#38dc81',
                    data: [0]
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
                    text: 'Unique CTR Chart'
                  },
                  subtitle: {
                    display: true,
                    text: 'Unique clickthrough rate per users by text variation in period (%)',
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
            },
            total_events_chart: {
              data: {
                labels: [event.displayed_text_variation],
                datasets: [
                  {
                    label: '',
                    backgroundColor: '#38dc81',
                    data: [1]
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
                    text: 'Total Sign up Chart'
                  },
                  subtitle: {
                    display: true,
                    text: 'Total Sign up events by text variation in period',
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
            },
            total_page_views_chart: {
              data: {
                labels: [page_view.displayed_text_variation],
                datasets: [
                  {
                    label: '',
                    backgroundColor: '#38dc81',
                    data: [1]
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
                    text: 'Total Page Views Chart'
                  },
                  subtitle: {
                    display: true,
                    text: 'Total page views by text variation in period',
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
            },
            total_ctr_chart: {
              data: {
                labels: [page_view.displayed_text_variation],
                datasets: [
                  {
                    label: '',
                    backgroundColor: '#38dc81',
                    data: [0]
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
                    text: 'Total CTR Chart'
                  },
                  subtitle: {
                    display: true,
                    text: 'Total clickthrough rate by text variation in period (%)',
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
          }
        )
      )
    end
  end
end
