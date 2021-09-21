# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
    $('#post_images').on 'change', ->

      if $('#post_images')[0].files.length > 10
        emptyFile = document.createElement('input')
        emptyFile.type = 'file'
        $('#post_images')[0].files = emptyFile.files
        alert 'You can select maximum 10 images'

      return


