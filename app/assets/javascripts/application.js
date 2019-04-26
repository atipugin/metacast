//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require clipboard

$(document).ready(function() {
  var copyRSSURL = new Clipboard(".js-copy-rss-url");
  copyRSSURL.on("success", function(event) {
    $("#rss-url-instructions").modal("show");
  });

  $("[data-toggle=tooltip]").tooltip();
});
