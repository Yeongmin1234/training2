<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <meta name="_csrf_parameter" content="${_csrf.parameterName}" />
		<meta name="_csrf_header" content="${_csrf.headerName}" />
		<meta name="_csrf" content="${_csrf.token}" />
		<link rel="icon" href="data:;base64,iVBORw0KGgo=">
        <link rel="stylesheet" href="/resources/css/common.css" />
        <link rel="stylesheet" href="/resources/css/approval.css" />
        <link rel="stylesheet" href="/resources/css/list.css" />
        <link rel="stylesheet" href="/resources/css/jquery.mCustomScrollbar.min.css" />
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="/resources/js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="/resources/js/intra.js"></script>
        <script src="/resources/js/reply.js"></script>
        <script src="/resources/js/read.js"></script>
        <title>document</title>
        <style>
        	.rnoColumn{display: none;}#ModBtn,#RemoveBtn{cursor: pointer;}.modInput{border:1px solid #333;margin:5px 0;outline:none;}.blindBtn{display:none;cursor: pointer;}.uploadResult a:hover{border-bottom:1px solid #222;}.active{font-weight: bold;}
        </style>
    </head>
    <body>
        <div class="wrap">
            <!-- 헤더 영역 -->
             <header class="header">
                <h1>
                    <a href="/board/list" title="게임덱스 홈" style="font-size:40px;text-align:center;">
                        로고
                    </a>
                </h1>
                <div class="box">
	                <div  style="position:relative;">
	                    <p>
	                       <strong><span><sec:authentication property="principal.member.userName"/>&nbsp</span></strong><span>님&nbsp&nbsp&nbsp&nbsp</span>
	                  <em class="cateInfo" style="cursor:pointer;">
	                    		<sec:authentication property="principal.member.cate"/> 등급
	                        </em>
	                    </p>
	                    <div style="position:absolute;top:-2px;right:44px;">
		                    <form action="/logout" method="post">
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
								<button>로그아웃</button>
							</form>
	                    </div>
	                </div>    
                </div>
                 <div class="search" style="position: absolute;top: 39px;right: 137px;">
	                   <div>
	                       <form id="allSearchForm" action="/board/searchAll" method="get">
	                            <select style="display:none;"  name="allType">
	                                <option value="TC" <c:out value="${pageMaker.cri.allType=='TC'?'selected':''}" />>제목+내용</option>
	                            </select>
	                            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	                            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	                            <input type="text" name="allKeyword" value="${pageMaker.cri.allKeyword}" style="width: 200px;border: 1px solid #4a4a4a;outline:none;" placeholder="통합검색">
	                            <button class="btn">검&nbsp;색</button>		
	                        </form>
	                   </div> 
	               </div> 
            </header>
            <!-- 네비게이션 영역 -->
            <div class="navWrap">
                <ul class="nav">
                    <li class="nav_el">
                        <h4><a href="javascript:void(0);" title="전체 게시판">전체 게시판</a><i></i></h4>
                        <div class="sub_el">
                            <ul>
                            	 <li>
                                    <a href="http://localhost:8080/board/elist?cate=0" title="공지사항">공지사항</a>
                                </li>
                                <li>
                                    <a href="http://localhost:8080/board/elist?cate=1" title="1등급 게시판"> 1등급 게시판 </a>
                                </li>
                                <li>
                                    <a href="http://localhost:8080/board/elist?cate=2" title="2등급 게시판"> 2등급 게시판 </a>
                                </li>
                                <li>
                                    <a href="http://localhost:8080/board/elist?cate=3" title="3등급 게시판"> 3등급 게시판 </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav_el">
                        <h4><a href="" title="마이페이지">마이페이지</a><i></i></h4>
                        <div class="sub_el">
                            <ul>
                                <li>
                                    <a href="#" title="개인정보"> 개인정보 </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
           <!-- 컨텐츠 영역 -->
          <div class="containers">
           	<div>
            	<div style="margin-bottom: 30px;">
	            	<h2 style="margin-bottom: 30px;">
	            		<c:choose>
	                   		<c:when test="${read.cate=='0'}">
	                   			<c:out value="공지사항" />
	                   		</c:when>
	                       	<c:otherwise>
	                       		 <c:out value="${read.cate}등급 게시판" />
	                        </c:otherwise>	
	                    </c:choose>
	            	</h2>
	            	 <table>
	            	 	<tr style="display:none;"><input type="hidden" name="bno" id="bno"  value='${read.bno}' ></tr>
	            	 	<tr style="display:none;"><input type="hidden" name="cate" id="cate"  value='${read.cate}' ></tr>
	            	 	<tr><th style="width: 100px;">작성자</th><td id="writer" style="width: 70%;">${read.writer}</td><th>작성일</th><td><fmt:formatDate value="${read.date}" pattern="yyyy년MM월dd일"/></td></tr>
	            	 	<tr><th style="width: 100px;">카테고리</th><td style="width: 70%;">
            	 			<c:choose>
	                    		<c:when test="${read.cate=='0'}">
	                    			<c:out value="공지" />
	                    		</c:when>
	                        	<c:otherwise>
	                        		 <c:out value="${read.cate}등급" />
		                        </c:otherwise>	
		                    </c:choose>
	            	 	</td><th>조회수</th><td>${read.hit}</td></tr>
	            	 	<tr><th>제목</th><td colspan='3'>${read.title}</td></tr>
	            	 	<c:if test="${read.file==1}">
	            	 		<tr><th>첨부파일</th><td colspan='3'><div class="uploadResult"><ol style="display:flex;"></ol></div></td></tr>
	            	 	</c:if>
	            	 	<tr style="height:200px"><th>내용</th><td colspan='3'>${read.text}</td></tr>
	            	 </table>
	            	 </div>
       	    		 <div>
                    	<ul class="utils__list">
                    	 <sec:authentication property="principal" var="pinfo"/>
					        <sec:authorize access="isAuthenticated()">
					         <c:if test="${pinfo.member.userName eq read.writer || pinfo.username eq 'admin'}">
	                        	<li><a class="modify" style="color: #333;right: 90px;top: 15px;position: absolute;" href="/board/update?bno=${read.bno}&&cate=${read.cate}">수정</a></li>
	                            <li><a class="remove" style="color: #333;right: 35px;top: 15px;position: absolute;" href="/board/delete?bno=${read.bno}">삭제</a></li>
					          </c:if>
					       </sec:authorize>
						</ul>
                     </div>
           	 		<div class="board_reply">
           	 			<input id="who" type='hidden' value='<sec:authentication property="principal.member.userName"/>' style="outline:none;">
           	 			<input id="whoId" type='hidden' value='<sec:authentication property="principal.username"/>' style="outline:none;">
           	 			<div style="margin: 9px 0;padding-bottom: 13px;border-bottom: 1px solid #767171;">댓글 <span>${read.replyCnt}</span></div>
                    	<div class="reply_write">
	                        <input type="text" id="reply" style="outline:none;" placeholder="댓글을 입력해 주세요.">
	                        <button type="button" id="RegisterBtn" class="button">등록</button>
	                     </div>
						 <ul class="chat">
						 </ul>
	                 </div>
                </div>
            </div>
        </div>
        <div class="cateTxt" style="display:none; width: 700px;height: 330px;position: fixed;    top: 50%;left: 50%;margin: -187px 0 0 -408px;background-color: #fff;    text-align: center;    font-size: 20px;    padding-top: 46px;">
			<span id="close" style="position: absolute;cursor:pointer;top: -60px;left: 50%;font-size: 35px;border: 1px solid #222;    padding: 0px 15px;    margin-left: -25px;">X</span>
			<p>※ 등급 정책 ※</p>
			<p>첫 로그인시 1등급</p>
			<p>*  1등급>2등급 : 게시물 수, 댓글 수, 방문 수 각각 10개 이상</p>
			<p> *  2등급>3등급 : 게시물 수, 댓글 수 ,방문 수 각각 20개 이상</p>
			<p>* 1등급 : 2등급, 3등급 게시판 조회 불가</p>
			<p>* 2등급 : 3등급 게시판 조회 불가</p>
		</div>
        <script>
        if($("input[name='allKeyword']").val().length!=0){$(".pager").css('opacity','0');}
		$(".cateInfo").click(function(){$(".cateTxt").show(500)});
		$("#close").click(function(){$(".cateTxt").hide(500)});
       	$(".remove").click(function(){if(confirm("삭제 하시겠습니까?")){return true;}else{return false}});
        </script>
    </body>
</html>
