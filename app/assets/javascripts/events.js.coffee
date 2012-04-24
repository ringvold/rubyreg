# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->



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
    field_id = $(this).closest('li').find("#field_id").attr('value')
    event_id = $(this).closest('li').find("#field_event_id").attr("value")
    
    $('#delete-modal').modal()

    $(".delete-confirm").on "click", ->
	    if(!field_id)
	      $('#delete-modal').modal('hide')
	      $("#field"+field_id).fadeOut "slow", ->
	      	$(this).remove()
	      	updateOrder()
	    else
	    	result = $.ajax
	    		type: "DELETE",
	    		url: "/events/#{event_id}/fields/#{field_id}.json",
	    		data: { "id" : event_id }

	    	$('#delete-modal').modal('hide')

	    	result.done (msg)->
	        $("#field"+field_id).fadeOut "slow", -> 
	        	$(this).remove()
	        	updateOrder()

	    	result.fail (jqXHR, textStatus) ->
	    		alert( "Request failed: " + textStatus );

	# New field
	$(".fields-container").on "click", ".add-field", ->
		fields = $("#fields")
		event_id = fields.find("#field_event_id").attr('value')
		result = $.ajax
			type: "GET",
			url: "/events/#{event_id}/fields/new.json"

		result.done (msg) ->
			fields.append(msg.html)
			removeLinks()
			updateOrder()

		result.fail (msg) ->
			console.log(msg)
			alert("Noe gikk galt!")

	# Save field
	$("#fields form").submit ->
		html = $(this)
		values_to_submit = $(this).serialize()
		result = $.ajax 
			url: $(this).attr('action'),
			type: "POST",
			dataType: "json",
			data: values_to_submit,
			success: ->
				li = html.closest("li")
				old_bg = li.css("background-color")
				li.animate { backgroundColor: "#67E667"}, "slow", ->
					$(this).animate { backgroundColor: old_bg}, "slow"

		result.fail (msg) ->
			console.log(msg)
			console.log("FAIL")

		false


# end jQuery (document ready)
 
# Updates the field order in html and db
updateOrder = ->
	fields = $("#fields")
	event_id = fields.find("#field_event_id").attr("value");
	data = {}
	data.fields = {}
	fields.find('li').each ->
		$this = $(this)
		id = $this.find("input[name='field[id]']").attr("value")
		input = $this.find("input[name*=order]")
		input.attr("value", $this.index()+1)
		data.fields[id] = {}
		data.fields[id]['field_order'] = input.attr("value")
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
