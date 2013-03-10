# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$("#replies").tablesorter({
			headers: {
				0: { sorter: false}
			}
		});

	$("#select_all").click ->
		$("table tr").toggleClass("info")
		$("table [name='reply_ids[]']").attr "checked", $(this).is(":checked")

	$("#replies tbody tr").click ->
		$(this).toggleClass("info")
		$(this).find("[name='reply_ids[]']").toggleAttr "checked"

	# $("#delete_selected").click ->
	# 	selected = $("table [name='reply_ids[]']").checked
	# 	result = $.ajax
 #  		type: "DELETE",
 #  		url: "/admin/replies"

	# 	result.done (response) ->
	# 		console.log(response)

	# 	result.fail (response) ->
	# 		console.log(response)
