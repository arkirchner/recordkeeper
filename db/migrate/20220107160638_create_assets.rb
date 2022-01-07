# frozen_string_literal: true

class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets do |t|
      t.string :coin_id, null: false, index: true
      t.float :amount, null: false, default: 0

      t.timestamp :created_at, null: false
    end

    add_foreign_key :assets, :coins
  end
end
