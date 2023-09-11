# frozen_string_literal: true

class User < ApplicationRecord
  has_many :authored_courses,
           class_name:  'Course',
           foreign_key: 'author_id',
           inverse_of:  :author

  has_many :course_talents, foreign_key: 'talent_id', inverse_of: :talent, dependent: :destroy
  has_many :courses, through: :course_talents, inverse_of: :talents

  has_many :learning_path_talents, foreign_key: 'talent_id', inverse_of: :talent, dependent: :destroy
  has_many :learning_paths, through: :learning_path_talents, inverse_of: :talents

  validates :name, presence: true

  before_destroy do
    if authored_courses.any?
      another_user = self.class.where.not(id: id).sample
      throw(:abort) if another_user.blank?

      authored_courses.update_all(author_id: another_user.id) # rubocop:disable Rails/SkipsModelValidations
    end
  end

  def author?
    authored_courses.any?
  end

  def talent?
    course_talents.any? || learning_path_talents.any?
  end
end
