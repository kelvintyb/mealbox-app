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
  $('.hero_search').on('ajax:success', function (e, data, status) {
    $('.hero_remove').empty()
    if (data == []){
      var QueryNotFound = `<h1>No recipes found. Please try again!</h1><span class="headerLine"></span><span class="add-recipe-btn"><i class="fa fa-plus" aria-hidden="true"></i><a href="/recipes/new">Add Recipe</a>
      </span><div style="clear:both;"></div>`
      $(".hero_remove").append(QueryNotFound)
    }
    else {
      var masonryStarter =  `<h1>Search Results</h1><span class="headerLine"></span><span class="add-recipe-btn"><i class="fa fa-plus" aria-hidden="true"></i><a href="/recipes/new">Add Recipe</a>
      </span><div class="recipe-all"><div class="masonry-container"><div class="grid-sizer"></div></div>
      </div><div style="clear:both;"></div>`
      $('.hero_remove').append(masonryStarter)
      data.search_recipes.forEach(function(recipe){
        var masonryTile = `<div class="thumbnail recipe-thumb grid-item"><figure class="snip1268"><div class="image"><img src="${recipe.image}" alt="sq-sample4" class="hoverZoomLink"><div class="icons"><div class="recipe-views"><span class="glyphicon glyphicon-eye-open views-icon"></span>${recipe.views}</div></div><a class="view-recipe" href="/recipes/${recipe.id}">View Recipe</a></div></figure><div id="ribbon"><span id="content-cuisine">${recipe.cuisine}</span></div><div class="caption"><h3>${recipe.name}</h3></div></div>`
        $(".masonry-container").masonry().append(masonryTile).masonry('appended', masonryTile).masonry();
      })
    }
    console.log(data.search_recipes)
  })
})
