
jQuery ->
	$('#user_locality').parent().hide()
	localities = $('#user_locality').html()
	$('#user_county').change ->
		county = $('#user_county :selected').text()
		options = $(localities).filter("optgroup[label='#{county}']").html()
		if options 
			$('#user_locality').html(options)
			$('#user_locality').parent().show()
		else
			$('#user_locality').empty()
			$('#user_locality').parent().hide()

		