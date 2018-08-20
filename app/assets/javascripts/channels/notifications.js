App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function () {
  },
  disconnected: function () {
  },
  received: function (data) {
    $count = $('#notifications-count');
    let count = parseInt($count.text()) + 1;
    $count.text(count);
    $('#notifications-list').prepend(data.html);
  }
});

