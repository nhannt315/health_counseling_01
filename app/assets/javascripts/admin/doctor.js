const SEARCH_KEY = 'search';

$(document).on('turbolinks:load', function(){
  $('#search-doctor').submit(function(event) {
    event.preventDefault();
    var searchKey = encodeURIComponent($('#search-input').val());
    location.href = urlAddParameter(location.href, SEARCH_KEY, searchKey);
  });
});
