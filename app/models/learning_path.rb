# frozen_string_literal: true

class LearningPath < ApplicationRecord
  has_many :learning_path_talents, inverse_of: :learning_path, dependent: :destroy
  has_many :talents, through: :learning_path_talents, inverse_of: :learning_paths

  has_many :learning_path_courses, inverse_of: :learning_path, dependent: :destroy
  has_many :courses, through: :learning_path_courses, inverse_of: :learning_paths

  validates :name, presence: true
end
