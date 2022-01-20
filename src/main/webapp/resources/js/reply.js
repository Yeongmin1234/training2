/**
 * rest 방식으로 댓글 처리하기(ajax사용)
 */

console.log("@@@@@@@@@@ Reply Module @@@@@@@@@@");
	

// 함수 호출부
// 선택자		이벤트
$(document).ready(function() {
	
	$(".active").css({'color':'#fff','font-size':'bold'});
	
	var bnoValue = $("#bno").val();	// 게시판 번호
	var replyUL=$(".chat");
	var replyer = $("#who").val();       //댓글쓸사람
	var replyerId = $("#whoId").val();   //댓글쓸사람id
	var boardHost = $("#writer").text(); //게시판글쓴이

	var header = $("meta[name='_csrf_header']").attr("content");
	var token = $("meta[name='_csrf']").attr("content");
	//CSRF AJAX 사용
	$(document).ajaxSend(function(e, xhr, options){
	        xhr.setRequestHeader(header, token);
	    });  

	console.log(bnoValue);
	

	
	showList(1);	// showList 함수 호출
	
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
					if(list[i].redepth>0){
						str+="<div id='comment' style='display:flex;margin-left:40px;'>";
					} else{
						str+="<div id='comment' style='display:flex;'>";
					}
					
					str+="<div style='margin-left: 30px;display:flex;'>";
					str+="<span class='replyer' style='margin:0 15px;'>"+list[i].replyer+"</span>";
					str+="<i class='reply'>"+list[i].reply+"</i></div>";
					
					if(list[i].replyer!="삭제된 댓글 입니다."){
	                    str+="<div class='right' style='display:flex;margin-left: 10px;'><div style='margin-right:20px'>"+replyService.displayTime(list[i].replyDate)+"</div>";
						if(list[i].replyer==replyer || replyerId=='admin'){
							str+="<div id='ModBtn'>수정</div>";
						}
						if(list[i].redepth==0){
							str+="<div id='reChat' style='cursor:pointer'>&nbsp&nbsp답글</div>";
						}
						if(list[i].replyer==replyer || replyerId=='admin' || replyer===boardHost){
							str+="<div id='RemoveBtn'>&nbsp&nbsp삭제</div>";
						}
						str+="<span class='rnoColumn'>"+list[i].rno+"</span><i style='display:none'>"+list[i].redepth+"</i></div>";
	                    str+="<span class='blindBtn'>수정</span><i class='blindBtn closer' style='margin-left: 8px;'>취소</i>";
						str+="</div>";	
	                    str+="<p id='rcIn' style='display:flex;'><span id='inputBox'></span><i id='regiBox' style='display:none;margin-top: 9px;'><button id='reRegisterBtn' class='btn' style='margin-left: 15px;'>등록</button><button class='btn close' style='margin-left: 8px;'>취소</button></i></p>";
					} else{
						if(list[i]==list[list.length-1]){
							var tRno=list[i].rno;
							replyService.remove( 
								tRno,	
								replyer,			 
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
						else if(list[i+1].redepth==0){
							var tRno=list[i].rno;
							replyService.remove( 
								tRno,		
								replyer,		 
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
				replyer : replyer,
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
		$('.closer').click(function(){if(confirm("취소 하시겠습니까?")){showList(1);}})


		
		
		$(".chat").on("click", "#RemoveBtn", function(e) {
			var rno=$(this).siblings("span").html();
			var dept=$(this).siblings("i").html();
			var par=$(this).closest("li").next("li").find("div").css('margin-left')
			if (confirm("삭제 하시겠습니까?")){
				if (dept!=0 || par!="40px"){
					replyService.remove( 
						rno,		
						replyer,		 
						function(count){ 
							if(count === "success"){
								showList(1);
							}
						},				 
						function(error){	 
							alert("error.....");
						}
					)
				} else if(dept==0){replyService.delUpdate(rno, function(result) {showList(1);});}
			}
			return false;
		})
		
		
		$(".chat").on("click", "#reChat", function(e) {
			e.preventDefault();
			var i=1;
			var rno=$(this).siblings("span").html();
			var parNxt=$(this).closest("li").next("li").find("div");
			var cmtP=$(this).closest("#comment").next('p');
			var parON=parNxt.css('margin-left');
			var parTN=parNxt.parent().next("li").find("div").css('margin-left');
			var inBox=cmtP.find("span");
			var reBtn=cmtP.find("#reRegisterBtn");
			
			cmtP.css('display','flex')
			cmtP.find("i").css('display','block');
			
			if(parON=="40px"){
				if(parTN!="40px"){
					i=2;
				}else{
					i=3;
					alert("대댓글은 최대 2개까지 입니다");
					return false;
				}
			}
			
			inBox.html("<input style='outline:none; width: 500px;margin: 8px 0 0 85px;' type='text' name=reply value='' placeholder='대댓글을 입력해 주세요'>")
			
			$('.close').click(function(){if(confirm("취소 하시겠습니까?")){showList(1);}})
			reBtn.on("click", function(e) {
				var reVal = $(this).parent().siblings("span").find("input");
				var reply = {
						reply : reVal.val(),
						replyer : replyer,
						bno : bnoValue,
						reparent : rno,
						redepth : i
					};
				if(reVal.val()=="" || reVal.val().length==0){alert("대댓글을 입력해주세요."); return false;}
				if (confirm("등록 하시겠습니까?")){replyService.add(reply, function(result) {reVal.val("");showList(1);})}
				else{reVal.val("");};
			})
		});

		$(".chat").on("click", "#ModBtn", function(e) {
			e.preventDefault();
			var par=$(this).parent("div");
			var rno=$(this).siblings("span").html();
			var parD=par.siblings("div").find("i");
			var bBtn=par.siblings("span");
			var cBtn=par.siblings("i");
			var reply=parD.html();
			
			par.css({'display':'none'});
			bBtn.css({'display':'block'});
			cBtn.css({'display':'block'});
			
			parD.contents().unwrap().wrap("<input style='width: 185px;margin: 0 15px;' type='text' class='modInput' name=reply value='"+reply+"'>");
			cBtn.click(function(){
				if (confirm("취소 하시겠습니까?")){
					showList(1);
				}
			})
			bBtn.on("click", function(e) {
				var ModReplypar=$(".modInput").val();
				var reply = {rno:rno, reply :ModReplypar};
				if(ModReplypar.length==0 || ModReplypar==" "){alert("댓글을 입력해주세요."); return false;}
				if (confirm("수정 하시겠습니까?")){replyService.update(reply, function(result) {showList(1);});
				}
			});
		});
		
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
	
	
	
	function remove(rno, replyer, callback, error) {				 
		$.ajax({	 						 
			type: "delete",
			url: "/replies/" + rno,
			data: JSON.stringify({rno:rno, replyer:replyer}),
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
		var date = new Date(timeValue);
		var hh = date.getHours();
		var mi = date.getMinutes();
		var ss = date.getSeconds();
		var yy = date.getFullYear();
		var mm = date.getMonth() + 1;
		var dd = date.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd, " ", (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss ].join('');
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
