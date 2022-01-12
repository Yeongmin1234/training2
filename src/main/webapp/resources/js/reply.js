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
	
	
//	var pageNum = 1;
//	var replyPageFooter = $(".reply-footer");
//	
//	function showReplyPage(replyCnt) {
//		
//		var endNum = Math.ceil(pageNum/10.0) * 10;
//		var startNum = endNum - 9;
//		
//		var prev = startNum != 1;
//		var next = false;
//		
//		if (endNum * 10 >= replyCnt) {
//			endNum = Math.ceil(replyCnt/10.0);
//		}
//		
//		if (endNum * 10 < replyCnt) {
//			next = true;
//		}
//		
//		var str = "<ul class='pagenation' style='display: flex;justify-content:center;'>";
//		
//		if (prev) {
//			str += "<li><a class='pagenation__arr pagenation__arr--prev' href ='" + (startNum - 1) + "'>Previous</a></li>";
//		}
//		
//		for(var i = startNum; i <= endNum; i++) {
//			var active = pageNum == i? "active" : "";
//			
//			str += "<li style='margin: 0 5px;'><a class='" + active + "' href='" + i + "' style='color: #777;'>" + i + "</a></li>";
//		}
//		
//		if (next) {
//			str += "<li><a class='pagenation__arr pagenation__arr--next' href='" + (endNum + 1) + " '>Next</a></li>";
//		}
//		
//		str += "</ul></div>";
//		
//		// console.log(str)
//		replyPageFooter.html(str);
//	}
//	
	function showList(page) {
		// getList 함수 호출 시작
		
		//	alert("aaa");
		
		replyService.getList({bno:bnoValue, page:page||1}, function(list) {
			
				console.log(list.length-1)
							
				var str = "";
				
				if(list == null || list.length==0) {
					replyUL.html("");	
					return;
				}
				console.log(list);
				for(var i = 0, len=list.length || 0; i < len; i++) {
					str+="<li class='reply_view'>";
					str+="<div style='display:flex;margin-left:"+40*list[i].redepth+"px;'>";
					str+="<div style='margin-left: 30px;display:flex;'>";
					str+="<span class='replyer' style='margin:0 15px;'>"+list[i].replyer+"</span>";
					str+="<i class='reply'>"+list[i].reply+"</i></div>";
					if(list[i].replyer!="삭제된 댓글 입니다."){
					
	                    str+="<div class='right' style='display:flex;margin-left: 10px;'><div style='margin-right:20px'>"+replyService.displayTime(list[i].replyDate)+"</div>";
						str+="<div id='ModBtn'>수정</div>";
						
						if(list[i].redepth==0){
						str+="<div id='reChat' style='cursor:pointer'>&nbsp&nbsp답글</div>";
						}
						
						str+="<div id='RemoveBtn'>&nbsp&nbsp삭제</div>";
						str+="<span class='rnoColumn'>"+list[i].rno+"</span><i style='display:none'>"+list[i].redepth+"</i></div>";
	                    str+="<span class='blindBtn'>수정</span><i class='blindBtn closer' style='margin-left: 8px;'>취소</i>";
						str+="</div>";	
	                    str+="<p class='rcIn' style='display:flex;'><span></span><i style='display:none;margin-top: 9px;'><button id='reRegisterBtn' class='btn' style='margin-left: 15px;'>등록</button><button class='btn close' style='margin-left: 8px;'>취소</button></i></p>";
					} else{
						if(list[i]==list[list.length-1]){
							var tRno=list[i].rno;
							replyService.remove( 
								tRno,				 
								function(count){ 
								console.log(count);
									if(count === "success"){
										showList(1);
									}
								},				 
								function(error){	 
									alert("error.....");
								}					 
							)
						} else if(list[i+1].redepth!=1){
							var tRno=list[i].rno;
							replyService.remove( 
								tRno,				 
								function(count){ 
								console.log(count);
									if(count === "success"){
										showList(1);
									}
								},				 
								function(error){	 
									alert("error.....");
								}					 
							)
						}
					}
                    str+="</li>";
				} 
				
				replyUL.html(str);
				
			}) 
	} 
	
	
	var replyT = $("#reply");				
	var RegisterBtn = $("#RegisterBtn");
	
	
	RegisterBtn.on("click", function(e) {
		if(replyT.val()=="" || replyT.val()==" "){alert("댓글을 입력해 주세요.");return false;}
		var reply = {
				reply : replyT.val(),
				bno : bnoValue
			};
		if (confirm("등록 하시겠습니까?")){
			replyService.add(reply, function(result) {
					replyT.val("");
					showList(1);
					}
					)
			} else{replyT.val("");};			
		})
		$('.closer').click(function(){if(confirm("취소 하시겠습니까?")){$(this).parent().parent().css('display','none')}})


		$(".chat").on("click", "#reChat", function(e) {
			e.preventDefault();
			var rno=$(this).siblings("span").html();
			var inBox=$(this).parent().parent().next('p').find("span");
			var reBtn=$(this).parent().parent().next('p').find("i").find("#reRegisterBtn");
			
			$(this).parent().parent().next('p').css('display','flex')
			$(this).parent().parent().next('p').find("i").css('display','block');
			
			inBox.html("<input style='outline:none; width: 500px;margin: 8px 0 0 85px;' type='text' name=reply value='' placeholder='대댓글을 입력해 주세요'>")
			
			$('.close').click(function(){if(confirm("취소 하시겠습니까?")){$(this).parent().parent().css('display','none')}})
		
			reBtn.on("click", function(e) {
				var reVal = $(this).parent().siblings("span").find("input");
				var reply = {
						reply : reVal.val(),
						bno : bnoValue,
						reparent : rno,
						redepth : 1
					};
				if(reVal.val()=="" || reVal.val().length==0){alert("대댓글을 입력해주세요."); return false;}
					if (confirm("등록 하시겠습니까?")){
						replyService.add(reply, function(result) {reVal.val("");showList(1);})
						
						} else{reVal.val("");};
			})
		});
		
		
		$(".chat").on("click", "#RemoveBtn", function(e) {
					var rno=$(this).siblings("span").html();
					var dept=$(this).siblings("i").html();
					var par=$(this).parent().parent().parent().next("li").find("div").css('margin-left')
					console.log(par!="0px");
				if (confirm("삭제 하시겠습니까?")){
					 if (dept==1 || par!="40px"){
						replyService.remove( 
								rno,				 
								function(count){ 
								console.log(count);
									if(count === "success"){
										showList(1);
									}
								},				 
								function(error){	 
									alert("error.....");
								}					 
							)
						} else if(dept==0){
						replyService.delUpdate(rno, function(result) {
							showList(1);
						});
					}
					}
						return false;
		})
		
		
		$(".chat").on("click", "#ModBtn", function(e) {
			e.preventDefault();
			var rno=$(this).siblings("span").html();
			var par=$(this).parent("div").siblings("div").find("i");
			var disa=$(this).parent("div");
			var bBtn=$(this).parent("div").siblings("span");
			var cBtn=$(this).parent("div").siblings("i");
			var reply=par.html();
			disa.css({'display':'none'});
			bBtn.css({'display':'block'});
			cBtn.css({'display':'block'});
			par.contents().unwrap().wrap("<input style='width: 185px;margin: 0 15px;' type='text' class='modInput' name=reply value='"+reply+"'>");
			cBtn.click(function(){
				if (confirm("취소 하시겠습니까?")){
					showList(1);
				}
			})
			bBtn.on("click", function(e) {
			var ModReplypar=$(".modInput").val();
			var reply = {rno:rno, reply :ModReplypar};
			if(ModReplypar.length==0 || ModReplypar==" "){alert("댓글을 입력해주세요."); return false;}
				if (confirm("수정 하시겠습니까?")){
			replyService.update(reply, function(result) {
				showList(1);
			});
			}
//			else{$(".modInput").val("")}
		});
		});
		
		// 댓글 삭제 처리

	// 댓글의 페이징 버튼을 클릭하면
//	replyPageFooter.on("click","li a",function(e){
//		e.preventDefault();
//		console.log("page click");
//		var targetPageNum=$(this).attr("href");
//		
//		console.log("targetPageNum : "+targetPageNum);
//		pageNum = targetPageNum;
//		showList(pageNum);
//		modal.find("input").val("");
//	})
	})





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
	
	function getList(param, callback, error) {			 
			var bno = param.bno;
			var page = param.page || 1;
			
			$.getJSON("/replies/pages/" + bno + "/" + page + ".json", 
				function(data) {
					if (callback) {
						callback(data);
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
	
	
	function delUpdate(rno, callback, error) {				 
		console.log("reply......")
		
		
		$.ajax({											 
			type: 'post',
			url: "/replies/" + rno,
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
		
//		if (gap < (1000*60*60*24)) {
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
//			return ;
//		} else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd, " ", (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss ].join('');
//		}
	}
	
	
	
	
	
	
	
	
	
	
	return {
		add:add, 
		delUpdate:delUpdate, 
		getList:getList,
		remove:remove,
		update:update,
		get:get,
		displayTime:displayTime
		};
})();
