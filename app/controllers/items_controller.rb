class ItemsController < ApplicationController
  expose_decorated(:reckoning)
  expose_decorated(:item)
  expose_decorated(:items) { reckoning.items }
  expose_decorated(:expenses) { item.expenses }
  expose_decorated(:new_user_reckonings, decorator: UserReckoningDecorator) { item.new_user_reckonings }

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
      redirect_to reckoning_items_path(reckoning)
    else
      redirect_to action: :new
    end
  end

  def update
    if item.save
      redirect_to reckoning_items_path(reckoning)
    else
      redirect_to action: :edit
    end
  end

  def destroy
    flash[:error] = "Cannot remove that" unless item.destroy
    redirect_to action: :index
  end
end
