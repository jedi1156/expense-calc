$(document).ready ->
	$form_inputs = $(".form-inputs")
	$form_inputs.on("click", ".expense--rest", (e) ->
		e.preventDefault()
		e.stopPropagation()

		$.get $(@).attr("href"),
			paid: $form_inputs.find(".expense--paid").val()
			(data) ->
				$form_inputs.find(".expense--used").val(data)
	)
	

