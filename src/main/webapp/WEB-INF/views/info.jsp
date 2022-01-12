<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

    <title>document</title>
</head>
<body>
	<table border='1'>
		<input type="hidden" name="id" value="da0"> 
		<tr><td>아이디</td><td>${info.id}</td></tr>
		<tr><td>이름</td><td>${info.name}</td></tr>
		<tr><td>비밀번호</td><td>${info.pw}</td></tr>
		<tr><td>번호</td><td>${info.phone}</td></tr>
		<tr><td>부서명</td><td>${info.dept}</td></tr>
		<tr><td>등급</td><td>${info.userCate}</td></tr>
		<tr><td>게시글 수</td><td>${info.boardCnt}</td></tr>
		<tr><td>댓글 수</td><td>${info.replyCnt}</td></tr>
		<tr><td>조회 수</td><td>${info.hitCnt}</td></tr>
	</table>
</body>
</html>