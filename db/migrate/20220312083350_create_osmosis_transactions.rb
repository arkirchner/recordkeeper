# frozen_string_literal: true

class CreateOsmosisTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :osmosis_transactions, id: false do |t|
      t.string :tx_hash, primary_key: true
      t.bigint :block, null: false
      t.timestamp :created_at, null: false
    end
  end
end
