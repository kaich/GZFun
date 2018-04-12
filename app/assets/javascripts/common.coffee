#common js 

$(document).on "turbolinks:load", ->
  $('.datetimepicker').datetimepicker({format: 'MMMM Do YYYY, h:mm'})
  $("[data-provide=markdown]").markdown({language: 'zh'})
