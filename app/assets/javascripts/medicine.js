$(document).on('turbolinks:load', function() {
  $('.grid').masonry({
    itemSelector: '.grid-item',
  });

  medicineInfos = getMedicineInfoArray();

  $('.show-all').click(function (event) {
    event.preventDefault();
    medicineInfos.forEach(function(ele) {
      ele.removeClass('hide')
    });
  });

  $('.hide-other-trigger').each(function () {
    $(this).click(function (event) {
      event.preventDefault();
      var name = $(this).attr('data');
      medicineInfos.forEach(function(info) {
        info.addClass('hide');
      });
      $('.drug-' + name).removeClass('hide');
    });
  })
});


getMedicineInfoArray = function() {
  medicineInfos = [];
  medicineInfos.push($('.drug-instruction'));
  medicineInfos.push($('.drug-info'));
  medicineInfos.push($('.drug-warning'));
  medicineInfos.push($('.drug-contraindication'));
  medicineInfos.push($('.drug-side-effect'));
  medicineInfos.push($('.drug-note'));
  medicineInfos.push($('.drug-overdose'));
  medicineInfos.push($('.drug-preservation'));
  return medicineInfos;
};
