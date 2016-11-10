# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready (e) ->
  $('.search-panel .dropdown-menu').find('a').click (e) ->
    e.preventDefault()
    param = $(this).attr('href').replace('#', '')
    concept = $(this).text()
    $('.search-panel span#search_concept').text concept
    $('.input-group #search_param').val param
    return
  return
