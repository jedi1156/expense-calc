class ItemDecorator < Draper::Decorator
	delegate_all
	decorate :item

  def money_cost
    to_dolars(cost)
  end

  def money_used
    to_dolars(used)
  end

  def money_paid_by(user_reckoning)
    to_dolars(expense_of(user_reckoning).paid)
  end

  def money_used_by(user_reckoning)
    to_dolars(expense_of(user_reckoning).used)
  end

  def balance_of(user_reckoning)
    to_dolars(expense_of(user_reckoning).value)
  end

  def positive_balance_of?(user_reckoning)
    expense_of(user_reckoning).value >= 0
  end

  def to_s
    name
  end
end
