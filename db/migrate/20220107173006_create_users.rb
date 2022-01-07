# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :assets, :coin_id
    add_column :assets, :user_id, :bigint
    add_index :assets, %i[user_id coin_id], unique: true

    create_table :users, &:timestamps

    add_foreign_key :assets, :users
  end
end
