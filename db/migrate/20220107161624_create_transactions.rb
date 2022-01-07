# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :asset, null: false, foreign_key: true
      t.float :amount, null: false

      t.timestamp :created_at, null: false
    end
  end
end
