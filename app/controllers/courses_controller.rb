# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]

  attr_reader :courses, :course

  def index
    @courses = Course.all
    render :index
  end

  def show
    render :show
  end

  def create
    @course = Course.new(course_params)
    if course.save
      render :show
    else
      @success = false
      @messages = course.errors.full_messages
      render 'shared/messages', status: :unprocessable_entity
    end
  end

  def update
    if course.update(course_params)
      render :show
    else
      @success = false
      @messages = course.errors.full_messages
      render 'shared/messages', status: :unprocessable_entity
    end
  end

  def destroy
    course.destroy!
    render json: nil, status: :no_content
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.permit(:author_id, :title, :description)
  end
end
