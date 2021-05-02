
$(document).on('turbolinks:load', function () {
  function resizeTab() {
    $(".carousel").css('height', $('.carousel-item.active').height() + 80 + 'px');
  }
  $('.carousel').carousel({ fullWidth: true, indicators: true, nowrap: true, onCycleTo: resizeTab });
  $(window).resize(function () { resizeTab(); });
  $('.next-carousel').click(function() {
    $(this).closest('.carousel').carousel('next');
  })
  $('.previous-carousel').click(function () {
    $(this).closest('.carousel').carousel('prev');
  })
});
