<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
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
                <form action="#" method="post">
                	<div class="inputBox">
	                	<input type="text" name="" placeholder="아이디">
	                    <input type="password" name="" placeholder="비밀번호">
                    </div>
                    <button><a href="/board/list">로그인</a></button>
                </form>
            	<div style="position: absolute;top: 270px;right: 250px;font-size: 17px;">@gamedex.co.kr</div>
            </div>
		</div>
    </body>
</html>
