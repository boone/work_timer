$(function() {
  setInterval(function() {
    $.get('events/current', function(data) {
      $('#status').html(data);
    });
  }, 30000);
});
