class ReckoningDecorator < Draper::Decorator
	delegate_all
	decorate :reckoning

  include MoneyRoutines

  def total_money_cost
    to_dolars(total_cost)
  end

  def total_money_usage_by(user_reckoning)
    to_dolars(total_usage_by(user_reckoning))
  end
end
