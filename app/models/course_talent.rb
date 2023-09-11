# frozen_string_literal: true

class CourseTalent < ApplicationRecord
  belongs_to :course, inverse_of: :course_talents
  belongs_to :talent, class_name: 'User', inverse_of: :course_talents

  validates :course, uniqueness: { scope: :talent }
end
