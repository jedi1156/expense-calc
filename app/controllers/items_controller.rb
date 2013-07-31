class ItemsController < ApplicationController
  expose(:reckoning)
  expose(:item)
  expose(:reckoning_items) { reckoning.items }

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
