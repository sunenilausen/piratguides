import scratchblocks from "scratchblocks";

$(document).on('turbolinks:load', function(e) {
  scratchblocks.renderMatching('.language-blocks3', {
    style:     'scratch3',   // Optional, defaults to 'scratch2'.
    languages: ['en'], // Optional, defaults to ['en'].
  });
});
