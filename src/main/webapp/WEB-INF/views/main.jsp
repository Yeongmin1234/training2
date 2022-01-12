<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link rel="stylesheet" href="/resources/css/jquery.mCustomScrollbar.min.css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script src='//cdnjs.cloudflare.com/ajax/libs/jquery-throttle-debounce/1.1/jquery.ba-throttle-debounce.min.js'></script>
		<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <title>document</title>
        <style>
        	.loginBox{position:relative;width: 800px;height: 500px;padding-top:50px;margin: 220px auto 0 auto;text-align: center;box-sizing:border-box;}
        	.inputBox{display:flex;flex-direction:column}
        	input{width: 340px;height: 44px;margin: 0 auto 12px auto;padding-left:20px;box-sizing:border-box;}
        </style>
    </head>

    <body>
        <div class="wrap">
        	<div class="loginBox">
             	<h1 class="logo">
                    <a href="#" title="게임덱스">
                        <img src="/resources/images/logo_00.png" alt="게임덱스 로고">
                    </a>
                </h1>
                <form role="form" method="post" action="/login">
                	<div class="inputBox">
	                	 <input placeholder=" 아이디" name="username" type="text" autofocus>
	                     <input  placeholder="비밀번호" name="password" type="password" value="">
                    </div>
                    <button type="submit" id="btn-success">로그인</button>
                     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </form>
            	<div style="position: absolute;top: 270px;right: 250px;font-size: 17px;">@gamedex.co.kr</div>
            </div>
		</div>
		<script type="text/javascript">
		    $("#btn-success").on("click", function(e){
		    	e.preventDefault();
		    	var id=$("input[name='username']").val();
		    	var pw=$("input[name='password']").val();
		    	var idPattern = /[a-zA-Z0-9_-]{2,15}/;
		    	var pwPattern = /[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{4,15}/;
		    	
		       if(id.length==0 || !idPattern.test(id)){
		    	   alert("일시적인 오류가 발생하였습니다. 다시 시도해 주세요.");
		    	   return false;
		       } else if(pw.length==0 || !pwPattern.test(pw)){
		    	   alert("일시적인 오류가 발생하였습니다. 다시 시도해 주세요.");
		    	   return false;
		       }
		       $("form").submit();
		    });
		</script>
    </body>
</html>