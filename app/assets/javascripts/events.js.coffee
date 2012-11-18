# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

	# Get the event id
	event_id = $("#event_id").attr("value")

	# make fields sortable
	$("#fields").sortable
		placeholder: 'ui-state-highlight',
		# helper: fixHelper,
		stop: updateOrder

	# Remove links when javascript is enabled
	removeLinks()

	# Adding datepicker for event dates
	$('#event_start_date').datepicker
		dateFormat: "dd-mm-yy"
		showOtherMonths: true,
		selectOtherMonths: true
		
	$('#event_end_date').datepicker
		dateFormat: "dd-mm-yy"
		showOtherMonths: true,
		selectOtherMonths: true

	# Applies WYSIWYG editor to any textarea with the class "wysiwyg"
	$(".wysiwyg").wysiwyg
		css: '/assets/application.css'

	#### Edit Event ####

	# Delete field
  $("#fields").on "click", ".delete-field", ->
    field_id = $(this).closest('tr').find("#field_id").attr('value')
    console.log(field_id)
    # $('#delete-modal').modal()

    # Deletion with is buggy at best. Not using it for now.
    # $("#delete-modal").on "click", ".delete-confirm", ->
    if(!field_id)
      $('#delete-modal').modal('hide')
      $("#field"+field_id).fadeOut "slow", ->
      	$(this).remove()
      	updateOrder()
    else
    	console.log(field_id)
    	result = $.ajax
    		type: "DELETE",
    		url: "/events/#{event_id}/fields/#{field_id}.json",
    		success: ->
    			$("#field"+field_id).fadeOut "slow", -> 
			    	$(this).remove()

    	# $('#delete-modal').modal('hide')

			# result.done (msg)->
			# 	$("#field"+field_id).fadeOut "slow", -> 
			#     	$(this).remove()
    			
			    	
		  result.fail (jqXHR, textStatus) ->
				console.log(jqXHR)
				alert( "Request failed: " + textStatus );

		  result.always ->
			  	updateOrder()


	# New field
	$(".fields-container").on "click", ".add-field", ->
		fields = $("#fields")
		result = $.ajax
			type: "GET",
			url: "/events/#{event_id}/fields/new.json"

		result.done (msg) -> 
			fields.append(msg.html)
			
			updateOrder()
			removeLinks()

		result.fail (msg) ->
			console.log(msg)
			alert("Noe gikk galt!")


	# Save field
	$("#fields").on "submit", "form", (e) ->
		e.preventDefault()
		html = $(this)
		values_to_submit = html.serialize()
		console.log(values_to_submit)
		field_id = html.find("#field_id").attr("value")

		result = $.ajax 
			url: $(this).attr('action'),
			type: "POST",
			dataType: "json",
			data: values_to_submit,
			success: (data) ->
				saveSuccess(html,data)

		# .done (data, textStatus, lol, html) ->
		# 	console.log(data)
		# 	console.log(textStatus)
		# 	console.log(html)
		# 	saveSuccess(html)
			
		# .fail (msg) ->
		# 	console.log(msg)
		# 	console.log("FAIL")



# end jQuery (document ready)

# saves
saveSuccess = (html,data) ->
	console.log(html)
	li = html.closest("li")
	li.find("#field_id").attr("value", data.id) if data
	old_bg = li.css("background-color")
	li.animate { backgroundColor: "#67E667"}, "slow", ->
		$(this).animate { backgroundColor: old_bg}, "slow"

# Updates the field order in html and db
updateOrder = ->
	fields = $("#fields")
	event_id = fields.find("#field_event_id").attr("value");
	data = {}
	data.fields = {}
	test_id = 0
	fields.find('li').each ->
		$this = $(this)
		id = $this.find("#field_id").attr("value")
		input = $this.find("#field_field_order").attr("value", $this.index()+1)
		if id != ""
			data.fields[id] = {}
			data.fields[id]['field_order'] = input.attr("value")
			test_id = id
	if data.fields[test_id]
		$.post("/events/#{event_id}/updateOrder", data, "json") 

# Return a helper with preserved width of cells
fixHelper = (e, ui) ->
  ui.children().each -> 
    $(this).width($(this).width())
  ui

# JSify buttons
# Remove default rails href and data values
removeLinks = ->
	$('.add-field').attr('href', '#add-field')	
	$('.delete-field').attr('href', '#delete-field')
	$('.delete-field').attr("data-method", '')
	$('.delete-field').attr("data-confirm", '')
	# $('#fields form').attr("action", '')
	# $('.delete-field').attr("data-toggle", 'modal')
