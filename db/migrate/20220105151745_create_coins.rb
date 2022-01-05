# frozen_string_literal: true

class CreateCoins < ActiveRecord::Migration[7.0]
  def change
    create_table :coins, id: 'string' do |t|
      t.string :symbol, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
