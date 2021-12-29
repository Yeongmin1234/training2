/**
 * rest 방식으로 댓글 처리하기(ajax사용)
 */

console.log("@@@@@@@@@@ Reply Module @@@@@@@@@@");
	

// 함수 호출부
// 선택자		이벤트
$(document).ready(function() {
	
	$(".active").css({'color':'#fff','font-size':'bold'});
	
	var bnoValue = $("#bno").val();	// 게시판 번호
	var rnoValue = $("#rno").val();	// 게시판 번호
							// .val() : 선택된 id(bno)의 value값을 가져옴.
	// $("#bno").val(1); 위와 동일
	var replyUL=$(".chat");
	
	console.log(bnoValue);
	

	
	showList(1);	// showList 함수 호출
	
	
	// p440
	var pageNum = 1;
	var replyPageFooter = $(".reply-footer");
	
	function showReplyPage(replyCnt) {
		
		var endNum = Math.ceil(pageNum/10.0) * 10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1;
		var next = false;
		
		if (endNum * 10 >= replyCnt) {
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if (endNum * 10 < replyCnt) {
			next = true;
		}
		
		var str = "<ul class='pagenation' style='display: flex;justify-content:center;'>";
		
		if (prev) {
			str += "<li><a class='pagenation__arr pagenation__arr--prev' href ='" + (startNum - 1) + "'>Previous</a></li>";
		}
		
		for(var i = startNum; i <= endNum; i++) {
			var active = pageNum == i? "active" : "";
			
			str += "<li style='margin: 0 5px;'><a class='" + active + "' href='" + i + "' style='color: #777;'>" + i + "</a></li>";
		}
		
		if (next) {
			str += "<li><a class='pagenation__arr pagenation__arr--next' href='" + (endNum + 1) + " '>Next</a></li>";
		}
		
		str += "</ul></div>";
		
		// console.log(str)
		replyPageFooter.html(str);
	}
	
	// showList 함수 선언 시작
	function showList(page) {
		// getList 함수 호출 시작
		
		//	alert("aaa");
		
		replyService.getList({bno:bnoValue, page:page||1}, function(replyCnt, list) {
			
			
			var rereplyT = $("#rereply");				
			var registerBtn = $("#registertBtn");
			
		
							//'{ ~ }'은 JSON type			'function(list)'는 callback 함수
				if(page == -1) {
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
							
							
				var str = "";
				
				// select 된 결과가 없으면
				if(list == null || list.length==0) {
					replyUL.html("");	
					return;
				}
				
				console.log(list);
				
				for(var i = 0, len=list.length || 0; i < len; i++) {
					str+="<li class='reply_view' style='margin-left: "+20*list[i].redepth+"px;'>"
					str+="<div style='margin-left: 30px;display:flex;'><span style='margin:0 15px;'>"+list[i].replyer+"</span><i class='reply'>"+list[i].reply+"</i></div>"
//                    str+="<div class='comment-view__area'>"
//                    str+="<div class='comment-view__thumb'>"
//                    str+="<a href='#'><img src='/resources/images/commu/char0.png' alt='' />"
//                    str+="</a></div>"
//                    str+="<div class='comment-view__contents'>"
//                    str+="<div class='comment-view__info'>"
//                    str+="<input type='hidden' name='rno' id='rno'  value='"+list[i].rno+"' >"
//                    str+="<a href='#' class='comment-view__user'>"
//                    str+="<span>LV.8</span>"
//                    str+="<span>&nbsp"+list[i].replyer+"</span>"
//                    str+="</a>"
//                    str+="<span class='comment-view__date'>"+replyService.displayTime(list[i].replyDate)+"</span>"
//                    str+="<button type='button' class='rereply'><i class='ico ico--reple'></i></button>"
                    str+="<div style='display:flex;margin-left: 10px;'><div style='margin-right:20px'>"+replyService.displayTime(list[i].replyDate)+"</div><div id='ModBtn'>수정</div><div id=''>&nbsp&nbsp답글</div><div id='RemoveBtn'>&nbsp&nbsp삭제</div><span class='rnoColumn'>"+list[i].rno+"</span></div>"
//                    str+="</div>"
                    str+="<span class='blindBtn'>수정</span>"
//                    str+="</div>"
//                    str+="</div>"
                    str+="</li>"
				}
				
				replyUL.html(str);
				
				showReplyPage(replyCnt);
			}) // getList 함수 호출 끝
	}	// showList 함수 선언 끝
	
	
	var replyT = $("#reply");				
	var ModBtn = $("#ModBtn");
	var RegisterBtn = $("#RegisterBtn");
	
	RegisterBtn.on("click", function(e) {
		if(replyT.val()=="" || replyT.val()==" "){alert("댓글을 입력해 주세요.");return false;}
		var reply = {
				reply : replyT.val(),
				bno : bnoValue
			};
		replyService.add(reply, function(result) {
			if (confirm("등록 하시겠습니까?")){
			replyT.val("");
			showList(1);
			} else{replyT.val("");};
			}
			)
			
		})

			
		
		$(".chat").on("click", "#RemoveBtn", function(e) {
					var rno=$(this).siblings("span").html();
				if (confirm("삭제 하시겠습니까?")){
					replyService.remove( 
							rno,				 
							function(count){ 
							console.log(count);
							
								if(count === "success"){
									showList(pageNum);
									
								}
							},				 
							function(error){	 
								alert("error.....");
							}					 
						)
					}
						return false;
		})
		$(".chat").on("click", "#ModBtn", function(e) {
			e.preventDefault();
			var rno=$(this).siblings("span").html();
			var par=$(this).parent("div").siblings("div").find("i");
			var disa=$(this).parent("div");
			var bBtn=$(this).parent("div").siblings("span");
			var reply=par.html();
			disa.css({'display':'none'});
			bBtn.css({'display':'block'});
			par.contents().unwrap().wrap("<input style='width: 185px;margin: 0 15px;' type='text' class='modInput' name=reply value='"+reply+"'>");
			bBtn.on("click", function(e) {
			var ModReplypar=$(".modInput").val();
			var reply = {rno:rno, reply :ModReplypar};
			if(ModReplypar.length==0 || ModReplypar==" "){alert("댓글을 입력해주세요."); return false;}
				if (confirm("수정 하시겠습니까?")){
			replyService.update(reply, function(result) {
				showList(pageNum);
			});
			}
		});
		});
		
		// 댓글 삭제 처리

	// 댓글의 페이징 버튼을 클릭하면
	replyPageFooter.on("click","li a",function(e){
		e.preventDefault();
		console.log("page click");
		var targetPageNum=$(this).attr("href");
		
		console.log("targetPageNum : "+targetPageNum);
		pageNum = targetPageNum;
		showList(pageNum);
		modal.find("input").val("");
	})
	})

	$(".chat").on("click",".dd",function(e){
						e.preventDefault();
						var par=$(this).parent("div").parent("div").parent("div").parent("li").next("ul");
						alert("aaa");
						var strr="";
					
								strr+="<li class='comment-view__article comment-view__article--reple'>"
			                    strr+="<div class='comment-view__reple'>"
			                    strr+="<img src='/resources/images/commu/ico_comment-reple.png' alt=''></div>"
			                    strr+="<div class='comment-view__area'>"
			                    strr+="<div class='comment-view__thumb'><a href='#'>"
			                    strr+="<img src='/resources/images/commu/char0.png' alt=''>"
			                    strr+="</a></div>"
			                    strr+="<div class='comment-view__contents'>"
			                    strr+="<div class='comment-view__info'>"
			                    strr+="<a href='#' class='comment-view__user'>"
			                    strr+="<span>LV.8</span><span>고래입냄시</span></a>"
			                    strr+=" <span class='comment-view__date'>2021년 3월 01일 10:00</span>"
			                    strr+="<div class='comment-view__admin'><div>수정</div><div>삭제</div></div></div>"
			                    strr+="<div class='comment-view__desc'>아주 멋진 탱크네요!</div>"
			                    strr+="</div>"
			                    strr+="</div>"
			                    strr+="</li>"
								
					
					
					
					par.html(strr);		
				});




var replyService = (function() {
	
	
	function add(reply, callback, error) {				 
		console.log("reply......")
		
		
		$.ajax({											 
			type: 'post',
			url : '/replies/new',	 
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})													 
	}		
	
	function readd(reply, callback, error) {				 
		console.log("reply......")
		
		
		$.ajax({											 
			type: 'post',
			url : '/rereplies/new',	 
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})													 
	}													 
	
	function getList(param, callback, error) {			 
			var bno = param.bno;
			var page = param.page || 1;
			
			$.getJSON("/replies/pages/" + bno + "/" + page + ".json", 
				function(data) {
					if (callback) {
						callback(data.replyCnt, data.list);
					}
			}) 
			.fail(function(xhr, status, err) {
				if (error) {
					error();
				}
			});	 
	}												
	
	
	
	function remove(rno, callback, error) {				 
		$.ajax({	 						 
			type: "delete",
			url: "/replies/" + rno,
			success : function(result, status, xhr) {			 
				if (callback) {
					callback(result);
				}
			},													 
			error : function(xhr, status, er) {					 
				if (error) {
					error(er);
				}
			}												 
			
		})												 
	}													 
	
	
	
	// update 함수
	function update(reply, callback, error) {			 
		console.log("RNO = " + reply.rno);
		$.ajax({										
			type: "put",
			url: "/replies/" + reply.rno,
			data: JSON.stringify(reply),
			contentType : "application/json; charset=UTF-8",
			success : function(result, status, xhr) {	 
				if (callback) {
					callback(result);
				}
			},											
			error : function(xhr, status, er) {			
				if (error) {
					error(er);
				}
			}											
			
		})												 
	}													
	
	
	
	function get(rno, callback, error) {				
		$.get("/replies/" + rno + ".json", 	
			function(result) {
				if (callback) {
					callback(result);
				}
		})
		.fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}										
	
	
	
	function displayTime(timeValue) {
		var today = new Date();	 
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str = "";
		
		if (gap < (1000*60*60*24)) {
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss ].join('');
		} else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd ].join('');
		}
	}
	
	
	
	
	
	
	
	
	return {
		add:add, 
		readd:readd, 
		getList:getList,
		remove:remove,
		update:update,
		get:get,
		displayTime:displayTime
		};
})();
