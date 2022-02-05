# frozen_string_literal: true

require 'test_helper'

class OhlcImportJobTest < ActiveJob::TestCase
  API_ENDPOINT =
    'https://api.coingecko.com/api/v3/coins/cardano/ohlc?days=1&vs_currency=usd'

  setup do
    @coin = Coin.create!(id: 'cardano', symbol: 'ada', name: 'Cardano')
  end

  test 'imports a ohlc series' do
    api_response =
      '[[1642836600000,15.56,15.58,15.54,15.55],[1642838400000,15.35,15.59,15.33,15.55]]'

    stub_request(:get, API_ENDPOINT)
      .to_return(status: 200, body: api_response)

    assert_changes 'Ohlc.count', from: 0, to: 2 do
      OhlcImportJob.perform_now(@coin)
    end

    assert Ohlc.exists?(recorded_at: '2022-01-22 07:30:00',
                        open: 15.56,
                        high: 15.58,
                        low: 15.54,
                        close: 15.55)

    assert Ohlc.exists?(recorded_at: '2022-01-22 08:00:00',
                        open: 15.35,
                        high: 15.59,
                        low: 15.33,
                        close: 15.55)
  end

  test 'skips not finalized ohlc' do
    timestamp = 1.hour.from_now.beginning_of_hour.to_i * 10_000

    api_response =
      "[[1642836600000,15.56,15.58,15.54,15.55],[#{timestamp},15.35,15.59,15.33,15.55]]"
    stub_request(:get, API_ENDPOINT)
      .to_return(status: 200, body: api_response)

    assert_changes 'Ohlc.count', from: 0, to: 1 do
      OhlcImportJob.perform_now(@coin)
    end
  end

  test 'scheduals the job 61 seconds later when too many requests have been made' do
    stub_request(:get, API_ENDPOINT)
      .to_return(status: 429, body: '')

    freeze_time do
      assert_enqueued_with(job: OhlcImportJob, args: [@coin], at: 61.seconds.from_now) do
        OhlcImportJob.perform_now(@coin)
      end
    end
  end
end
