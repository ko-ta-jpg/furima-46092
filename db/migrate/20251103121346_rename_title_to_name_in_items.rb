# frozen_string_literal: true

class RenameTitleToNameInItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :title, :name
  end
end
