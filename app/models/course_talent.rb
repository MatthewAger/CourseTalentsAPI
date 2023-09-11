# frozen_string_literal: true

class CourseTalent < ApplicationRecord
  belongs_to :course, inverse_of: :course_talents
  belongs_to :talent, class_name: 'User', inverse_of: :course_talents

  validates :course, uniqueness: { scope: :talent }
  validate :talent_is_not_author

  delegate :learning_paths, to: :course

  def complete!
    errors.add(:completed_at, completed_at.strftime('%d/%m/%y')) && return if completed_at.present?

    update!(completed_at: Time.current)
    return unless course.learning_paths.any?

    learning_paths.each do |learning_path|
      learning_path_course = LearningPathCourse.find_by(learning_path:, course:)
      learning_path_talent = LearningPathTalent.find_by(learning_path:, talent:)
      next_course          = learning_path.learning_path_courses
                                          .find_by(position: learning_path_course.position + 1)&.course
      learning_path_talent.complete! && next if next_course.blank?

      CourseTalent.find_or_create_by!(course: next_course, talent:)
    end
  end

  private

  def talent_is_not_author
    errors.add(:talent, 'cannot be the author of the course') if talent == course.author
  end
end
