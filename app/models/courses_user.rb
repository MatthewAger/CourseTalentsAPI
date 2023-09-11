# frozen_string_literal: true

class CoursesTalent < ApplicationRecord
  self.table_name = 'courses_users'

  belongs_to :course
  belongs_to :talent, class_name: 'User', foreign_key: 'user_id', inverse_of: :courses_talents
end
