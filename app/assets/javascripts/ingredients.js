$(document).on('turbolinks:load', function () {

  // when admin search ingredient query successful, empty previous results
  // if there is an ing with the same name, append h2 warning
  // if there are no search results, append h2 warning
  $('#searchform').on('ajax:success', function (e, data, status) {
    $('.searchcontainer').text('')
    if (data.found !== 'not found') {
      $('.searchcontainer').append('<h2>Ingredient found in our database!</h2>')
    }
    if (data.result.length === 0) {
      $('.searchcontainer').append('<h2>Result not found!</h2>')
    }
    // append the 5 search results
    data.result.forEach(function (ingredient) {
      var newList = $('<li>')
      var newButton = $('<button class="add-ing" type="submit"><p>Add Ingredient</p>')
      newList.text(ingredient.fields.item_name)
      newButton.attr('value', ingredient.fields.item_id)
      $('.searchcontainer').append(newList)
      newList.append(newButton)
    })
    // when admin wants to add ingredient, send the ing nutri id to the search_ingredient by POST, redirected to show in ing controller for second api call
    $('button.add-ing').on('click', function () {
      var ing_details = $(this).val()
      $('#nutri_id').val(ing_details)
    })
  })
})
