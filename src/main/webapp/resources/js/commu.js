// a href="#" 막기
$('a[href="#"]').on('click', function (ignore) {
    ignore.preventDefault();
});

// dim 클릭 이벤트
$('.dim').on('click', function () {
    $('.lnb, .popup__email, .js--email').removeClass('active');
    $('.dim, .popup, .info--lv, .info--rank').hide();
});

// lnb 열기
$('.btn--nav').on('click', function () {
    $('.lnb').addClass('active');
    $('.dim').show();
});

// lnb 닫기
$('.btn--close').on('click', function () {
    $('.lnb').removeClass('active');
    $('.dim').hide();
});

// 플로팅 배너 맨 위로 이동하는 버튼
$('.js--scroll-top').on('click', function () {
    $('html, body').animate({ scrollTop: 0 }, 400);
});

// 팝업 닫기 버튼
$('.js--popup-close').on('click', function () {
    $('.popup, .dim').hide();
});

// 글 작성 영역 카테고리 열기
$('.js--select-active').on('click', function () {
    $('.js--select-active').toggleClass('active');
});

// 헤더 검색창 열고 닫기
$('.js--header-search').on('click', function () {
    $(this).parent().toggleClass('active');
});

// 프로필 팝업 열기
$('.js--profile').on('click', function () {
    $('.popup--profile, .dim').show();
});

// 로그인 팝업 열기
$('.js--login').on('click', function () {
    $('.popup--login, .dim').show();
});

// 로그인 팝업 > 이메일 로그인 토글
$('.js--email').on('click', function () {
    $(this).toggleClass('active');
    $('.popup__email').toggleClass('active');
});

// 닉네임 팝업 열기
$('.js--nickname').on('click', function () {
    $('.popup--nickname, .dim').show();
});

// 유저 팝업 열기
$('.js--user').on('click', function () {
    $('.popup--user, .dim').show();
});

// 좋아요 버튼
$('.js--like').on('click', function () {
    $(this).toggleClass('active');
});

// 헤더 언어 열기
$('.js--language').on('click', function (e) {
    var $this = $(this),
        $href = $('.language'),
        $top = $this.offset().top;

    if (window.innerWidth <= 1741) {
        var $left = $this.offset().left - 40;
    } else {
        var $left = $this.offset().left - 30;
    }

    var config = {
        tooltipstyle: {
            position: 'absolute',
            top: $top,
            left: $left,
            zIndex: 9999
        }
    };

    $($href).css(config.tooltipstyle);
    $($href).show();
});

// 헤더 언어 닫기
$('.language').on('mouseleave', function () {
    $(this).hide();
});

// 푸터 열기 닫기
$('.btn--open').on('click', function () {
    $(this).toggleClass('active');
    $('.footer').toggleClass('active');
});

// 푸터 다른 언어 페이지로 이동하는 셀렉트 열기
$('.footer__select li').on('click', function () {
    $(this).siblings('.footer__select li').toggleClass('active');
});

(function () {
    // 플로팅 버튼
    if ($('.floating').length) {
        var $window = $(window),
            footerHeight = $('.footer').outerHeight(),
            $floating = $('.floating');

        $window.on('scroll', function () {
            var windowScrolltop = $window.scrollTop();
            var val = $(document).height() - $window.height() - footerHeight;

            if (windowScrolltop >= val) {
                $floating.addClass('active');
            } else {
                $floating.removeClass('active');
            }
        });
    }

    // STICKY 헤더
    if ($('.header').length) {
        var offset = $('.header__bottom').offset();
        var header = $('.header');
        var tmp = $('.header').clone().attr('class', 'tmp').css('visibility', 'hidden');

        window.addEventListener('scroll', function () {
            if (window.pageYOffset > offset.top + 20) {
                $('.wrap').prepend(tmp);
                header.addClass('sticky');
            } else {
                $('.wrap').find('.tmp').remove();
                header.removeClass('sticky');
            }
        });
    }

    var filter = 'win16|win32|win64|mac|macintel';
    if (navigator.platform) {
        if (filter.indexOf(navigator.platform.toLowerCase()) < 0) {
            // MOBILE

            // INFO RANK
            $('.js--rank').on('click', function (e) {
                var $this = $(this),
                    $href = $('.info--rank'),
                    $top = $this.offset().top - 12;

                if (window.innerWidth >= 1805) {
                    var $left = $this.offset().left - $this.outerWidth() + 8;
                } else if (window.innerWidth >= 1025) {
                    var $left = $this.offset().left - 270;
                } else if (window.innerWidth >= 522) {
                    var $left = $this.offset().left - 8;
                } else if (window.innerWidth >= 480) {
                    var $left = $this.offset().left - 50;
                } else {
                    var $left = $this.offset().left - 70;
                }

                var config = {
                    tooltipstyle: {
                        position: 'absolute',
                        top: $top,
                        left: $left,
                        zIndex: 9999
                    }
                };

                $($href).css(config.tooltipstyle);
                $($href).show();
                return false;
            });

            // INFO LV
            $('.js--lv').on('click', function (e) {
                var $this = $(this),
                    $href = $('.info--lv'),
                    $top = $this.offset().top - 6;

                if (window.innerWidth >= 560) {
                    var $left = $this.offset().left - $href.outerWidth() + 25;
                } else {
                    var $left = $this.offset().left - $href.outerWidth() / 2;
                }

                var config = {
                    tooltipstyle: {
                        position: 'absolute',
                        top: $top,
                        left: $left,
                        zIndex: 9999
                    }
                };
                $($href).css(config.tooltipstyle);
                $($href).show();
                return false;
            });
        } else {
            // PC

            // INFO RANK
            $('.js--rank').on('click mouseenter', function (e) {
                var $this = $(this),
                    $href = $('.info--rank'),
                    $top = $this.offset().top - 12;

                if (window.innerWidth >= 1805) {
                    var $left = $this.offset().left - $this.outerWidth() + 8;
                } else if (window.innerWidth >= 1025) {
                    var $left = $this.offset().left - 270;
                } else if (window.innerWidth >= 522) {
                    var $left = $this.offset().left - 8;
                } else if (window.innerWidth >= 480) {
                    var $left = $this.offset().left - 50;
                } else {
                    var $left = $this.offset().left - 70;
                }

                var config = {
                    tooltipstyle: {
                        position: 'absolute',
                        top: $top,
                        left: $left,
                        zIndex: 9999
                    }
                };

                $($href).css(config.tooltipstyle);
                $($href).show();
                return false;
            });

            // INFO LV
            $('.js--lv').on('click mouseenter', function (e) {
                var $this = $(this),
                    $href = $('.info--lv'),
                    $top = $this.offset().top - 6;

                if (window.innerWidth >= 560) {
                    var $left = $this.offset().left - $href.outerWidth() + 25;
                } else {
                    var $left = $this.offset().left - $href.outerWidth() / 2;
                }

                var config = {
                    tooltipstyle: {
                        position: 'absolute',
                        top: $top,
                        left: $left,
                        zIndex: 9999
                    }
                };
                $($href).css(config.tooltipstyle);
                $($href).show();
                return false;
            });

            // INFO 닫기
            $('.info--lv, .info--rank').on('mouseleave', function () {
                $(this).hide();
            });
        }
    }

    $(document).on('click', function (e) {
        if ($(e.target).hasClass('share') && !$(e.target).hasClass('active')) {
            $('.share').addClass('active');
            $('.share-dropdown').addClass('active').stop().show();
        } else {
            $('.share').removeClass('active');
            $('.share-dropdown').removeClass('active').stop().hide();
        }

        if ($(e.target).hasClass('view__share-button') && !$(e.target).hasClass('active')) {
            // $('.share').addClass('active');
            $('.view__share-dropdown').addClass('active').stop().show();
        } else {
            // $('.share').removeClass('active');
            $('.view__share-dropdown').removeClass('active').stop().hide();
        }

        if ($(e.target).hasClass('js--lv') && !$(e.target).hasClass('info--lv')) {
            $('.info--lv').hide();
        }

        if ($(e.target).hasClass('js--rank') && !$(e.target).hasClass('info--rank')) {
            $('.info--rank').hide();
        }
    });
})();

function windowResizeFn() {
    $('.info--rank, .info--lv, .language').hide();
}

function windowScrollFn() {
    $('.info--rank, .info--lv, .language').hide();
}

window.addEventListener('resize', windowResizeFn, false);
window.addEventListener('scroll', windowScrollFn, false);

windowResizeFn();
windowScrollFn();

// PREV NEXT width 사이즈 큰 쪽에 맞추기
var width_array = $('.prev-next__item span')
    .map(function () {
        return $(this).width();
    })
    .get();

var max_width = Math.max.apply(Math, width_array);

// width 값 올림
var max_widthRound = Math.ceil(max_width);
$('.prev-next__item span').width(max_widthRound);
