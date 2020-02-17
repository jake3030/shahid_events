// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require rails-ujs
//= require jquery3
//= require moment/moment
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require activestorage
//= require turbolinks
//= require_tree .

window.fetch_events = function(cb) {
  url = window.location.href + ".json"
  fetch(url)
  .then((response) => {
    return response.json();
  })
  .then((myJson) => {
    window.events = myJson;
    cb(window.events)
  });
}


$(function(){
  $(".event-item").on("mouseover", (e) => {
    obj = markers[$(e.currentTarget).data("event-id")]
    obj.info.open(map, obj.marker)
  }).on("mouseout", (e) => {
    markers[$(e.currentTarget).data("event-id")].info.close()
  })
})