# frozen_string_literal: true

module Osmosis
  class Transaction < ApplicationRecord
    self.primary_key = :tx_hash
    self.table_name  = :osmosis_transactions

    belongs_to :wallet, foreign_key: 'wallet_address', primary_key: :address, class_name: 'Osmosis::Wallet'
  end
end
