(function (_0x2ca5x1) {
  'use strict';
  _0x2ca5x1(window)['load'](function () {
    'use strict';
    _0x2ca5x1('[data-loader="circle-side"]')['fadeOut']();
    _0x2ca5x1('#preloader')['delay'](350)['fadeOut']('slow');
    _0x2ca5x1('body')['delay'](350)['css']({
      "\x6F\x76\x65\x72\x66\x6C\x6F\x77": 'visible'
    });
    _0x2ca5x1('.hero_home .content h3, .hero_home .content p, .hero_home .content form ')['addClass']('fadeInUp animated');
    _0x2ca5x1('.hero_home .content .btn_1 ')['addClass']('fadeIn animated');
    _0x2ca5x1('#hero_video .content h3, #hero_video .content p, #hero_video .content form ')['addClass']('fadeInUp animated');
    _0x2ca5x1(window)['scroll']()
  });
  var _0x2ca5x2 = _0x2ca5x1('.header_sticky');
  var _0x2ca5x3 = _0x2ca5x1('#toTop');
  _0x2ca5x1(window)['on']('scroll', function () {
    if (_0x2ca5x1(this)['scrollTop']() > 1) {
      _0x2ca5x2['addClass']('sticky')
    } else {
      _0x2ca5x2['removeClass']('sticky')
    };
    if (_0x2ca5x1(this)['scrollTop']() != 0) {
      _0x2ca5x3['fadeIn']()
    } else {
      _0x2ca5x3['fadeOut']()
    }
  });
  _0x2ca5x3['on']('click', function () {
    _0x2ca5x1('body,html')['animate']({
      scrollTop: 0
    }, 500)
  });
  _0x2ca5x1('a.open_close')['on']('click', function () {
    _0x2ca5x1('.main-menu')['toggleClass']('show');
    _0x2ca5x1('.layer')['toggleClass']('layer-is-visible')
  });
  _0x2ca5x1('a.show-submenu')['on']('click', function () {
    _0x2ca5x1(this)['next']()['toggleClass']('show_normal')
  });
  var _0x2ca5x4 = document['querySelectorAll']('.cmn-toggle-switch');
  for (var _0x2ca5x5 = _0x2ca5x4['length'] - 1; _0x2ca5x5 >= 0; _0x2ca5x5--) {
    var _0x2ca5x6 = _0x2ca5x4[_0x2ca5x5];
    _0x2ca5x7(_0x2ca5x6)
  };

  function _0x2ca5x7(_0x2ca5x6) {
    _0x2ca5x6['addEventListener']('click', function (_0x2ca5x8) {
      _0x2ca5x8['preventDefault']();
      (this['classList']['contains']('active') === true) ? this['classList']['remove']('active') : this['classList']['add']('active')
    })
  }
})(window['jQuery'])
