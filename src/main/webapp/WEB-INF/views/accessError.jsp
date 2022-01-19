<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="height:100vh">
	<div style="position:relative;top:50%;margin-top: -130px;text-align: center;">
		<h1>Error Page</h1>
		<h2><c:out value="${msg}"></c:out></h2>
	</div>
</body>
</html>
