class ItemsController < ApplicationController
  expose_decorated(:reckoning)
  expose_decorated(:item)
  expose_decorated(:sorted_items, decorator: ItemDecorator) { reckoning.items.sort_by { |it| it.bought_at || Time.now } }
  expose_decorated(:expenses) { item.expenses }
  expose_decorated(:new_user_reckonings, decorator: UserReckoningDecorator) { item.new_user_reckonings }
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
    item.reckoning_id = reckoning.id
    if item.save
      redirect_to reckoning_item_path(reckoning, item)
    else
      redirect_to action: :new
    end
  end

  def update
    if item.save
      redirect_to reckoning_item_path(reckoning, item)
    else
      redirect_to action: :edit
    end
  end

  def destroy
    flash[:error] = "Cannot remove that" unless item.destroy
    redirect_to action: :index
  end
end
