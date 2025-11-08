# frozen_string_literal: true

class AddProfileFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :nickname,        :string unless column_exists?(:users, :nickname)
    add_column :users, :last_name,       :string unless column_exists?(:users, :last_name)
    add_column :users, :first_name,      :string unless column_exists?(:users, :first_name)
    add_column :users, :last_name_kana,  :string unless column_exists?(:users, :last_name_kana)
    add_column :users, :first_name_kana, :string unless column_exists?(:users, :first_name_kana)
    add_column :users, :birthday,        :date   unless column_exists?(:users, :birthday)
  end
end
