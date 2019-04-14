//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require clipboard

$(document).ready(function() {
  new Clipboard(".js-clipboard");
  $("[data-toggle=tooltip]").tooltip();
});
