class ReckoningsController < ApplicationController
  expose_decorated(:reckoning, attributes: :reckoning_params)
  expose_decorated(:your_reckonings, decorator: ReckoningDecorator) { current_user.user_reckonings.map { |r| r.reckoning } }
  expose(:users_in_reckoning) { reckoning.user_reckonings.map { |ur| ur.user } }
  expose(:new_invitations) { current_user.friends - reckoning.users }
  expose_decorated(:items) { reckoning.items }
  expose(:current_user_reckoning) { current_user.find_user_reckoning(reckoning.id) }
  
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
      redirect_to reckoning
    else
      redirect_to action: :edit
    end
  end

  def destroy
    flash[:error] = "Cannot remove that" unless reckoning.destroy
    redirect_to action: :index
  end

private
  def reckoning_params
    params.require(:reckoning).permit(:name, :description, :invitation_ids)
  end
end
