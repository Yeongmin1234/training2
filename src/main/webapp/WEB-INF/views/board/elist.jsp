<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link rel="stylesheet" href="/resources/css/common.css" />
        <link rel="stylesheet" href="/resources/css/main.css" />
        <link rel="stylesheet" href="/resources/css/list.css">
        <link rel="stylesheet" href="/resources/css/jquery.mCustomScrollbar.min.css" />
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	    <script src='//cdnjs.cloudflare.com/ajax/libs/jquery-throttle-debounce/1.1/jquery.ba-throttle-debounce.min.js'></script>
	    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <script src="/resources/js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="/resources/js/jquery.drawDoughnutChart.js"></script>
        <script type="text/javascript" src="/resources/js/list.js"></script>
        <script src="/resources/js/intra.js"></script>
        <title>document</title>
        <style>.active{font-weight: bold;}</style>
        <script>
            $(document).ready(function () {
                $('#doughnutChart').drawDoughnutChart([
                    { title: '임시저장', value: 1, color: '#82c466' },
                    { title: '진행', value: 2, color: '#c1c466' },
                    { title: '완료', value: 3, color: '#c49b66' },
                    { title: '반려', value: 4, color: '#31414f' }
                ]);
            });
        </script>
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
                       <strong><span>000&nbsp</span></strong><span>님&nbsp&nbsp&nbsp&nbsp</span>
                       <em>3등급</em>
                   </p>
                    <p style="position:absolute;top:0;right:-307px;"><a href="javascript:void(0);" title="로그아웃">로그아웃</a></p>
                </div>    
                     
                    <ul class="fast-menu">
                        <li><a class="fast-menu__el-1" href="javascript:void(0);" title=""></a></li>
                        <li><a class="fast-menu__el-2" href="javascript:void(0);" title=""></a></li>
                    </ul>
                </div>
                  <div class="search" style="position: absolute;top: 39px;right: 154px;">
	                    <div>
	                        <form action="" method="" style="display: flex;">
	                           	<input type="text" style="border: 1px solid #4a4a4a;outline:none;" placeholder="통합검색">
	                            <button class="btn btn-primary">검&nbsp;색</button>		
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
                        <h4><a href="javascript:void(0);" title="마이페이지">마이페이지</a><i></i></h4>
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
            <!-- 메인 영역 -->
            <div id="container">
            	<div class="board">
            		<h2>전체글</h2>
	                <div class="registerBtn">
				    	<button><a href="/board/create">글쓰기</a></button>
	                </div>
	                
	                <div class="boardList">
	                    <div class="boardListIn">
	                        <h3>No.</h3>
	                        <h3>카테고리</h3>
	                        <h3>제목</h3>
	                        <h3>작성자</h3>
	                        <h3>작성일</h3>
	                        <h3>조회수</h3>
	                    </div> <!--.boardListIn-->
	                    <ul>
	                     <c:forEach var="list" items="${pinList}">
		                        <li>
		                            <p class="bno"><img src="/resources/images/bell.png" width="25px" height="25px" style="position: absolute;top: 5px;left: -2px;"></p>
		                            <p class="cate">
		                            	<c:choose>
				                    		<c:when test="${list.cate=='0'}">
						                    	<c:out value="공지" />
				                    		</c:when>
				                        	<c:otherwise>
				                        		 <c:out value="${list.cate}등급" />
					                        </c:otherwise>	
					                    </c:choose>
		                            </p>
		                            <p class="title">
			                            <c:if test="${list.date>=nowday}">
				                            <span class="newTxt" style="color:red;">
												N
				                            </span>
			                            </c:if>
			                            <a href="/board/read?bno=${list.bno}">${list.title}</a>[${list.replyCnt}]
		                            </p>
		                            <p class="writer"><a href="#">${list.writer}</a></p>
		                            <p class="date"><fmt:formatDate value="${list.date}" pattern="yyyy/MM/dd"/></p>
		                            <p class="hit">${list.hit}</p>
		                        </li>
	                        </c:forEach>
	                        <c:forEach var="boardlist" items="${list}">
		                        <li>
		                            <p class="bno">${boardlist.rownum}</p>
		                            <p class="cate">
				                    	<c:choose>
				                    		<c:when test="${boardlist.cate=='0'}">
						                    	<c:out value="공지" />
				                    		</c:when>
				                        	<c:otherwise>
				                        		 <c:out value="${boardlist.cate}등급" />
					                        </c:otherwise>	
					                    </c:choose>	
		                            </p>
		                            <p class="title">
			                            <c:if test="${boardlist.date>=nowday}">
				                            <span class="newTxt" style="color:red;">
												N
				                            </span>
			                            </c:if>
			                            <a href="/board/read?bno=${boardlist.bno}">${boardlist.title}</a>[${boardlist.replyCnt}]
		                            </p>
		                            <p class="writer"><a href="#">${boardlist.writer}</a></p>
		                            <p class="date"><fmt:formatDate value="${boardlist.date}" pattern="yyyy/MM/dd"/></p>
		                            <p class="hit">${boardlist.hit}</p>
		                        </li>
	                        </c:forEach>
	                    </ul>
	                </div> <!--.boardList-->
	                        
	                <div class="search" style="position: absolute;top: 79px;right: 0;">
	                    <div class="searchIn">
	                        <form id="searchForm" action="/board/elist" method="get">
	                       		<input type="hidden" name="cate" value="${pageMaker.cri.cate}">
	                            <select name="type">
	                                <option value="" <c:out value="${pageMaker.cri.type==null?'selected':''}" />>--</option>
	                                <option value="T" <c:out value="${pageMaker.cri.type=='T'?'selected':''}" />>제목</option>
	                                <option value="C" <c:out value="${pageMaker.cri.type=='C'?'selected':''}" />>내용</option>
	                                <option value="W" <c:out value="${pageMaker.cri.type=='W'?'selected':''}" />>작성자</option>
	                                <option value="TC" <c:out value="${pageMaker.cri.type=='TC'?'selected':''}" />>제목+내용</option>
	                            </select>
	                            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	                            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">	
	                            <input type="text" name="keyword" value="${pageMaker.cri.keyword}" class="keyword">		
	                            <button class="btn btn-primary">검&nbsp;색</button>		
	                                
	                        </form>
	                    </div> 
	                </div> 
	                
	                    
	                <div class="pager">
	                    <ul>
	                     	<c:if test="${pageMaker.prev}">
	                        	<li><a href="/board/elist?cate=${pageMaker.cri.cate}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.first}&amount=${pageMaker.cri.amount}">◀◀</a></li>
	                        </c:if>
	                        <c:if test="${pageMaker.prev}">
	                            <li><a href="/board/elist?cate=${pageMaker.cri.cate}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.startPage - 1}&amount=${pageMaker.cri.amount}" class="prev"></a></li>
	                        </c:if>
	                        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	                            <li class="${pageMaker.cri.pageNum==num?'active':''}">
	                                <a href="/board/elist?cate=${pageMaker.cri.cate}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${num}&amount=${pageMaker.cri.amount}">${num}</a>
	                            </li>
	                        </c:forEach>
	                        <c:if test="${pageMaker.next}">
	                            <li><a href="/board/elist?cate=${pageMaker.cri.cate}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.endPage + 1}&amount=${pageMaker.cri.amount}" class="next"></a></li>
	                        </c:if>
	                        <c:if test="${pageMaker.next}">
	                        	<li><a href="/board/elist?cate=${pageMaker.cri.cate}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.last}&amount=${pageMaker.cri.amount}">▶▶</a></li>
	                        </c:if>
	                    </ul>
	                </div> <!--.Pager-->
	            </div> <!--.board-->
            </div>
        </div>
		<div style="position: absolute;    top: 193px;    right: 65px;    background-color: aliceblue;    width: 400px;    height: 300px;">정보</div>        
		<div style="position: absolute;    top: 550px;    right: 65px;    background-color: aliceblue;    width: 400px;    height: 300px;">달력</div>        
    </body>
</html>
