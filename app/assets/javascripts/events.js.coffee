# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	# make fields sortable
	$("#fields").sortable
		placeholder: 'ui-state-highlight',
		# helper: fixHelper,
		# stop: updateOrder

	# Remove links when javascript is enabled
	# $('.add-field').attr('href', '#add-field')
	$('.delete-field').attr('href', '#delete-field')
	$('.delete-field').attr("data-method", '')
	$('.delete-field').attr("data-confirm", '')
	# $('.delete-field').attr("data-toggle", 'modal')

	# Adding datepicker for event dates
	$('#event_start_date').datepicker
		dateFormat: "dd-mm-yy"
		showOtherMonths: true,
		selectOtherMonths: true
		
	$('#event_end_date').datepicker
		dateFormat: "dd-mm-yy"
		showOtherMonths: true,
		selectOtherMonths: true

	#### Edit Event ####

	# Delete field
  $(".delete-field").live "click", ->
    field_id = $(this).closest('tr.field').find("#field_id").attr('value');
    event_id = $(this).closest('tr.field').find("#field_event_id").attr("value");
    
    $('#delete-modal').modal()

    $(".delete-confirm").live "click", ->
	    if(event_id == 0)
	      $("#field"+fieldId).fadeOut "slow", ->
	      	$(this).remove()
	      	updateOrder()
	      	$('#delete-modal').modal('hide')
	    else 
	    	result = $.ajax({
	    		type: "DELETE",
	    		url: "/events/#{event_id}/fields/#{field_id}.json",
	    		data: { "id" : event_id }
	    	})
	    	$('#delete-modal').modal('hide')
	    	result.done (msg)->
	        $("#field"+field_id).fadeOut "slow", -> 
	        	$(this).remove()
	        	updateOrder()
	    	result.fail jqXHR, textStatus ->
	    		alert( "Request failed: " + textStatus );

	# Applies WYSIWYG editor to any textarea with the class "wysiwyg"
	$(".wysiwyg").wysiwyg
		css: 'assets/application.css'

# end jQuery
 

updateOrder = ->
	data = {}
	($("#fields li").each ->
		$this = $(this)
		id = $this.find("input[name=id]").attr("value")
		input = $this.find("input[name*=order]")
		input.attr("value", $this.index()+1)
		data[id] = input.attr("value"))
	$.post("/fields/updateorder", data, "json")

# Return a helper with preserved width of cells
fixHelper = (e, ui) ->
  ui.children().each -> 
    $(this).width($(this).width())
  ui
