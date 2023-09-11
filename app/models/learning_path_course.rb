# frozen_string_literal: true

class LearningPathCourse < ApplicationRecord
  belongs_to :learning_path, inverse_of: :learning_path_courses
  belongs_to :course, inverse_of: :learning_path_courses

  validates :position,
            presence: true,
            numericality: { only_integer: true },
            uniqueness: { scope: %w[learning_path_id course_id] }
end
