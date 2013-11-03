//= require jquery
//= require jquery_ujs
//= require_self

$(function() {
  setInterval(function() {
    $.get('/events/current', function(data) {
      $('#status').html(data);
      if ($('.time')) document.title = $('.time').html() + '- Work Timer';
    });
  }, 30000);
  if ($('#flash').length > 0) {
    setTimeout(function() {
      $('#flash').slideUp();
    }, 10000);
  }

  $('#exclude').click(function() {
    $('#report').find('.no_data').toggle();
  });
});
