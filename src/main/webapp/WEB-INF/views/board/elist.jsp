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
                    { title: '????????????', value: 1, color: '#82c466' },
                    { title: '??????', value: 2, color: '#c1c466' },
                    { title: '??????', value: 3, color: '#c49b66' },
                    { title: '??????', value: 4, color: '#31414f' }
                ]);
            });
            $(function(){
                var today = new Date();
                var date = new Date();           

                $("input[name=preMon]").click(function() { // ?????????
                    $("#calendar > tbody > td").remove();
                    $("#calendar > tbody > tr").remove();
                    today = new Date ( today.getFullYear(), today.getMonth()-1, today.getDate());
                    buildCalendar();
                })
                
                $("input[name=nextMon]").click(function(){ //?????????
                    $("#calendar > tbody > td").remove();
                    $("#calendar > tbody > tr").remove();
                    today = new Date ( today.getFullYear(), today.getMonth()+1, today.getDate());
                    buildCalendar();
                })


                function buildCalendar() {
                    
                    nowYear = today.getFullYear();
                    nowMonth = today.getMonth();
                    firstDate = new Date(nowYear,nowMonth,1).getDate();
                    firstDay = new Date(nowYear,nowMonth,1).getDay(); //1st??? ??????
                    lastDate = new Date(nowYear,nowMonth+1,0).getDate();

                    if((nowYear%4===0 && nowYear % 100 !==0) || nowYear%400===0) { //?????? ??????
                        lastDate[1]=29;
                    }

                    $(".year_mon").text(nowYear+"??? "+(nowMonth+1)+"???");

                    for (i=0; i<firstDay; i++) { //????????? ??? ??????
                        $("#calendar tbody:last").append("<td></td>");
                    }
                    for (i=1; i <=lastDate; i++){ // ?????? ?????????
                        plusDate = new Date(nowYear,nowMonth,i).getDay();
                        if (plusDate==0) {
                            $("#calendar tbody:last").append("<tr></tr>");
                        }
                        $("#calendar tbody:last").append("<td class='date'>"+ i +"</td>");
                    }
                    if($("#calendar > tbody > td").length%7!=0) { //????????? ??? ??????
                        for(i=1; i<= $("#calendar > tbody > td").length%7; i++) {
                            $("#calendar tbody:last").append("<td></td>");
                        }
                    }
                    $(".date").each(function(index){ // ?????? ?????? ??????
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
            <!-- ?????? ?????? -->
            <header class="header">
                <h1>
                    <a href="/board/list" title="???????????? ???" style="font-size:40px;text-align:center;">
                        ??????
                    </a>
                </h1>
                <div class="box">
                <div  style="position:relative;">
                   <p>
                       <strong><span><sec:authentication property="principal.member.userName"/>&nbsp</span></strong><span>???&nbsp&nbsp&nbsp&nbsp</span>
                        <em class="cateInfo" style="cursor:pointer;">
	                    		<sec:authentication property="principal.member.cate"/> ??????
	                        </em>
                   </p>
                   <div style="position:absolute;top:-2px;right:44px;">
	                   <form action="/logout" method="post">
							<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
							<button>????????????</button>
						</form>
                   </div>
                </div>    
                </div>
                 <div class="search" style="position: absolute;top: 39px;right: 137px;">
	                    <div>
	                        <form id="allSearchForm" action="/board/searchAll" method="get">
	                            <select style="display:none;"  name="allType">
	                                <option value="TC" <c:out value="${pageMaker.cri.allType=='TC'?'selected':''}" />>??????+??????</option>
	                            </select>
	                            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	                            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	                            <input type="text" name="allKeyword" value="${pageMaker.cri.allKeyword}" style="width: 200px;border: 1px solid #4a4a4a;outline:none;" placeholder="????????????">
	                            <button class="btn">???&nbsp;???</button>		
	                        </form>
	                    </div> 
	                </div>  
            </header>
            <!-- ??????????????? ?????? -->
            <div class="navWrap">
                <ul class="nav">
                    <li class="nav_el">
                        <h4><a href="javascript:void(0);" title="?????? ?????????">?????? ?????????</a><i></i></h4>
                        <div class="sub_el">
                            <ul>
                                <li>
                                    <a href="http://localhost:8080/board/elist?cate=0" title="????????????">????????????</a>
                                </li>
                                <li>
                                    <a href="http://localhost:8080/board/elist?cate=1" title="1?????? ?????????"> 1?????? ????????? </a>
                                </li>
                                <li>
                                    <a href="http://localhost:8080/board/elist?cate=2" title="2?????? ?????????"> 2?????? ????????? </a>
                                </li>
                                <li>
                                    <a href="http://localhost:8080/board/elist?cate=3" title="3?????? ?????????"> 3?????? ????????? </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav_el">
                        <h4><a href="javascript:void(0);" title="???????????????">???????????????</a><i></i></h4>
                        <div class="sub_el">
                            <ul>
                                <li>
                                    <a href="#" title="????????????"> ???????????? </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- ?????? ?????? -->
            <div id="container">
            	<div class="board">
            		<h2>?????????</h2>
	                <div class="registerBtn">
				    	<button><a href="/board/create">?????????</a></button>
	                </div>
	                
	                <div class="boardList">
	                    <div class="boardListIn">
	                        <h3>No.</h3>
	                        <h3>????????????</h3>
	                        <h3>??????</h3>
	                        <h3>?????????</h3>
	                        <h3>?????????</h3>
	                        <h3>?????????</h3>
	                    </div> <!--.boardListIn-->
	                    <ul>
	                     <c:forEach var="list" items="${pinList}">
		                        <li>
		                            <p class="bno"><img src="/resources/images/bell.png" width="25px" height="25px" style="position: absolute;top: 5px;left: -2px;"></p>
		                            <p class="cate">
		                            	<c:choose>
				                    		<c:when test="${list.cate=='0'}">
						                    	<c:out value="??????" />
				                    		</c:when>
				                        	<c:otherwise>
				                        		 <c:out value="${list.cate}??????" />
					                        </c:otherwise>	
					                    </c:choose>
		                            </p>
		                            <p class="title">
			                            <c:if test="${list.date>=nowday}">
				                            <span class="newTxt" style="color:red;">
												N
				                            </span>
			                            </c:if>
		                            	<a href="/board/read/${list.cate}?bno=${list.bno}">${list.title}</a>[${list.replyCnt}]
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
						                    	<c:out value="??????" />
				                    		</c:when>
				                        	<c:otherwise>
				                        		 <c:out value="${boardlist.cate}??????" />
					                        </c:otherwise>	
					                    </c:choose>	
		                            </p>
		                            <p class="title">
			                            <c:if test="${boardlist.date>=nowday}">
				                            <span class="newTxt" style="color:red;">
												N
				                            </span>
			                            </c:if>
		                            	<a href="/board/read/${boardlist.cate}?bno=${boardlist.bno}">${boardlist.title}</a>[${boardlist.replyCnt}]
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
	                        <form id="searchForm" action="/board/elist" method="get">
	                       		<input type="hidden" name="cate" value="${pageMaker.cri.cate}">
	                            <select name="type">
	                                <option value="" <c:out value="${pageMaker.cri.type==null?'selected':''}" />>--</option>
	                                <option value="T" <c:out value="${pageMaker.cri.type=='T'?'selected':''}" />>??????</option>
	                                <option value="C" <c:out value="${pageMaker.cri.type=='C'?'selected':''}" />>??????</option>
	                                <option value="W" <c:out value="${pageMaker.cri.type=='W'?'selected':''}" />>?????????</option>
	                                <option value="TC" <c:out value="${pageMaker.cri.type=='TC'?'selected':''}" />>??????+??????</option>
	                            </select>
	                            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	                            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">	
	                            <input type="text" name="keyword" value="${pageMaker.cri.keyword}" class="keyword">		
	                            <button class="btn btn-primary">???&nbsp;???</button>		
	                                
	                        </form>
	                    </div> 
	                </div> 
	                
	                    
	                <div class="pager">
	                    <ul>
	                     	<c:if test="${pageMaker.prev}">
	                        	<li><a href="/board/elist?cate=${pageMaker.cri.cate}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.first}&amount=${pageMaker.cri.amount}">??????</a></li>
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
	                        	<li><a href="/board/elist?cate=${pageMaker.cri.cate}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.last}&amount=${pageMaker.cri.amount}">??????</a></li>
	                        </c:if>
	                    </ul>
	                </div> <!--.Pager-->
	            </div> <!--.board-->
            </div>
        </div>
		<div style="position: absolute;top: 220px;right: 65px;background-color: aliceblue;width: 400px;height: 185px;">
			<div style="margin: 26px 0 0 28px;">
				<p style="font-size: 33px;margin-bottom: 21px;"><sec:authentication property="principal.member.userName"/></p>
				<p style="font-size: 21px;margin-bottom: 21px;"><sec:authentication property="principal.member.dept"/> ???</p>
				<p><sec:authentication property="principal.member.phone"/></p>
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
		                <th>???</th>
		                <th>???</th>
		                <th>???</th>
		                <th>???</th>
		                <th>???</th>
		                <th>???</th>
		                <th>???</th>
		            </tr>
		        </thead>
		        <tbody>
		        </tbody>
		    </table>
		</div> 
		<div class="cateTxt" style="display:none; width: 700px;   height: 330px;    position: fixed;    top: 50%;    left: 50%;    margin: -187px 0 0 -408px;    background-color: #fff;    text-align: center;    font-size: 20px;    padding-top: 46px;">
			<span class="close" style="position: absolute;    top: -60px;    left: 50%;    font-size: 35px;    border: 1px solid #222;    padding: 0px 15px;    margin-left: -25px;">X</span>
			<p>??? ?????? ?????? ???</p>
			<p>??? ???????????? 1??????</p>
			<p>*  1??????>2?????? : ????????? ???, ?????? ???, ?????? ??? ?????? 10??? ??????</p>
			<p> *  2??????>3?????? : ????????? ???, ?????? ??? ,?????? ??? ?????? 20??? ??????</p>
			<p>* 1?????? : 2??????, 3?????? ????????? ?????? ??????</p>
			<p>* 2?????? : 3?????? ????????? ?????? ??????</p>
		</div>
		<script>
			var cate=$(".cateInfo").text();
			var orgCate=cate.replace(/[^0-9]/g,'');
			$(".title").on("click","a",function(){
				var boCate=$(this).parent().siblings(".cate").text();
				var	orgBoCate=boCate.replace(/[^0-9]/g,'');
				
				if(orgCate<orgBoCate && orgCate!=0){
					alert("????????? ?????? ?????? ????????? ????????? ?????????.");
					return false;
				}
			})
			if($("input[name='allKeyword']").val().length!=0){$(".pager").css('opacity','0');}
			$(".cateInfo").click(function(){$(".cateTxt").show(500)});
			$(".close").click(function(){$(".cateTxt").hide(500)});
		</script> 
    </body>
</html>
