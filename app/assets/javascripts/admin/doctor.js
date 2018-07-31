const SEARCH_KEY = 'search';

$(document).on('turbolinks:load', () => {
  $('#search-doctor').submit(event => {
    event.preventDefault();
    let searchKey = encodeURIComponent($('#search-input').val());
    location.href = urlAddParameter(location.href, SEARCH_KEY, searchKey);
  });
});
