# frozen_string_literal: true

class User < ApplicationRecord
  has_many :authored_courses,
           class_name:  'Course',
           foreign_key: 'author_id',
           inverse_of:  :author,
           dependent:   :destroy

  has_many :course_talents, foreign_key: 'talent_id', inverse_of: :talent, dependent: :destroy
  has_many :courses, through: :course_talents, inverse_of: :talents

  has_many :learning_path_talents, foreign_key: 'talent_id', inverse_of: :talent, dependent: :destroy
  has_many :learning_paths, through: :learning_path_talents, inverse_of: :talents

  validates :name, presence: true

  def author?
    authored_courses.any?
  end

  def talent?
    course_talents.any? || learning_path_talents.any?
  end
end
