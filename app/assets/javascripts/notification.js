$(document).on('turbolinks:load', function () {
  $('#notifications').click(function (event) {
    $('#notifications-count').text(0);
    var userId = $('#notifications-count').data('user-id');
    $.ajax({
      url: '/notifications/mark_all_as_checked',
      method: 'POST',
      data: {id: userId},
      success: function (data) {
        console.log('Success!');
      }
    })
  });
  $('.noti-a').each(function () {
    var $this = $(this);
    $this.click(function (event) {
      if ($this.data('read')) return;
      event.preventDefault();
      var notiId = $this.data('noti-id');
      $.ajax({
        url: '/notifications/' + notiId,
        method: 'PUT',
        success: function (data) {
          console.log('Success!');
          window.location = $this.attr('href');
        },
        error: function (data) {
          console.log('Failed!');
          window.location = $this.attr('href');
        }
      })
    })
  })
});
