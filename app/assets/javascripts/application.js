// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require_self

$(function() {

  function emojiPicked(el) {
    var shoutId = el.data('shout-id');

    return function(emoji) {
      $.post('/shouts/' + shoutId + '/reactions', { emoji: emoji });
    }
  };

  function handleEmojiForShouts(selector) {
    $(selector).each(function() {
      $(this).find('.reactions--button').emojiPicker({ emojiPicked: emojiPicked($(this)) })
    });
  };

  handleEmojiForShouts('.shout');
});
