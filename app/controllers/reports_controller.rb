class ReportsController < ApplicationController
	expose(:reckoning)
	expose(:items) { reckoning.items.find_all { |it| it.cost_valid? } }
	expose_decorated(:flows) { reckoning.flows }

	def create
		reck_id = params[:reckoning_id]
		if reck_id && reck = Reckoning.find(reck_id)
			reck.flows.destroy

			urs = reck.user_reckonings.map do |ur|
				{ ur: ur, flow: items.inject(0) { |mem, it| mem + it.expense_of(ur).value } }
			end
			urs.delete_if { |ur| ur[:flow] == 0 }
			urs = urs.partition { |ur| ur[:flow] < 0 }

			ur_sources, ur_targets = urs

			unless ur_sources.empty? || ur_targets.empty?
				j = 0
				t = ur_targets[j]
				in_rest = t[:flow]
				ur_sources.each do |s|
					out_rest = -s[:flow]
					while out_rest > 0 && t
						flow_value = 0
						new_flow = Flow.new(from_user_reckoning: s[:ur], to_user_reckoning: t[:ur], value: 0, reckoning: reck)
						if out_rest >= in_rest
							flow_value = in_rest

							j += 1
							if j < ur_targets.length
								t = ur_targets[j]
								in_rest = t[:flow]
							else
								t = nil
								in_rest = 0
							end
						else
							flow_value = out_rest
							in_rest -= out_rest
						end
						out_rest -= flow_value
						new_flow.value = flow_value
						new_flow.save
					end
				end
			end

			reck = Reckoning.find(reck_id)
			reck.report_generated_at = Time.now
			reck.save

			redirect_to action: :show
		else
			flash[:error] = "There's no such reckoning!"
			redirect_to reckonings_path
		end
	end

	def show
	end
end
