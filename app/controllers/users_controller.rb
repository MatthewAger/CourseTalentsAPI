# frozen_string_literal: true

# TODO: Consider splitting into author and talent endpoints
class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  attr_reader :users, :user

  def index
    @users = User.all
    render :index
  end

  def show
    render :show
  end

  def create
    @user = User.new(user_params)
    if user.save
      render :show
    else
      @success = false
      @messages = user.errors.full_messages
      render 'shared/messages', status: :unprocessable_entity
    end
  end

  def update
    if user.update(user_params)
      render :show
    else
      @success = false
      @messages = user.errors.full_messages
      render 'shared/messages', status: :unprocessable_entity
    end
  end

  def destroy
    user.destroy!
    render json: nil, status: :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name)
  end
end
