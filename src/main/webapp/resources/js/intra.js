/**
 * 
 */
$(document).ready(function () {
    // 네비게이션 숨기기
    $('.sub_el').hide();

    // 현재 페이지 네비게이션 보이기
    $('.on .sub_el').show();
    $('.nav_el.active h4 a').css({
        background: "url('img/background_02.png')"
    });

    // 네비게이션 클릭했을때
    $('.nav_el h4').on('click', function () {
        let orange = $(this).parent('.nav_el').hasClass('on');

        if (orange) {
            $(this).parent('.nav_el').removeClass('on');
            $(this).parent('.nav_el').children('.sub_el').slideUp();
            $(this).parent('.nav_el').children('h4 a').css({
                background: 'rgba(49,65,79,1)'
            });
        } else {
            $(this).parent('.nav_el').addClass('on');
            $(this).parent('.nav_el').children('.sub_el').slideDown();
            $(this).parent('.nav_el').children('h4 a').css({
                background: "url('img/background_02.png')"
            });
        }
    });

    /*########## 2등급 ##########*/

    // 2등급 체크박스 이벤트 - 인사정보, 마이페이지
    $('.lv-2__chkBox').on('click', function () {
        const orange = $(this).hasClass('on');

        if (orange) {
            $(this).removeClass('on');
        } else {
            $(this).addClass('on');
        }
    });

    // 2등급 테이블영역 클릭했을 때
    $('.lv-2__table table tbody tr').on('click', function () {
        $('.lv-2__table table tbody tr').not(this).removeClass('on');
        $(this).addClass('on');
    });

    /*########## 열람 권한 결재선 팝업 ##########*/

    // 열람권한 테이블영역 클릭했을 때
    $('.table-fifth tbody tr, .table-sixth tbody tr').on('click', function () {
        $(this).siblings().removeClass('on');
        $(this).addClass('on');
    });

    // 출석체크 팝업창 이벤트 - 전체
    $('.popup-chk').hide();
    $('.popup-chk__x').on('click', function () {
        $('.popup-chk').hide();
    });
    $('.fast-menu__el-1').on('click', function () {
        $('.popup-chk').show();
    });

    // 열람권한, 결재선 팝업창 이벤트
    $('.popup-1').hide();
    $('.popup-1__x, .popup-1-offButton').on('click', function () {
        $('.popup-1').hide();
    });
    $('.popup-1-onButton').on('click', function () {
        $('.popup-1').show();
    });

    // 결재처리 팝업창 이벤트
    $('.popup-2').hide();
    $('.popup-2__x, .popup-2-offButton').on('click', function () {
        $('.popup-2').hide();
    });
    $('.popup-2-onButton').on('click', function () {
        $('.popup-2').show();
    });

    // 부서 선택 팝업창 이벤트 20210205 수정
    $('.popup-3').hide();
    $('.popup-3__x, .popup-3-offButton').on('click', function () {
        $('.popup-3').hide();
    });
    $('.popup-3-onButton').on('click', function () {
        $('.popup-3').show();
    });

    // 메인 달력 부분 - 메인
    // $('.main-calendar-tab-1').on('click', function () {
    //     $(this).siblings().removeClass('active');
    //     $(this).addClass('active');
    //     $('.main-calendar__company').show();
    //     $('.main-calendar__team').show();
    // });

    // $('.main-calendar-tab-2').on('click', function () {
    //     $(this).siblings().removeClass('active');
    //     $(this).addClass('active');
    //     $('.main-calendar__team').show();
    //     $('.main-calendar__company').hide();
    // });

    // $('.main-calendar-tab-3').on('click', function () {
    //     $(this).siblings().removeClass('active');
    //     $(this).addClass('active');
    //     $('.main-calendar__company').show();
    //     $('.main-calendar__team').hide();
    // });

    $('.main-calendar-tab').on('click', function (e) {
        $(this).siblings().removeClass('active');
        $(this).addClass('active');

        switch (true) {
            case e.target == $('.main-calendar-tab-1'):
                $('.main-calendar__company').show();
                $('.main-calendar__team').show();
                break;

            case e.target == $('.main-calendar-tab-2'):
                $('.main-calendar__company').hide();
                $('.main-calendar__team').show();
                break;

            case e.target == $('.main-calendar-tab-3'):
                $('.main-calendar__company').show();
                $('.main-calendar__team').hide();
                break;
        }
    });

    // 달력
    $('.main-calendar__content td').on('click', function () {
        $('.main-calendar__content td').not(this).removeClass('main-calendar__today');
        $(this).addClass('main-calendar__today');
    });

    // 달력 작성 버튼
    $('.main-title--setting').on('click', function () {
        var mainSetting = $(this).hasClass('active');

        if (mainSetting) {
            $(this).removeClass('active');
        } else {
            $(this).addClass('active');
        }
    });

    // 달력팝업 온 오프 - 인사정보
    $('.calendarButton').on('click', function () {
        $('.calendarButton').not(this).removeClass('active');
        $('.calendarPopup, .calendarPopup2').hide();

        var calendarActive = $(this).hasClass('active');

        if (calendarActive) {
            $(this).removeClass('active');
            $(this).siblings('.calendarPopup, .calendarPopup2').hide();
        } else {
            $(this).addClass('active');
            $(this).siblings('.calendarPopup, .calendarPopup2').show();
        }
    });

    // 첨부파일 리스트 삭제 버튼 (빨간색 x 버튼)
    $('.a-tag2').on('click', function () {
        $(this).parent().css('display', 'none');
    });

    // 휴가관리 달력
    $('.calendar2').on('click', function () {
        var calendar2Click = $(this).hasClass('on');

        if (!calendar2Click) {
            $(this).addClass('on');
        } else {
            $(this).removeClass('on');
        }
    });

    // 휴가관리 달력
    $('.calendar2 tr td').on('click', function () {
        var calendar2Click = $(this).hasClass('on');

        if (!calendar2Click) {
            $(this).addClass('on');
        } else {
            $(this).removeClass('on');
        }
    });

    // 휴가신청서 달력
    $('.calendarPopup2 tr td').on('click', function () {
        var calendarPopup2Click = $(this).hasClass('on');

        if (!calendarPopup2Click) {
            $(this).addClass('on');
        } else {
            $(this).removeClass('on');
        }
    });

    $('.calendarPopup2 button:contains("취소")').on('click', function () {
        $('.calendarPopup2').css('display', 'none');
        $(this).closest('.calendarPopup2').siblings('.calendarButton').removeClass('active');
    });

    // 달력
    $('.calendarPopup td').on('click', function () {
        $('.calendarPopup td').not(this).removeClass('on');
        $(this).addClass('on');
    });

    // 월근태현황 탭
    $('.tab-1').on('click', function () {
        $(this).children('a').addClass('active');
        $(this).siblings().children('a').removeClass('active');
        $('.lv-1-1').show();
        $('.lv-1-2').hide();
    });
    $('.tab-2').on('click', function () {
        $(this).children('a').addClass('active');
        $(this).siblings().children('a').removeClass('active');
        $('.lv-1-2').show();
        $('.lv-1-1').hide();
    });

    // 인사페이지 탭
    $('.info__area__title ul li').on('click', function () {
        var infoTab = $(this).index();
        $(this).children('a').addClass('on');
        $(this).siblings('li').children('a').removeClass('on');

        $('fieldset').hide();
        $('fieldset:eq(' + infoTab + ')').css('display', 'block');

        if (infoTab == 0) {
        } else {
        }
    });

    // 인사페이지 주민등록번호 수정 팝업
    $('.info__area__table--1 .textButton').on('click', function () {
        $('.popup-change-1').css('display', 'flex');
    });

    // 수정팝업 닫기
    $('.popup-change button:contains("취소")').on('click', function () {
        $('.popup-change').css('display', 'none');
    });

    // 비밀번호 입력 후 다음으로 이동
    $('.popup-change-1 button:contains("확인")').on('click', function () {
        $('.popup-change-2').css('display', 'flex');
    });

    // 이미지 수정 팝업 열기
    $('.profile').on('click', function () {
        $('.popup-image').css('display', 'flex');
    });

    // 이미지 수정 팝업 닫기
    $('.popup-image button:contains("취소")').on('click', function () {
        $('.popup-image').css('display', 'none');
    });
});

// 스크롤바 모양 변경 js
(function ($) {
    $(window).on('load', function () {
        $('container').mCustomScrollbar({
            theme: 'minimal',
            scrollInertia: 400
        });
        $('.navWrap').mCustomScrollbar({
            theme: 'minimal',
            scrollInertia: 400
        });
        $('.js-scroll').mCustomScrollbar({
            theme: 'dark',
            scrollInertia: 400
        });
        $('.lv-2__table').mCustomScrollbar({
            theme: 'dark',
            scrollInertia: 400,
            alwaysShowScrollbar: 2
        });
        $('.main-calendar-meno__desc').mCustomScrollbar({
            theme: 'dark',
            scrollInertia: 400
        });
        $('.table-scroll').mCustomScrollbar({
            theme: 'dark',
            scrollInertia: 400,
            alwaysShowScrollbar: 2
        });
    });
})(jQuery);
