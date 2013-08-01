class ReckoningsController < ApplicationController
  expose(:reckoning)
  expose(:user_reckonings) { current_user.user_reckonings.map { |r| r.reckoning } }
  expose(:users_in_reckoning) { reckoning.user_reckonings.map { |ur| ur.user } }
  
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    ur = reckoning.user_reckonings.build(user_id: current_user.id, admin_rights: true)
    if reckoning.save
      ur.save
      redirect_to reckoning
    else
      redirect_to action: :new
    end
  end

  def update
    if reckoning.save
      redirect_to action: :index
    else
      redirect_to action: :edit
    end
  end

  def destroy
    flash[:error] = "Cannot remove that" unless reckoning.destroy
    redirect_to action: :index
  end
end
