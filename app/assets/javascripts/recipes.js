// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
var current_fs, next_fs, previous_fs // fieldsets
var left, opacity, scale // fieldset properties which we will animate
var animating; // flag to prevent quick multi-click glitches


$(document).on('turbolinks:load', function () {

    $(function() {
      $('.mealbox-flasher').delay(2500).fadeOut();
    });

    $('.search-panel .dropdown-menu').find('a').click(function(e) {
		e.preventDefault();
		var param = $(this).attr("href").replace("#","");
		var concept = $(this).text();
		$('.search-panel span#search_concept').text(concept);
		$('.input-group #search_param').val(param);
  	});


  $('.next').click(function () {
    if (animating) return false
    animating = true
    //TEST for r.easing[this.easing] bug - recreate by commenting out this = that line and running through create form twice
    var that = this
    current_fs = $(that).parent()
    next_fs = $(that).parent().next()

    // activate next step on progressbar using the index of next_fs
    $('#progressbar li').eq($('fieldset').index(next_fs)).addClass('active')

    // show the next fieldset
    next_fs.show()
    // hide the current fieldset with style
    current_fs.animate({opacity: 0}, {
      step: function (now, mx) {
        // as the opacity of current_fs reduces to 0 - stored in "now"
        // 1. scale current_fs down to 80%
        scale = 1 - (1 - now) * 0.2
        // 2. bring next_fs from the right(50%)
        left = (now * 50) + '%'
        // 3. increase opacity of next_fs to 1 as it moves in
        opacity = 1 - now
        current_fs.css({
          'transform': 'scale(' + scale + ')',
          'position': 'absolute'
        })
        next_fs.css({'left': left, 'opacity': opacity})
      },
      duration: 800,
      complete: function () {
        current_fs.hide()
        animating = false
      },
      // this comes from the custom easing plugin
      easing: 'easeInOutBack'
    })
  })

  $('.previous').click(function () {
    if (animating) return false
    animating = true
    //TEST - linked to prev test in this file
    var that = this
    current_fs = $(that).parent()
    previous_fs = $(that).parent().prev()

    // de-activate current step on progressbar
    $('#progressbar li').eq($('fieldset').index(current_fs)).removeClass('active')

    // show the previous fieldset
    previous_fs.show()
    // hide the current fieldset with style
    current_fs.animate({opacity: 0}, {
      step: function (now, mx) {
        // as the opacity of current_fs reduces to 0 - stored in "now"
        // 1. scale previous_fs from 80% to 100%
        scale = 0.8 + (1 - now) * 0.2
        // 2. take current_fs to the right(50%) - from 0%
        left = ((1 - now) * 50) + '%'
        // 3. increase opacity of previous_fs to 1 as it moves in
        opacity = 1 - now
        current_fs.css({'left': left})
        previous_fs.css({'transform': 'scale(' + scale + ')', 'opacity': opacity})
      },
      duration: 800,
      complete: function () {
        current_fs.hide()
        animating = false
      },
      // this comes from the custom easing plugin
      easing: 'easeInOutBack'
    })
  })



  var recipe_ingredient_array = []
  $('.add-row').click(function () {
    var name = $('#name').val()
    var quantity = parseFloat($('#quantity').val())
    var ingredientcategory = $('#ingredient-category').val()
    var ingredientFound = recipe_ingredient_array.map(function (item) { return item.ing }).indexOf(name)
    if (ingredientFound >= 0) {
      recipe_ingredient_array[ingredientFound].qty += quantity
      var newqty = recipe_ingredient_array[ingredientFound].qty
      remove_ingredient_row('createrecipe' + name)
      add_ingredient_row(name, newqty, ingredientcategory)
    } else {
      add_ingredient_row(name, quantity, ingredientcategory)
      recipe_ingredient_array.push({
        ing: name,
        qty: quantity
      })
    }
    console.log(recipe_ingredient_array)
  })

  // Find and remove selected table rows
  $('.delete-row').click(function () {
    $('table tbody').find('input[name="record"]').each(function () {
      if ($(this).is(':checked')) {
        $(this).parents('tr').remove()
        var removeIngredient = $(this).val()
        var removeIndex = recipe_ingredient_array.map(function (item) { return item.ing }).indexOf(removeIngredient)
        if (removeIndex >= 0) {
          recipe_ingredient_array.splice(removeIndex, 1)
        }
      }
    })
    console.log(recipe_ingredient_array)
  })

  function add_ingredient_row (ing, qty, ingcategory) {
    var markup = "<tr><td class=createrecipe" + ing + "><input type='checkbox' name='record' value=" + ing + "></td><td>" + ing + "</td><td>" + qty + "</td><td>" + ingcategory + "</td><td>" + "</td></tr>"
    $('table tbody').append(markup)
  }

  function remove_ingredient_row (ingredientclass) {
    $('.' + ingredientclass).parents('tr').remove()
  }

  $('#instructionArea').keypress(function (e) {
   if (e.which === 13) {
     e.preventDefault()
     this.value = this.value + '\n'
   }
 })

 $('.recipeform').submit(function (e) {
   if (e.keyCode === 13) {
     return false
   }
 })

  $('.submit').click(function () {
    var recipe_ingredient_json = JSON.stringify(recipe_ingredient_array)
    $('#recipe_ingredients').val(recipe_ingredient_json)
  })
})
