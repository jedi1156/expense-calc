class ExpensesController < ApplicationController
	expose_decorated(:item)
	expose_decorated(:reckoning) { item.reckoning }
	expose_decorated(:item_expenses, decorator: ExpenseDecorator) { item.expenses }
	expose_decorated(:new_user_reckonings, decorator: UserReckoningDecorator) { reckoning.user_reckonings - item.expenses.map { |ex| ex.user_reckoning }}
	expose_decorated(:expense)

	def index
	end

	def show
	end

	def new
		if new_user_reckonings.empty?
			redirect_to action: :index
		end
	end

	def edit
	end

	def create
		expense.set_values(params[:expense])
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
		expense.set_values(params[:expense])
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

	def rest
		if paid = params[:paid]
			paid = to_cents(paid.to_f)
		else
			paid = expense.paid
		end

		saved_value = if expense.new_record?
			0
		else
			expense.value
		end

		the_rest = (item.cost + paid) - item.used - saved_value
		render json: to_dolars(the_rest)
	end
end
