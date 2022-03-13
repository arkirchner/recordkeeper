# frozen_string_literal: true

class ImportOsmosisTransactionsJob < ApplicationJob
  queue_as :default

  def perform(wallet)
    api_client.get_transactions(address: wallet.address, limit: 2, offset: 1).each do |transaction|
      tx_hash = transaction['tx_response']['txhash']
      block = transaction['tx_response']['height'].to_i
      created_at = Time.zone.parse(transaction['tx_response']['timestamp'])
      Osmosis::Transaction.create!(tx_hash:, block:, created_at:, wallet:)
    end
  end

  def api_client
    @api_client ||= Osmosis::ApiClient.new
  end
end
