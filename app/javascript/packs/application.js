import ujs from "@rails/ujs";
import "bootstrap/dist/js/bootstrap.bundle";

import "@fortawesome/fontawesome-free/js/fontawesome";
import "@fortawesome/fontawesome-free/js/regular";
import "@fortawesome/fontawesome-free/js/solid";
import "@fortawesome/fontawesome-free/js/brands";

import ClipboardJS from "clipboard/dist/clipboard";

import "../stylesheets/application.scss";

ujs.start();

$(() => {
  var copyRSSURL = new ClipboardJS(".js-copy-rss-url");
  copyRSSURL.on("success", () => $("#rss-url-instructions").modal("show"));

  $("[data-toggle=tooltip]").tooltip();
});
