module MoneyRoutines
	def to_dolars(money)
		"%.2f" % (money.to_f / 100)
	end

	def to_cents(money)
		(money.to_f * 100).to_i
	end
end
