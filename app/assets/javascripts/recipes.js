var current_fs, next_fs, previous_fs // fieldsets
var left, opacity, scale // fieldset properties which we will animate
var animating; // flag to prevent quick multi-click glitches


$(document).on('turbolinks:load', function () {

  var $grid = $('.masonry-container').imagesLoaded( function() {
    $grid.masonry({
      itemSelector: '.grid-item',
      percentPosition: true,
      columnWidth: '.grid-sizer',
      gutter: 20
    });
  });

    $(function() {
      $('.mealbox-flasher').delay(2500).fadeOut();
    });

    $('.recipemaker-panel .dropdown-menu').find('a').click(function(e) {
		e.preventDefault();
		var param = $(this).attr("href").replace("#","");
		var concept = $(this).text();
		$('.recipemaker-panel span#recipemaker_concept').text(concept);
		$('.input-group #recipemaker_param').val(param);
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

//   1) load all ingredients in the controller first using gon
// 2) on click of cuisine dropdown-menu, empty all select options in ingredients dropdown-menu and populate with ingredients that match the cuisine selected
  $('#cuisine-dropdown').on("click", function(){
    function option_creator(ing_obj){
      return "<option value=\"" + ing_obj.name + "," + ing_obj.qtyunit + "," + ing_obj.category + "\">" + ing_obj.name + " (" + ing_obj.qtyunit + ")" + "</option>"
    }
    var $category_param = $("#recipemaker_param").val().toLowerCase();
    var ingredient_arr = gon.ingredients
    var ingredient_dropdown = $("#ingredient")

    $("#ingredient").empty();
    ingredient_arr.forEach(function(ing_obj){
      if (ing_obj.category.toLowerCase() == $category_param){
        ingredient_dropdown.append(option_creator(ing_obj))
      }
    })
  })

  // store recipe ingredients in array
  var recipe_ingredient_array = []
  // user click add ingredient, prevent Submit
  // ingredient value format => ingredient,unit
  // store front end values in variables
  // NOTE no validation when user does not input a qty
  $('.add-row').click(function (e) {
    e.preventDefault()
    if ($('#ingredient').val()) {
      var ingredient = $('#ingredient').val().split(',')
      var name = ingredient[0]
      var ingclass = name.split(' ').join('')
      var unit = ingredient[1]
      var quantity = parseFloat($('#quantity').val())
      var ingredientcategory = ingredient[2]
      if (quantity && ingredientcategory && quantity > 0) {
        // map array and get index of ingredient
        // if duplicate ing in array, add qty to ing
        // remove and add row to show updates
        var ingredientFound = recipe_ingredient_array.map(function (item) { return item.ing }).indexOf(name)
        if (ingredientFound >= 0) {
          recipe_ingredient_array[ingredientFound].qty += quantity
          var newqty = recipe_ingredient_array[ingredientFound].qty
          remove_ingredient_row('createrecipe' + ingclass)
          add_ingredient_row(ingclass, name, unit, newqty, ingredientcategory)
        } else {
          // if no duplicate ing, add row and push to array
          add_ingredient_row(ingclass, name, unit, quantity, ingredientcategory)
          recipe_ingredient_array.push({
            ing: name,
            qty: quantity
          })
        }
        console.log(recipe_ingredient_array)
      }
    }
  })

  // append ingredient row function
  // class createrecipe + ing so can remove by class
  // store ing value in delete button to delete in table
  function add_ingredient_row (class_ing, ing, unit, qty, category) {
    var markup = "<tr><td class='createrecipe" + class_ing + "'>" + ing + ' (' + unit + ")</td><td>" + category + "</td><td>" + qty + "</td><td><button type='button' class='btn btn-danger btn-xs glyphicon glyphicon-remove delete-row' value=" + ing + "></button></td></tr>"
    $('.createrecipetable tbody').append(markup)
  }

  // remove ingredient row function
  function remove_ingredient_row (class_ing) {
    $('.' + class_ing).parents('tr').remove()
  }

  // .delete-row class does not exist on page yet, so must tag to a parent class
  // map and get index of the delete value
  // remove ing from  array and remove row
  $('.createrecipetable').on('click', '.delete-row', function (e) {
    var removeIngredient = $(this).val()
    var removeIndex = recipe_ingredient_array.map(function (item) { return item.ing }).indexOf(removeIngredient)
    if (removeIndex >= 0) {
      recipe_ingredient_array.splice(removeIndex, 1)
    }
    $(this).parents('tr').remove()
  })

  // on create recipe instructions, when enter press, prevent default submit form and add newline instead
  $('#instructionArea').keypress(function (e) {
    if (e.which === 13) {
      e.preventDefault()
      var newline_count = this.value.split(/\r\n|\r|\n/).length + 1
      this.value = this.value + '\n' + 'Step ' + newline_count + ': '
    }
  })

  // NOTE still can press enter when you're typing in a textbox
  // prevent enter button default submit form
 $('.recipeform').submit(function (e) {
   if (e.keyCode === 13) {
     return false
   }
 })
  // when submit clicked, stringify ingredient array as json string cause form only accept string as value...
  // tag string to form hidden tag value for controller to receive
  $('.submit').click(function () {
    var recipe_ingredient_json = JSON.stringify(recipe_ingredient_array)
    $('#recipe_ingredients').val(recipe_ingredient_json)
  })
})
