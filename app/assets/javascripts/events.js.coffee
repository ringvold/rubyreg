# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# $.rails.allowAction = (link) ->
#   return true unless link.attr('data-confirm')
#   $.rails.showConfirmDialog(link) # look bellow for implementations
#   false # always stops the action since code runs asynchronously

# $.rails.confirmed = (link) ->
# 	deleteField(this)

# $.rails.showConfirmDialog = (link) ->
#   message = link.attr 'data-confirm'
#   html = """
#          <div class="modal" id="confirmationDialog">
#            <div class="modal-header">
#              <a class="close" data-dismiss="modal">×</a>
#              <h3>#{message}</h3>
#            </div>
#            <div class="modal-body">
#              <p>Are you sure you want to delete?</p>
#            </div>
#            <div class="modal-footer">
#              <a data-dismiss="modal" class="btn">Cancel</a>
#              <a data-dismiss="modal" class="btn btn-primary confirm">OK</a>
#            </div>
#          </div>
#          """
#   $(html).modal()
#   $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)

jQuery ->

	$(".toggle-basic").click ->
		$(".edit-form").toggle()

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
  	deleteField(this)


	# New field
	$(".fields-container").on "click", ".add-field", ->
		fields = $("#fields")
		result = $.ajax
			type: "GET",
			url: "/admin/events/#{event_id}/fields/new.json"

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
			data: values_to_submit#,
			# success: (data) ->
			# 	saveSuccess(html,data)

		.done (data) ->
			console.log(data)
			saveSuccess(html,data)
			console.log("success")
			
		.fail (data) ->
			console.log(data)
			console.log("FAIL")
			errors = JSON.parse(data.responseText)
			console.log(data["0"])
			
			saveFail(html,data)
			alert("Tittel " + errors.field_label[0]) if errors.field_label



# end jQuery (document ready)

deleteField = (link) ->
  field_id = $(link).closest('tr').find("#field_id").attr('value')
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
	  result.fail (jqXHR, textStatus) ->
			console.log(jqXHR)
			alert( "Request failed: " + textStatus );
	  result.always ->
		  	updateOrder()

# saves
saveSuccess = (html,data) ->
	console.log(html)
	li = html.closest("li")
	li.find("#field_id").attr("value", data.id) if data
	old_bg = li.css("background-color")
	li.animate { backgroundColor: "#DFF0D8"}, "slow", ->
		$(this).animate { backgroundColor: old_bg}, "slow"

saveFail = (html,data) ->
	console.log(html)
	li = html.closest("li")
	li.find("#field_id").attr("value", data.id) if data
	old_bg = li.css("background-color")
	li.animate { backgroundColor: "#F2DEDE"}, "slow", ->
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
	# $('.delete-field').attr('href', '#delete-field')
	# $('.delete-field').attr("data-method", '')
	# $('.delete-field').attr("data-confirm", '')
	# $('#fields form').attr("action", '')
	# $('.delete-field').attr("data-toggle", 'modal')
