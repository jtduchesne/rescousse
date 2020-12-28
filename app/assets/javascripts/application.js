//= require rails-ujs
//= require turbolinks
//
//= require searchbox.js
//
//= require_directory .

document.addEventListener("turbolinks:load", function() {
  $('#toaster > .toast').toast('show');
});
