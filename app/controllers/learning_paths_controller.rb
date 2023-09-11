# frozen_string_literal: true

class LearningPathsController < ApplicationController
  before_action :set_learning_path, only: %i[show update destroy]

  attr_reader :learning_paths, :learning_path

  def index
    @learning_paths = LearningPath.all
    render :index
  end

  def show
    render :show
  end

  def create
    @learning_path = LearningPath.new(learning_path_params)
    if learning_path.save
      render :show
    else
      @success = false
      @messages = learning_path.errors.full_messages
      render 'shared/messages', status: :unprocessable_entity
    end
  end

  def update
    if learning_path.update(learning_path_params)
      render :show
    else
      @success = false
      @messages = learning_path.errors.full_messages
      render 'shared/messages', status: :unprocessable_entity
    end
  end

  def destroy
    learning_path.destroy!
    render json: nil, status: :no_content
  end

  private

  def set_learning_path
    @learning_path = LearningPath.find(params[:id])
  end

  def learning_path_params
    params.permit(:name)
  end
end
