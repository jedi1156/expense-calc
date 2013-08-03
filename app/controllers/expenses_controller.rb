class ExpensesController < ApplicationController
	expose_decorated(:item)
	expose_decorated(:reckoning) { item.reckoning }
	expose_decorated(:expenses, decorator: ExpenseDecorator) { item.expenses }
	expose_decorated(:new_user_reckonings, decorator: UserReckoningDecorator) { item.new_user_reckonings }
	expose_decorated(:expense, attributes: :expense_params)

	authorize_resource :reckoning, decent_exposure: true

	def index
	end

	def show
	end

	def new
		if new_user_reckonings.empty?
			redirect_to item
		end
	end

	def edit
	end

	def create
		if expense.empty?
			redirect_to item_expenses_path(item)
		else
			expense.item_id = item.id
			if expense.save
				redirect_to reckoning_item_path(reckoning, item)
			else
				render action: :new
			end
		end
	end

	def update
		if expense.empty?
			expense.destroy
			redirect_to reckoning_item_path(reckoning, item)
		elsif expense.save
			redirect_to reckoning_item_path(reckoning, item)
		else
			render action: :edit
		end
	end

	def destroy
		flash[:error] = "Cannot remove that" unless expense.destroy
		redirect_to reckoning_item_path(reckoning, item)
	end

	def rest
		saved_value = if params[:expense_id] && (ex = Expense.find_or_initialize_by(id: params[:expense_id]))
			ex.value
		else
			0
		end

		if paid = params[:paid]
			paid = to_cents(paid.to_f)
		else
			paid = ex.paid
		end

		the_rest = (item.cost + paid) - item.used - saved_value
		render json: to_dolars(the_rest)
	end
private
	def expense_params
		raw = params.require(:expense).permit(:paid, :used, :user_reckoning_id)
		raw[:paid] = to_cents(raw[:paid])
		raw[:used] = to_cents(raw[:used])
		raw
	end
end
