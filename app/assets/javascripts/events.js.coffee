# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  $(".toggle-basic").click ->
    $(".edit-form").toggle()

  # Get the event id
  window.event_id = $("#event_id").attr("value")

  # make fields sortable
  $("#fields").sortable
    placeholder: 'ui-state-highlight',
    # helper: fixHelper,
    stop: updateOrder

  # Remove links when javascript is enabled
  removeLinks()

  # Adding datepicker for event dates
  $('#event_start_date').datepicker
    dateFormat: "dd.mm.yy"
    showOtherMonths: true,
    selectOtherMonths: true

  $('#event_end_date').datepicker
    dateFormat: "dd.mm.yy"
    showOtherMonths: true,
    selectOtherMonths: true

  # Applies WYSIWYG editor to any textarea with the class "wysiwyg"
  $(".wysiwyg").wysiwyg
    css: '/assets/application.css'


# end jQuery (document ready)

deleteField = (link) ->
  $link = $(link)
  # console.log ($link)
  field_id_el = $link.closest('tr').find("#field_id")
  field_id = field_id_el.attr('value')
  li = $link.closest("li")
  li_id = li.attr("id")
  # console.log($link.closest("li"))
  # console.log("li_id: #{li_id}")

  unless li_id
    li.fadeOut "slow", ->
      $(this).remove()
      updateOrder()
  else
    console.log(field_id)
    result = $.ajax
      type: "DELETE",
      url: "/admin/events/#{event_id}/fields/#{field_id}.json"

    result.done (jqXHR) ->
      console.log(jqXHR)
      li.fadeOut "slow", ->
        $(this).remove()
        updateOrder()
    result.fail (jqXHR, textStatus) ->
      console.log(jqXHR)
      alert( "Request failed: " + textStatus );

    result.always ->
        # updateOrder()

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
  li.attr("id", )
  li.find("form").attr("id", "field#{data.id}") if data
  old_bg = li.css("background-color")
  li.animate { backgroundColor: "#F2DEDE"}, "slow", ->
    $(this).animate { backgroundColor: old_bg}, "slow"

# Updates the field order in html and db
@updateOrder = ->
  fields = $("#fields")
  event_id = fields.find("#field_event_id").attr("value");
  data = {}
  data.fields = {}
  data_to_send = false
  fields.find('li').each ->
    $this = $(this)
    id = $this.find("#field_id").attr("value")
    input = $this.find("#field_field_order").attr("value", $this.index()+1)
    if id != ""
      data.fields[id] = {}
      data.fields[id]['field_order'] = input.attr("value")
      data_to_send = true
  # console.log(data)
  if data_to_send
    $.post("/admin/events/#{event_id}/updateOrder", data, "json")

# Return a helper with preserved width of cells
fixHelper = (e, ui) ->
  ui.children().each ->
    $(this).width($(this).width())
  ui

# JSify buttons
# Remove default rails href and data values
removeLinks = ->
  # $('.add-field').attr('href', '#add-field')
  # $('.delete-field').attr('href', '#delete-field')
  # $('.delete-field').attr("data-method", '')
  # $('.delete-field').attr("data-confirm", '')
  # $('#fields form').attr("action", '')
  # $('.delete-field').attr("data-toggle", 'modal')
