# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }, index: true

      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
