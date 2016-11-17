$(document).on('turbolinks:load', function () {
$('#searchform').on('ajax:success', function (e, data, status) {
  $('.searchcontainer').text('')
  if (data.found !== 'not found') {
      $('.searchcontainer').append("<h2>Ingredient found in our database!</h2>")
  }
  if (data.result.length === 0) {
      $('.searchcontainer').append("<h2>Result not found!</h2>")
  }
  data.result.forEach(function (ingredient) {
    var newList = $('<li>')
    var newButton = $('<button class="add-ing" type="submit"><p>Add Ingredient</p>')
    newList.text(ingredient.fields.item_name)
    newButton.attr('value', ingredient.fields.item_id)
    $('.searchcontainer').append(newList)
    newList.append(newButton)
  })

  $('button.add-ing').on('click', function () {
    var ing_details = $(this).val()
    $('#nutri_id').val(ing_details)
    console.log(ing_details)
  })
})
})
