$(document).on('turbolinks:load', function () {
  var textAutoResize = $('.auto_resize');

  $('.btn_show_comment').each(function (index) {
    $(this).on('click', function () {
      var id = $(this).data('item')
      toggleComment(id, false)
    });
  });

  $('.mf_show_options').on('click', function (e) {
    var menuOptions = $('.mf_category_options');
    if (menuOptions.hasClass('show')) {
      menuOptions.removeClass('show')
    } else {
      menuOptions.addClass('show')
    }
  })

  $('.menu_button').on('click', function () {
    var menu = $(this).children('.menu_dropdown');
    if (!menu.hasClass('show')) {
      menu.addClass('show')
    } else {
      menu.removeClass('show')
    }
  });

  $('.mf_category_list ul li').each(function () {
    $(this).on('click', function () {
      var data = $(this).children('a');

      if (!data.data('added')) {
        $(this).addClass('selected')
        $('.mf_float_categories_list ul').append('\
          <li id=\"float-categories-'+ data.data('id') + '\">\
            <a href=\"javascript:void(0)\">'+ data.data('name') + '</a>\
          </li>'
        );
        data.data('added', true)
      } else {
        $(this).removeClass('selected')
        $('#float-categories-' + data.data('id')).remove();
        data.data('added', false)
      }
      var listItems = $('.mf_float_categories_list ul li');
      var tag = $('.mf_float_categories_list .tag')

      if (listItems.length > 0) {
        if (!tag.hasClass('show'))
          tag.addClass('show')
      } else {
        if (tag.hasClass('show'))
          tag.removeClass('show')
      }

      $('.create_question_form').append(
        '<input multiple=\"multiple\"\
          value=\"'+ data.data('id') + '\" type=\"hidden"\
          name=\"question[category_ids][]\"\
          id=\"question_categories\">'
      )
    });
  })

  textAutoResize.keydown(autosize);

  function autosize(e) {
    var el = this;
    setTimeout(function () {
      el.style.cssText = 'height:auto; padding:0';
      el.style.cssText = 'height:' + el.scrollHeight + 'px';
    }, 0);
  }

  var wowAnimation = new WOW({
    boxClass: 'wow',
    animateClass: 'animated',
    offset: 0,
    mobile: true,
    live: true,
    scrollContainer: null
  });
  wowAnimation['init']();
});

function removeContentReply(id) {
  $('.mf_reply_field.question-' + id).val('')
};

function toggleComment(id, isPost) {
  var commentContent = $('#questions-item-' + id)
  if (commentContent.hasClass('show') && !isPost) {
    commentContent.removeClass('show')
  } else {
    commentContent.addClass('show')
  }
};
