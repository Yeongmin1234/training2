<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/jquery.mCustomScrollbar.min.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/jquery-throttle-debounce/1.1/jquery.ba-throttle-debounce.min.js'></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<title>Insert title here</title>
</head>
<body>
                       <form role="form" method="post" action="/login">
                            <fieldset>
                                <div class="form-group">
                                    <input placeholder="userid" name="username" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input  placeholder="Password" name="password" type="password" value="">
                                </div>
                                <a href="/board/list" id="btn-success">로그인</a>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            </fieldset>
                        </form>
 
<script type="text/javascript">
    
    $("#btn-success").on("click", function(e){
        
        e.preventDefault();
        $("form").submit();
        
    });
    
</script>
</body>
</html>