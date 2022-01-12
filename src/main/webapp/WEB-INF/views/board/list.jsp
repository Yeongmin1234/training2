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
        <style>
	        table{clear: both;table-layout: auto;vertical-align: top;} th {height: 50px;width: 70px;background-color: aliceblue;}  td {text-align: center;height: 50px;width: 70px;background-color: aliceblue;} table input {height: 50px;width: 70px;border: none;background-color:  aliceblue;font-size: 30px;} .year_mon{font-size: 25px;} .colToday{background-color: #c3c3c3;}
	        .active{font-weight: bold;}.cateTxt p{margin-bottom:12px;}
        </style>
        <script>
            $(document).ready(function () {
                $('#doughnutChart').drawDoughnutChart([
                    { title: '임시저장', value: 1, color: '#82c466' },
                    { title: '진행', value: 2, color: '#c1c466' },
                    { title: '완료', value: 3, color: '#c49b66' },
                    { title: '반려', value: 4, color: '#31414f' }
                ]);
            });
            
            $(function(){
                var today = new Date();
                var date = new Date();           

                $("input[name=preMon]").click(function() { // 이전달
                    $("#calendar > tbody > td").remove();
                    $("#calendar > tbody > tr").remove();
                    today = new Date ( today.getFullYear(), today.getMonth()-1, today.getDate());
                    buildCalendar();
                })
                
                $("input[name=nextMon]").click(function(){ //다음달
                    $("#calendar > tbody > td").remove();
                    $("#calendar > tbody > tr").remove();
                    today = new Date ( today.getFullYear(), today.getMonth()+1, today.getDate());
                    buildCalendar();
                })


                function buildCalendar() {
                    
                    nowYear = today.getFullYear();
                    nowMonth = today.getMonth();
                    firstDate = new Date(nowYear,nowMonth,1).getDate();
                    firstDay = new Date(nowYear,nowMonth,1).getDay(); //1st의 요일
                    lastDate = new Date(nowYear,nowMonth+1,0).getDate();

                    if((nowYear%4===0 && nowYear % 100 !==0) || nowYear%400===0) { //윤년 적용
                        lastDate[1]=29;
                    }

                    $(".year_mon").text(nowYear+"년 "+(nowMonth+1)+"월");

                    for (i=0; i<firstDay; i++) { //첫번째 줄 빈칸
                        $("#calendar tbody:last").append("<td></td>");
                    }
                    for (i=1; i <=lastDate; i++){ // 날짜 채우기
                        plusDate = new Date(nowYear,nowMonth,i).getDay();
                        if (plusDate==0) {
                            $("#calendar tbody:last").append("<tr></tr>");
                        }
                        $("#calendar tbody:last").append("<td class='date'>"+ i +"</td>");
                    }
                    if($("#calendar > tbody > td").length%7!=0) { //마지막 줄 빈칸
                        for(i=1; i<= $("#calendar > tbody > td").length%7; i++) {
                            $("#calendar tbody:last").append("<td></td>");
                        }
                    }
                    $(".date").each(function(index){ // 오늘 날짜 표시
                        if(nowYear==date.getFullYear() && nowMonth==date.getMonth() && $(".date").eq(index).text()==date.getDate()) {
                            $(".date").eq(index).addClass('colToday');
                        }
                    }) 
                }
                buildCalendar();


            })
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
	                       <strong><span><sec:authentication property="principal.member.userName"/>&nbsp</span></strong><span>님&nbsp&nbsp&nbsp&nbsp</span>
	                       <em class="cateInfo" style="cursor:pointer;">3등급</em>
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
	                        <form id="allSearchForm" action="/board/list" method="get">
	                            <select style="display:none;"  name="allType">
	                                <option value="TC" <c:out value="${pageMaker.cri.allType=='TC'?'selected':''}" />>제목+내용</option>
	                            </select>
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
	                            	<c:if test="${list.file==1}">
		                            	<span><img src="/resources/images/clip.png" style="width: 16px;height: 16px;margin: 10px;"></span>
		                            </c:if>
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
		                            <c:if test="${boardlist.file==1}">
		                            	<span><img src="/resources/images/clip.png" style="width: 16px;height: 16px;margin: 10px;"></span>
		                            </c:if>
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
	                        <form id="searchForm" action="/board/list" method="get">
	                            <select name="type">
	                                <option value="" <c:out value="${pageMaker.cri.type==null?'selected':''}" />>선택</option>
	                                <option value="T" <c:out value="${pageMaker.cri.type=='T'?'selected':''}" />>제목</option>
	                                <option value="C" <c:out value="${pageMaker.cri.type=='C'?'selected':''}" />>내용</option>
	                                <option value="W" <c:out value="${pageMaker.cri.type=='W'?'selected':''}" />>작성자</option>
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
	                        	<li><a href="/board/list?type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.first}&amount=${pageMaker.cri.amount}">◀◀</a></li>
	                        </c:if>
	                        <c:if test="${pageMaker.prev}">
	                            <li><a href="/board/list?type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.startPage - 1}&amount=${pageMaker.cri.amount}" class="prev"></a></li>
	                        </c:if>
	                        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	                            <li class="${pageMaker.cri.pageNum==num?'active':''}">
	                                <a href="/board/list?type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${num}&amount=${pageMaker.cri.amount}">${num}</a>
	                            </li>
	                        </c:forEach>
	                        <c:if test="${pageMaker.next}">
	                            <li><a href="/board/list?type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.endPage + 1}&amount=${pageMaker.cri.amount}" class="next"></a></li>
	                        </c:if>
	                        <c:if test="${pageMaker.next}">
	                        	<li><a href="/board/list?type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.last}&amount=${pageMaker.cri.amount}">▶▶</a></li>
	                        </c:if>
	                    </ul>
	                </div> <!--.Pager-->
	            </div> <!--.board-->
            </div>
        </div>
		<div style="position: absolute;top: 220px;right: 65px;background-color: aliceblue;width: 400px;height: 185px;">
			<div style="margin: 26px 0 0 28px;">
				<p style="font-size: 33px;margin-bottom: 21px;"><sec:authentication property="principal.member.userName"/></p>
				<p style="font-size: 21px;margin-bottom: 21px;">000팀</p>
				<p >010 - 1234 - 5678</p>
			</div>
		</div>       
		<div style="position: absolute;top: 420px;right: 65px;background-color: aliceblue;width: 400px;height: 300px;">
		    <table id="calendar">
		        <thead>
		            <tr>
		                <th><input name="preMon" type="button" value="<"></th>
		                <th colspan="5" class="year_mon"></th>
		                <th><input name="nextMon" type="button" value=">"></th>
		            </tr>
		            <tr>
		                <th>일</th>
		                <th>월</th>
		                <th>화</th>
		                <th>수</th>
		                <th>목</th>
		                <th>금</th>
		                <th>토</th>
		            </tr>
		        </thead>
		        <tbody>
		        </tbody>
		    </table>
		</div>
		<div class="cateTxt" style="display:none; width: 700px;height: 330px;position: fixed;    top: 50%;left: 50%;margin: -187px 0 0 -408px;background-color: #fff;    text-align: center;    font-size: 20px;    padding-top: 46px;">
			<span class="close" style="position: absolute;cursor:pointer;top: -60px;left: 50%;font-size: 35px;border: 1px solid #222;    padding: 0px 15px;    margin-left: -25px;">X</span>
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
			$(".close").click(function(){$(".cateTxt").hide(500)});
		</script>
    </body>
</html>
