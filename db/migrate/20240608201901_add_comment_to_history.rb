# frozen_string_literal: true

class AddCommentToHistory < ActiveRecord::Migration[7.1]
  def change
    add_column :histories, :comment, :string
  end
end
