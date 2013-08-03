class UsersController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource decent_exposure: true

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
