# frozen_string_literal: true

class CreateOhlcs < ActiveRecord::Migration[7.0]
  def change
    create_table :ohlcs do |t|
      t.decimal :open, null: false, precision: 8, scale: 2
      t.decimal :high, null: false, precision: 8, scale: 2
      t.decimal :low, null: false, precision: 8, scale: 2
      t.decimal :close, null: false, precision: 8, scale: 2
      t.string :coin_id, null: false
      t.string :source, null: false
      t.timestamp :recorded_at, null: false

      t.timestamps
    end

    add_index :ohlcs, :recorded_at, unique: true
    add_index :ohlcs, :coin_id
    add_foreign_key :ohlcs, :coins
  end
end
