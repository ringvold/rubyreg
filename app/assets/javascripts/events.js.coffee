# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

 # make fields sortable
 # uses jquery UI

jQuery ->
	$("#fields").sortable(
		placeholder: 'ui-state-highlight',
		stop: updateOrder)
	$('#event_start_date').datepicker
		dateFormat: "dd-mm-yy"
		showOtherMonths: true,
		selectOtherMonths: true
	$('#event_end_date').datepicker
		dateFormat: "dd-mm-yy"
		showOtherMonths: true,
		selectOtherMonths: true

updateOrder = ->
	data = {}
	($("#fields li").each ->
		$this = $(this)
		id = $this.find("input[name=id]").attr("value")
		input = $this.find("input[name*=order]")
		input.attr("value", $this.index()+1)
		data[id] = input.attr("value"))
	$.post("/async/updatefieldorder", data, "json")
