/**
 * 
 */
$(document).ready(function () {
    /* 아이디 저장 */
    var i = 0;
    $(".chk").click(function () {
        if (i == 0) {
            $(".chk").addClass("on");
            i = 1;
        } else {
            $(".chk").removeClass("on");
            i = 0;
        }
    });

    /* 회원가입 */
    // 20210205 수정
    $(".p_2 a:nth-child(1)").click(function () {
        $(".popUp1").show();
    });

    $(".p_2 a:nth-child(3)").click(function () {
        $(".popUp3").show();
    });

    $(".xBtn").click(function () {
        $(".popUp1, .popUp3").hide();
    });
});
