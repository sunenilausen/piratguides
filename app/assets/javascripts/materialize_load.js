$(document).on('turbolinks:load', function() {
  window.materializeForm.init()
});

$(document).on("click", ".select-wrapper", function (event) {
  event.stopPropagation();
});
