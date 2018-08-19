var CalendarList = [];
var ScheduleList = [];

$(document).on('turbolinks:load', function () {
  var textAutoResize = $('.auto_resize');

  $('.btn_show_comment').each(function (index) {
    $(this).on('click', function (event) {
      event.preventDefault();
      var id = $(this).data('item')
      toggleComment(id, false)
    });
  });

  $('#toTop').on('click', function () {
     $('body,html').animate({
       scrollTop: 0
     }, 800);
    return false;
  });

  $('.mf_show_options').on('click', function (event) {
    event.preventDefault();
    var menuOptions = $('.mf_category_options');
    if (menuOptions.hasClass('show')) {
      menuOptions.removeClass('show')
    } else {
      menuOptions.addClass('show')
    }
  })

  $('.menu_button').on('click', function (event) {
    event.preventDefault();
    var menu = $(this).children('.menu_dropdown');
    if (!menu.hasClass('show')) {
      menu.addClass('show')
    } else {
      menu.removeClass('show')
    }
  });

  $('.mf_category_list ul li').each(function () {
    $(this).on('click', function (event) {
      event.preventDefault();
      var data = $(this).children('a');

      if (!data.data('added')) {
        $(this).addClass('selected')
        $('.mf_float_categories_list ul').append('\
          <li id=\"float-categories-'+ data.data('id') + '\">\
            <a href=\"#\">'+ data.data('name') + '</a>\
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

  $('.mf_comment--delete').each(function(){
    deleteCommentEvent(this)
  });

  textAutoResize.keydown(autosize);

  function autosize(e) {
    var el = this;
    setTimeout(function () {
      el.style.cssText = 'height:auto; padding:0';
      el.style.cssText = 'height:' + el.scrollHeight + 'px';
    }, 0);
  }

  $('.mf_auto_complete').on('input', _.debounce(showQuery, 1000,
    { 'maxWait': 1000 }));

  var wowAnimation = new WOW({
    boxClass: 'wow',
    animateClass: 'animated',
    offset: 0,
    mobile: true,
    live: true,
    scrollContainer: null
  });

  wowAnimation['init']();

  $(document).click(function(event) {
    if($('.mf_search--suggest').hasClass('show')) {
      $('.mf_search--suggest').removeClass('show')
    }
  });

  if($('#calendar').length > 0)
    initCalendar();

  initConversationEvents($('.chat_header'))

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


var showQuery = function () {
  $.ajax({
    type: 'GET',
    url: '/searchs.json?query=' + encodeURI($('.mf_auto_complete').val()),
    success: function (response, textStatus, jqXHR) {
      showSuggest(response)
    },
    error: function (jqXHR, textStatus, errorThrown) {

    }
  })
}

function showSuggest(data){
  var list = $('.mf_search--autocomplete');
  var cotent = ""
  for(var i = 0 ; i < data.length ; i++){
    cotent += '<li><a href=\"'+data[i].link+'\">'+data[i].suggest+'</a>'
  }
  list.html(cotent);
  if(data.length > 0){
    $('.mf_search--suggest').addClass('show')
  }
}


function initCalendar(){
  var cal, resizeThrottled;
  var useCreationPopup = true;
  var useDetailPopup = true;
  var datePicker, selectedCalendar;

  cal = new tui.Calendar('#calendar', {
    defaultView: 'week',
    useCreationPopup: useCreationPopup,
    useDetailPopup: useDetailPopup,
    template: {
      milestone: function(model) {
        return '<span class="calendar-font-icon ic-milestone-b"></span>'
          +'<span style="background-color: ' + model.bgColor + '">'
          + model.title + '</span>';
      },
      allday: function(schedule) {
        return getTimeTemplate(schedule, true);
      },
      time: function(schedule) {
        return getTimeTemplate(schedule, false);
      }
    },
    week: {
      showTimezoneCollapseButton: true,
      timezonesCollapsed: false
    }
  });

  cal.on({
      'clickSchedule': function(e) {
        console.log('clickSchedule', e);
      },
      'clickDayname': function(date) {
        console.log('clickDayname', date);
      },
      'beforeCreateSchedule': function(e) {
        saveNewSchedule(e);
      },
      'beforeUpdateSchedule': function(e) {
        e.schedule.start = e.start;
        e.schedule.end = e.end;
        e.schedule.calendarId = 1;
        updateSchedule(e.schedule)
        cal.updateSchedule(e.schedule.id, e.schedule.calendarId, e.schedule);
      },
      'beforeDeleteSchedule': function(e) {
          console.log('beforeDeleteSchedule', e);
          deleteSchedule(e.schedule)
          cal.deleteSchedule(e.schedule.id, e.schedule.calendarId);
      },
      'afterRenderSchedule': function(e) {
          var schedule = e.schedule;
          // var element = cal.getElement(schedule.id, schedule.calendarId);
          // console.log('afterRenderSchedule', element);
      },
      'clickTimezonesCollapseBtn': function(timezonesCollapsed) {
        console.log('timezonesCollapsed', timezonesCollapsed);
        if (timezonesCollapsed) {
          cal.setTheme({
            'week.daygridLeft.width': '77px',
            'week.timegridLeft.width': '77px'
          });
        } else {
          cal.setTheme({
            'week.daygridLeft.width': '60px',
            'week.timegridLeft.width': '60px'
          });
        }

        return true;
      }
  });

  function getTimeTemplate(schedule, isAllDay) {
    var html = [];
    var start = moment(schedule.start.toUTCString());
    if (!isAllDay) {
      html.push('<strong>' + start.format('HH:mm') + '</strong> ');
    }
    if (schedule.isPrivate) {
      html.push('<span class="calendar-font-icon ic-lock-b"></span>');
      html.push('Private');
    } else {
      if (schedule.isReadOnly) {
        html.push('<span class="calendar-font-icon ic-readonly-b"></span>');
      } else if (schedule.recurrenceRule) {
        html.push('<span class="calendar-font-icon ic-repeat-b"></span>');
      } else if (schedule.attendees.length) {
        html.push('<span class="calendar-font-icon ic-user-b"></span>');
      } else if (schedule.location) {
        html.push('<span class="calendar-font-icon ic-location-b"></span>');
      }
      html.push(' ' + schedule.title);
    }
    return html.join('');
  }

  function onClickMenu(e) {
    var target = $(e.target).closest('a[role="menuitem"]')[0];
    var action = getDataAction(target);
    var options = cal.getOptions();
    var viewName = '';
    switch (action) {
      case 'toggle-daily':
          viewName = 'day';
          break;
      case 'toggle-weekly':
          viewName = 'week';
          break;
      case 'toggle-monthly':
          options.month.visibleWeeksCount = 0;
          viewName = 'month';
          break;
      case 'toggle-weeks2':
          options.month.visibleWeeksCount = 2;
          viewName = 'month';
          break;
      case 'toggle-weeks3':
          options.month.visibleWeeksCount = 3;
          viewName = 'month';
          break;
      case 'toggle-narrow-weekend':
          options.month.narrowWeekend = !options.month.narrowWeekend;
          options.week.narrowWeekend = !options.week.narrowWeekend;
          viewName = cal.getViewName();
          target.querySelector('input').checked = options.month.narrowWeekend;
          break;
      case 'toggle-start-day-1':
          options.month.startDayOfWeek = options.month.startDayOfWeek ? 0 : 1;
          options.week.startDayOfWeek = options.week.startDayOfWeek ? 0 : 1;
          viewName = cal.getViewName();

          target.querySelector('input').checked = options.month.startDayOfWeek;
          break;
      case 'toggle-workweek':
          options.month.workweek = !options.month.workweek;
          options.week.workweek = !options.week.workweek;
          viewName = cal.getViewName();

          target.querySelector('input').checked = !options.month.workweek;
          break;
      default:
          break;
    }

    cal.setOptions(options, true);
    cal.changeView(viewName, true);

    setDropdownCalendarType();
    setRenderRangeText();
    setSchedules();
  }

  function onClickNavi(e) {
    var action = getDataAction(e.target);
    switch (action) {
        case 'move-prev':
            cal.prev();
            break;
        case 'move-next':
            cal.next();
            break;
        case 'move-today':
            cal.today();
            break;
        default:
            return;
    }
    setRenderRangeText();
    setSchedules();
  }

  function onNewSchedule() {
      var title = $('#new-schedule-title').val();
      var location = $('#new-schedule-location').val();
      var isAllDay = document.getElementById('new-schedule-allday').checked;
      var start = datePicker.getStartDate();
      var end = datePicker.getEndDate();
      var calendar = selectedCalendar ? selectedCalendar : CalendarList[0];

      if (!title) {
        return;
      }

      cal.createSchedules([{
        id: String(chance.guid()),
        calendarId: calendar.id,
        title: title,
        isAllDay: isAllDay,
        start: start,
        end: end,
        category: isAllDay ? 'allday' : 'time',
        dueDateClass: '',
        color: calendar.color,
        bgColor: calendar.bgColor,
        dragBgColor: calendar.bgColor,
        borderColor: calendar.borderColor,
        raw: {
          location: location
        },
        state: 'Busy'
      }]);

      $('#modal-new-schedule').modal('hide');
  }

  function onChangeNewScheduleCalendar(e) {
    var target = $(e.target).closest('a[role="menuitem"]')[0];
    var calendarId = getDataAction(target);
    changeNewScheduleCalendar(calendarId);
  }

  function changeNewScheduleCalendar(calendarId) {
    var calendarNameElement = document.getElementById('calendarName');
    var calendar = findCalendar(calendarId);
    var html = [];

    html.push('<span class="calendar-bar" style="background-color: ' + calendar.bgColor + '; border-color:' + calendar.borderColor + ';"></span>');
    html.push('<span class="calendar-name">' + calendar.name + '</span>');

    calendarNameElement.innerHTML = html.join('');

    selectedCalendar = calendar;
  }

  function createNewSchedule(event) {
      var start = event.start ? new Date(event.start.getTime()) : new Date();
      var end = event.end ? new Date(event.end.getTime()) : moment().add(1, 'hours').toDate();
      if (useCreationPopup) {
        cal.openCreationPopup({
          start: start,
          end: end
        });
      }
  }

  function saveNewSchedule(scheduleData) {
      var sendData = {
        doctor_id: $('.mf_doctor--details').data('doctor-id'),
        user_id: $('.user_menu').data('user-id'),
        title: scheduleData.title,
        start_time: scheduleData.start.toDate(),
        stop_time: scheduleData.end.toDate(),
        category_id: 1,
        dueDateClass: '',
        location: scheduleData.location,
        reason: scheduleData.description,
        state: scheduleData.state,
        accept: false,
        schedule_type: "time"
      };
      $.ajax({
        type: 'POST',
        url: '/bookings',
        data: {"booking":sendData}
      })
  }

  function updateSchedule(scheduleData) {
    var sendData = {
      start_time: scheduleData.start.toDate(),
      stop_time: scheduleData.end.toDate(),
    };
    $.ajax({
      type: 'POST',
      url: '/bookings/'+scheduleData.id,
      data: {'_method':'PATCH','booking':sendData}
    })
  }

  function deleteSchedule(scheduleData) {
    $.ajax({
      type: 'POST',
      url: '/bookings/'+scheduleData.id,
      data: {'_method':'DELETE'}
    })
  }

  function onChangeCalendars(e) {
    var calendarId = e.target.value;
    var checked = e.target.checked;
    var viewAll = document.querySelector('.lnb-calendars-item input');
    var calendarElements = Array.prototype.
      slice.call(document.querySelectorAll('#calendarList input'));
    var allCheckedCalendars = true;

    if (calendarId === 'all') {
      allCheckedCalendars = checked;

      calendarElements.forEach(function(input) {
          var span = input.parentNode;
          input.checked = checked;
          span.style.backgroundColor = checked ? span.style.borderColor : 'transparent';
      });

      CalendarList.forEach(function(calendar) {
          calendar.checked = checked;
      });
    } else {
      findCalendar(calendarId).checked = checked;

      allCheckedCalendars = calendarElements.every(function(input) {
          return input.checked;
      });

      if (allCheckedCalendars) {
          viewAll.checked = true;
      } else {
          viewAll.checked = false;
      }
    }
    refreshScheduleVisibility();
  }

  function refreshScheduleVisibility() {
    var calendarElements = Array.prototype.slice
    .call(document.querySelectorAll('#calendarList input'));
    CalendarList.forEach(function(calendar) {
      cal.toggleSchedules(calendar.id, !calendar.checked, false);
    });
    cal.render(true);
    calendarElements.forEach(function(input) {
        var span = input.nextElementSibling;
        span.style.backgroundColor = input.checked ? span.style.borderColor : 'transparent';
    });
  }

  function setDropdownCalendarType() {
    var calendarTypeName = document.getElementById('calendarTypeName');
    var calendarTypeIcon = document.getElementById('calendarTypeIcon');
    var options = cal.getOptions();
    var type = cal.getViewName();
    var iconClassName;

    if (type === 'day') {
      type = 'Daily';
      iconClassName = 'calendar-icon ic_view_day';
    } else if (type === 'week') {
      type = 'Weekly';
      iconClassName = 'calendar-icon ic_view_week';
    } else if (options.month.visibleWeeksCount === 2) {
      type = '2 weeks';
      iconClassName = 'calendar-icon ic_view_week';
    } else if (options.month.visibleWeeksCount === 3) {
      type = '3 weeks';
      iconClassName = 'calendar-icon ic_view_week';
    } else {
      type = 'Monthly';
      iconClassName = 'calendar-icon ic_view_month';
    }

    calendarTypeName.innerHTML = type;
    calendarTypeIcon.className = iconClassName;
  }

  function setRenderRangeText() {
    var renderRange = document.getElementById('renderRange');
    var options = cal.getOptions();
    var viewName = cal.getViewName();
    var html = [];
    if (viewName === 'day') {
      html.push(moment(cal.getDate().getTime()).format('YYYY.MM.DD'));
    } else if (viewName === 'month' &&
      (!options.month.visibleWeeksCount || options.month.visibleWeeksCount > 4)) {
      html.push(moment(cal.getDate().getTime()).format('YYYY.MM'));
    } else {
      html.push(moment(cal.getDateRangeStart().getTime()).format('YYYY.MM.DD'));
      html.push(' ~ ');
      html.push(moment(cal.getDateRangeEnd().getTime()).format(' MM.DD'));
    }
    renderRange.innerHTML = html.join('');
  }

  function setSchedules() {
    cal.clear();
    $.ajax({
      type: 'GET',
      url: window.location.href+'/schedules.json',
      success: function (response, textStatus, jqXHR) {
        generateSchedules(response);
        cal.createSchedules(ScheduleList);
        refreshScheduleVisibility();
      }
    })
  }

  function setEventListener() {
    $('#menu-navi').on('click', onClickNavi);
    $('.dropdown-menu a[role="menuitem"]').on('click', onClickMenu);
    $('#lnb-calendars').on('change', onChangeCalendars);
    $('#btn-save-schedule').on('click', onNewSchedule);
    $('#btn-new-schedule').on('click', createNewSchedule);
    $('#dropdownMenu-calendars-list').on('click', onChangeNewScheduleCalendar);
    window.addEventListener('resize', resizeThrottled);
  }

  function getDataAction(target) {
    return target.dataset ? target.dataset.action : target.getAttribute('data-action');
  }


  var SCHEDULE_CATEGORY = [
    'milestone',
    'task'
  ];

  resizeThrottled = tui.util.throttle(function() {
    cal.render();
  }, 50);

  window.cal = cal;

  setDropdownCalendarType();
  setRenderRangeText();
  setSchedules();
  setEventListener();
}

function CalendarInfo() {
  this.id = null;
  this.name = null;
  this.checked = true;
  this.color = null;
  this.bgColor = null;
  this.borderColor = null;
}

function addCalendar(calendar) {
  CalendarList.push(calendar);
}

function findCalendar(id) {
  var found;
  CalendarList.forEach(function(calendar) {
    if (calendar.id === id) {
      found = calendar;
    }
  });
  return found;
}

function hexToRGBA(hex) {
    var radix = 16;
    var r = parseInt(hex.slice(1, 3), radix),
        g = parseInt(hex.slice(3, 5), radix),
        b = parseInt(hex.slice(5, 7), radix),
        a = parseInt(hex.slice(7, 9), radix) / 255 || 1;
    var rgba = 'rgba(' + r + ', ' + g + ', ' + b + ', ' + a + ')';
    return rgba;
}

(function() {
  var calendar;
  var id = 0;

  calendar = new CalendarInfo();
  id += 1;
  calendar.id = String(id);
  calendar.name = 'My Calendar';
  calendar.color = '#ffffff';
  calendar.bgColor = '#9e5fff';
  calendar.dragBgColor = '#9e5fff';
  calendar.borderColor = '#9e5fff';
  addCalendar(calendar);

  calendar = new CalendarInfo();
  id += 1;
  calendar.id = String(id);
  calendar.name = 'Company';
  calendar.color = '#ffffff';
  calendar.bgColor = '#00a9ff';
  calendar.dragBgColor = '#00a9ff';
  calendar.borderColor = '#00a9ff';
  addCalendar(calendar);

  calendar = new CalendarInfo();
  id += 1;
  calendar.id = String(id);
  calendar.name = 'Family';
  calendar.color = '#ffffff';
  calendar.bgColor = '#ff5583';
  calendar.dragBgColor = '#ff5583';
  calendar.borderColor = '#ff5583';
  addCalendar(calendar);

  calendar = new CalendarInfo();
  id += 1;
  calendar.id = String(id);
  calendar.name = 'Friend';
  calendar.color = '#ffffff';
  calendar.bgColor = '#03bd9e';
  calendar.dragBgColor = '#03bd9e';
  calendar.borderColor = '#03bd9e';
  addCalendar(calendar);

  calendar = new CalendarInfo();
  id += 1;
  calendar.id = String(id);
  calendar.name = 'Travel';
  calendar.color = '#ffffff';
  calendar.bgColor = '#bbdc00';
  calendar.dragBgColor = '#bbdc00';
  calendar.borderColor = '#bbdc00';
  addCalendar(calendar);

  calendar = new CalendarInfo();
  id += 1;
  calendar.id = String(id);
  calendar.name = 'etc';
  calendar.color = '#ffffff';
  calendar.bgColor = '#9d9d9d';
  calendar.dragBgColor = '#9d9d9d';
  calendar.borderColor = '#9d9d9d';
  addCalendar(calendar);

  calendar = new CalendarInfo();
  id += 1;
  calendar.id = String(id);
  calendar.name = 'Birthdays';
  calendar.color = '#ffffff';
  calendar.bgColor = '#ffbb3b';
  calendar.dragBgColor = '#ffbb3b';
  calendar.borderColor = '#ffbb3b';
  addCalendar(calendar);

  calendar = new CalendarInfo();
  id += 1;
  calendar.id = String(id);
  calendar.name = 'National Holidays';
  calendar.color = '#ffffff';
  calendar.bgColor = '#ff4040';
  calendar.dragBgColor = '#ff4040';
  calendar.borderColor = '#ff4040';
  addCalendar(calendar);
})();

function ScheduleInfo() {
  this.id = null;
  this.calendarId = null;

  this.title = null;
  this.isAllday = false;
  this.start = null;
  this.end = null;
  this.category = '';
  this.dueDateClass = '';

  this.color = null;
  this.bgColor = null;
  this.dragBgColor = null;
  this.borderColor = null;
  this.customStyle = '';

  this.isFocused = false;
  this.isPending = false;
  this.isVisible = true;
  this.isReadOnly = false;

  this.raw = {
    memo: '',
    hasToOrCc: false,
    hasRecurrenceRule: false,
    location: null,
    class: 'public', // or 'private'
    creator: {
      name: '',
      avatar: '',
      company: '',
      email: '',
      phone: ''
    }
  };
}

function generateSchedule(calendar, raw_schedule) {
  var schedule = new ScheduleInfo();
  schedule.id = raw_schedule.id;
  schedule.calendarId = calendar.id;

  schedule.title = raw_schedule.title;
  schedule.isReadOnly = true;
  generateTime(schedule, new Date(raw_schedule.start), new Date(raw_schedule.end));
  schedule.category = raw_schedule.type
  schedule.isAllday = false
  schedule.isPrivate = false;

  schedule.location = raw_schedule.location;
  schedule.color = calendar.color;
  schedule.bgColor = calendar.bgColor;
  schedule.dragBgColor = calendar.dragBgColor;
  schedule.borderColor = calendar.borderColor;
  schedule.isReadOnly = !(raw_schedule.user_editable || raw_schedule.doctor_editable)
  if (schedule.category === 'milestone') {
    schedule.color = schedule.bgColor;
    schedule.bgColor = 'transparent';
    schedule.dragBgColor = 'transparent';
    schedule.borderColor = 'transparent';
  }
  ScheduleList.push(schedule);
}

function generateTime(schedule, renderStart, renderEnd) {
  schedule.start = renderStart
  schedule.end = renderEnd
}

function generateSchedules(data) {
  ScheduleList.length = 0
  length = data.schedules.length
  for (var i = 0; i < length; i ++) {
    generateSchedule(CalendarList[0], data.schedules[i]);
  }
}

function refreshcalendar(calendar){
  calendar.clear()
  calendar.createSchedules(ScheduleList);
  cal.render(true);
}

function initConversationEvents(conversations){
  conversations.each(function(){
    initConversationEvent($(this))
  })
}

function initConversationEvent(chatFrame){
  chatFrame.on('click',function(event){
    var id = $(this).parents('.chat_frame').data('conversation-id')
    toggleChatContent(id)
  });
}

function toggleChatContent(id){
  var chatContent = $('.chat_content-'+id);
  if(chatContent.hasClass('show')){
    chatContent.removeClass('show')
  } else {
    chatContent.addClass('show')
  }
}

function showChatContent(id){
  var chatContent = $('.chat_content-'+id);
  if(!chatContent.hasClass('show')){
    chatContent.addClass('show')
  }
}

function deleteCommentEvent(selecter){
  $(selecter).on('click',function(){
    swal({
      title: "Bạn có muốn xóa bình luận này không ?",
      icon: "warning",
      buttons: true,
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {
        $.ajax({
          type: "POST",
          url: "/comments/" + $(this).data('id'),
          data: {"_method":"delete"},
          complete: function(){}
        });
        event.preventDefault();
      }
    });
  })
}
