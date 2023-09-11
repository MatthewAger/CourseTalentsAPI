# frozen_string_literal: true

class CreateLearningPathTalent < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_path_talents do |t|
      t.references :learning_path, null: false, foreign_key: true
      t.references :talent, null: false, foreign_key: { to_table: :users }

      t.datetime :completed_at

      t.timestamps
      t.index %w[learning_path_id talent_id], unique: true
    end
  end
end
