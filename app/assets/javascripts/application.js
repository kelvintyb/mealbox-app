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
  // when the horizontal cuisine navbar clicked
  // prevent default form submit
  // add the text of button to hidden cuisine input value
  // change text of hero filter and empty the search query value
  $('.hero-cuisine').on('click', function (e) {
    e.preventDefault()
    $('#search_param').val($(this).text())
    $('#search_concept').text($(this).text())
    $('#search_query').val('')
    $('.hero_search').submit()

  })
  // when ajax successfully sent, remove content below the hero header
  // clear the previous search Results and search title
  // append masonry feature
  $('.hero_search').on('ajax:success', function (e, data, status) {
    $('.hero_remove').empty()
    $('.hero_result').text('')
    $('.search_message h1, .headerLine').remove()
    $('.masonry-container').append('<div class="grid-sizer">')

    // if search result is null, show Invalid
    // if search result less than 0, show no results
    // if search result more than 0, show search complete
    var search_title = 'No Results Found.'
    if (data.search_recipes === null) {
      search_title = 'Invalid Search Query.'
    } else if (data.search_recipes.length > 0) {
      search_title = 'More Recipes'
    }
    // append the search title above search results
    // insert before to move up the h1 from the bottom to the top
    var search_text = "<h1>" + search_title + "</h1><span class=\"headerLine\"></span>"
    $('.recipe-all').append(search_text)
    var getsearchTextH1 = $('.recipe-all h1, span.headerLine')
    getsearchTextH1.insertBefore('.recipe-all')
    // if there are search results, append the results below hero
    if (data.search_recipes !== [] || data.search_recipes !== null) {
      data.search_recipes.forEach(function (recipe) {
        var new_recipe = "<div class=\"thumbnail recipe-thumb grid-item\"><figure class=\"snip1268\"><div class=\"image\"><img src=" + recipe.image + " alt=\"sq-sample4\"><div class=\"icons\"><div class=\"recipe-views\"><span class=\"glyphicon glyphicon-eye-open views-icon\"></span>" + recipe.views + "</div></div> <a class=\"view-recipe\" href=\"/recipes/" + recipe.id + "\">View Recipe</a> </div></figure><div id=\"ribbon\"><span id=\"content-cuisine\">" + recipe.cuisine + "</span></div><div class=\"caption\"><h3>" +  recipe.name + "</h3></div></div>"
        $('.hero_result').append(new_recipe)

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
    }
  })
})
