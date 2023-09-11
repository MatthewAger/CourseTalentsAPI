# frozen_string_literal: true

class CreateLearningPathCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_path_courses do |t|
      t.references :learning_path, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.integer :position

      t.timestamps
      t.index %w[position learning_path_id course_id],
              name: 'idx_position_learning_path_course',
              unique: true
    end
  end
end
