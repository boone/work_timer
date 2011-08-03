$(function() {
  setInterval(function() {
    $.get('events/current', function(data) {
      $('#status').html(data);
    });
  }, 30000);
  if ($('#flash').length > 0) {
    setTimeout(function() {
      $('#flash').slideUp();
    }, 10000);
  }
});
