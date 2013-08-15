// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require underscore-1.4.4
//= require backbone.min
//= require Backbone.ModelBinder.v.1.0.2
//= require live
//= require jquery.maskedinput
//= require_tree ./form
// require_tree .

$(document)
  .foundation()
  // .foundation("topbar", {is_hover: false, custom_back_text: true, back_text: 'назад'}); 

// $(function(){ 
//   $(document).foundation(
//     "topbar", {is_hover: false, custom_back_text: true, back_text: 'назад'}
//   ); 
// });
