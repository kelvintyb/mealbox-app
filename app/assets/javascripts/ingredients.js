$(document).on('turbolinks:load', function () {
  $('#searchform').on('ajax:success', function (e, data, status) {
    $('.searchcontainer').text('')
    console.log(data.result)
      var i = 1;
    data.result.forEach(function (movie) {
      var newList = $('<li>')
      var newButton = $('<button class="add-ing"><p>Add Ingredient</p>')
      newList.text(movie.fields.item_name)
      newList.addClass("nutriApi" + (i));
      newList.attr('data-id', JSON.stringify(movie.fields));
        $('.searchcontainer').append(newList)
        newList.append(newButton)
        i++;
    })

  $('.add-ing').on('click', function () {
    // $(this).data
    console.log($(this).data)
})



  })
})
