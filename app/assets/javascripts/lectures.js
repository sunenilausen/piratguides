$(document).on('turbolinks:load', function() {
  $("#article_insertions > .links").on("cocoon:after-insert",
    function () {
      $(".article-add-association").first().click();
      $(".article-add-association").first().remove();
      window.materializeForm.init();
    });
});
