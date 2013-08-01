class ExpensesController < ApplicationController
	expose_decorated(:item)
	expose_decorated(:reckoning) { item.reckoning }
	expose_decorated(:user_reckonings) { reckoning.user_reckonings }
	expose(:item_expenses) { item.expenses }
	expose_decorated(:expense)

	def index
	end

	def show
	end

	def new
	end

	def edit
	end

	def create
		if expense.empty?
			redirect_to item_expenses_path(item)
		else
			expense.item_id = item.id
			if expense.save
				redirect_to item_expenses_path(item)
			else
				redirect_to action: :new
			end
		end
	end

	def update
		if expense.empty?
			expense.destroy
			redirect_to item_expenses_path(item)
		elsif expense.save
			redirect_to item_expenses_path(item)
		else
			redirect_to action: :edit
		end
	end

	def destroy
		flash[:error] = "Cannot remove that" unless expense.destroy
		redirect_to action: :index
	end
end
