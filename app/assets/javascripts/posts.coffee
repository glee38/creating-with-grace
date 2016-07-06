# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ajax:success', 'a.vote', (status,data,xhr)->
  # update counter
  $(".votes-count[id=#{data.id}]").text data.count
  return