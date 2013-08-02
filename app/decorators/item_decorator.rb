class ItemDecorator < Draper::Decorator
	delegate_all
	decorate :item

  def money_cost
    to_dolars(cost)
  end

  def money_used
    to_dolars(used)
  end
end
