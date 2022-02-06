# frozen_string_literal: true

class AddOhlcsUniqueIndexByCoin < ActiveRecord::Migration[7.0]
  def change
    add_index :ohlcs, %i[coin_id recorded_at], unique: true
    remove_index :ohlcs, :recorded_at, unique: true
    remove_index :ohlcs, :coin_id
  end
end
