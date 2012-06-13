// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require underscore
//= require backbone
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone/gnugk
//= require faye-browser-min
//= require json2
//
//= require_tree .

$(document).ready(function(){
  var client = new Faye.Client('http://localhost:9292/faye');

  client.subscribe("/statusport/read", function(data) {
    $('.log').prepend('<pre>statusport read: '+JSON.stringify(data, null, '\t')+'</pre>').fadeIn();
  });
  client.subscribe("/statusport/write", function(data) {
    $('.log').prepend('<pre>statusport write: '+JSON.stringify(data, null, '\t')+'</pre>').fadeIn();
  });
  client.subscribe("/sql/response", function(data) {
    $('.log').prepend('<pre>sql response: '+JSON.stringify(data, null, '\t')+'</pre>').fadeIn();
  });
  client.subscribe("/debug/trace", function(data) {
    $('.log').prepend('<pre>debug trace: '+JSON.stringify(data, null, '\t')+'</pre>').fadeIn();
  });
});
