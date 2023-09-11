# frozen_string_literal: true

module Users
  class CoursesController < ApplicationController
    before_action :set_user
    before_action :set_course

    attr_reader :user, :course

    def update
      course_talent = CourseTalent.find_by!(course:, talent: user)
      course_talent.complete!
      if course_talent.errors.any?
        @success = false
        @messages = course_talent.errors.full_messages
        render 'shared/messages', status: :unprocessable_entity
      else
        @success = true
        @messages = "#{course.title} completed by #{user.name}!"
        render 'shared/messages', status: :ok
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_course
      @course = Course.find(params[:id])
    end
  end
end
