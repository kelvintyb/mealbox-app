// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui.min
//= require jquery.easing.min
//= require turbolinks
//= require bootstrap.min
//= require imagesloaded.pkgd
//= require masonry.pkgd
//= require_tree .

$(document).on('turbolinks:load', function () {
  $('.hero-cuisine').on('click', function (e) {
    e.preventDefault()
    $('#search_param').val($(this).text())
    console.log($('#search_param').val())
    $('.hero_search').submit()
  })
  $('.hero_search').on('ajax:success', function (e, data, status) {
    $('.hero_remove').empty()
    $('.hero_result').text('')
    console.log(data.search_recipes)
    $('.masonry-container').append('<div class="grid-sizer">')

    data.search_recipes.forEach(function (recipe) {
      var newList = $(`<div class="thumbnail recipe-thumb grid-item"><figure class="snip1268"><div class="image"><img src="${recipe.image}" alt="sq-sample4"><div class="icons"><div class="recipe-views"><span class="glyphicon glyphicon-eye-open views-icon"></span> ${recipe.views} </div></div> <a class="view-recipe" href="/recipes/${recipe.id}">View Recipe</a> </div></figure><div id="ribbon"><span id="content-cuisine"> ${recipe.cuisine} </span></div><div class="caption"><h3> ${recipe.name}</h3></div></div>`)
      $('.hero_result').append(newList)

      var mediaItemContainer = $('.masonry-container')
      mediaItemContainer.imagesLoaded(function () {
        mediaItemContainer.masonry({
          itemSelector: '.grid-item',
          percentPosition: true,
          columnWidth: '.grid-sizer',
          gutter: 20
        })
      })
      mediaItemContainer.masonry('reloadItems')
      mediaItemContainer.masonry('layout')
    })
  })
})
