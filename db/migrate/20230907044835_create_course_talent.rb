# frozen_string_literal: true

class CreateCourseTalent < ActiveRecord::Migration[6.1]
  def change
    create_table :course_talents do |t|
      t.references :course, null: false, foreign_key: true
      t.references :talent, null: false, foreign_key: { to_table: :users }

      t.datetime :completed_at

      t.timestamps
      t.index %w[course_id talent_id], unique: true
    end
  end
end
