class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def show
    render :show
  end

  def update
    if @user.update(user_params)
      render :show
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.permit(:name, :email, :phone, :avatar)
    end
end
