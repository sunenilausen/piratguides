$(document).on('turbolinks:load', function() {


  var header     = document.querySelector("#shrink-app-header");
  if (!header) { return }
  var bgBack     = document.querySelector("#shrink-background-back");
  var bgFront    = document.querySelector("#shrink-background-front");
  var toolbar    = document.querySelector("#shrink-small-toolbar");
  var largeTitle = document.querySelector("#shrink-large-title");
  var smallTitle = document.querySelector("#shrink-small-title");

  TweenLite.defaultEase = Linear.easeNone;

  var deltaHeight = header.offsetHeight - toolbar.offsetHeight;

  var rect1 = smallTitle.getBoundingClientRect();
  var rect2 = largeTitle.getBoundingClientRect();

  var scale = rect1.height / rect2.height;
  var x = rect1.left - rect2.left;
  var y = rect1.top  - rect2.top;

  var headerAnimation = new TimelineLite({ paused: true })
    .to(largeTitle, 1, { scale: scale, x: x, y: deltaHeight + y }, 0)
    .to(header,  1, { y: -deltaHeight }, 0)
    .to(toolbar, 1, { y: deltaHeight }, 0)
    .to(bgBack,  1, { y: deltaHeight / 2 }, 0)
    .to(bgFront, 1, { y: deltaHeight / 2 }, 0)
    .to(bgBack,  1, { alpha: 1 }, 0)
    .to(bgFront, 1, { alpha: 0 }, 0)
    .set(smallTitle, { alpha: 1 }, 1)
    .set(largeTitle, { alpha: 0 }, 1);

  var shadowAnimation = TweenLite.to(header, 0.4, { 
    boxShadow: "0 2px 5px rgba(0,0,0,0.6)",
    ease: Power1.easeOut
  }).reverse();

  var progress  = 0;
  var requestId = null;
  var reversed  = true;

  update();
  window.addEventListener("scroll", requestUpdate);

  function requestUpdate() {
    if (!requestId) {
      requestId = requestAnimationFrame(update);
    }
  }

  function update() {
    
    var scroll = window.pageYOffset;
    
    if (scroll < deltaHeight) {   
      progress = scroll < 0 ? 0 : scroll / deltaHeight;
      reversed = true;
    } else {
      progress = 1;
      reversed = false;
    }
    
    headerAnimation.progress(progress);
    shadowAnimation.reversed(reversed);
    
    requestId = null;
  }
});