# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('#post_images').on 'change', ->

    if $('#post_images')[0].files.length > 10
      emptyFile = document.createElement('input')
      emptyFile.type = 'file'
      $('#post_images')[0].files = emptyFile.files
      alert 'You can select maximum 10 images'

  $('.submit').on 'click', ->
    if $('.post_has_image').length > 0
      $('.select_files').attr('required',false)
    else
      $('.select_files').attr('required',true)

  $('.post_has_image').on 'change', ->
    if $('.post_has_image').length > 0
      $('.back_button').show()
    else
      $('.back_button').hide()

$(document).ready(ready)
$(document).on('turbolinks:load', ready)
