# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :authored_courses

  has_many :course_talents, inverse_of: :course, dependent: :destroy
  has_many :talents, through: :course_talents, inverse_of: :courses

  has_many :learning_path_courses, inverse_of: :course, dependent: :destroy
  has_many :learning_paths, through: :learning_path_courses, inverse_of: :courses

  validates :title, presence: true
  validates :description, presence: true
end
