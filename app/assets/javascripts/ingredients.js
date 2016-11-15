$(document).on('turbolinks:load', function () {
 $('#searchform').on('ajax:success', function (e, data, status) {
   $('.searchcontainer').text('')
   data.result.forEach(function (movie) {
     var newList = $('<li>')
     var newButton = $('<button class="add-ing" type="submit"><p>Add Ingredient</p>')
     newList.text(movie.fields.item_name)
     newButton.attr('value', movie.fields.item_id)
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
