$(document).on('turbolinks:load', () => {
  $('.grid').masonry({
    // options...
    itemSelector: '.grid-item',
  });

  medicineInfos = getMedicineInfoArray();

  $('.show-all').click(function (event) {
    event.preventDefault();
    medicineInfos.forEach(ele => {
      ele.removeClass('hide')
    });
  });

  $('.hide-other-trigger').each(function () {
    $(this).click(function (event) {
      event.preventDefault();
      let name = $(this).attr('data');
      medicineInfos.forEach(info => {
        info.addClass('hide');
      });
      $(`.drug-${name}`).removeClass('hide');
    });
  })
});


getMedicineInfoArray = () => {
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
