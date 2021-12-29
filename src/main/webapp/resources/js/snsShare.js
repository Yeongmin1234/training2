var snsModule = (function () {
	'use strict';

	var title = $('meta[property="og:title"]').attr('content'), // 공유할 페이지 타이틀
	url = $('meta[property="og:url"]').attr('content'), // 공유할 페이지 URL
	tags = "", // 공유할 태그
	imageUrl = $('meta[property="og:image"]').attr('content'), // 공유할 이미지
	description = $('meta[property="og:description"]').attr('content'); // 공유할 설명

	var encodeTitle = encodeURIComponent(title),
	    encodeUrl = encodeURIComponent(url),
	    encodeTags = encodeURIComponent(tags),
	    encodeImage = encodeURIComponent(imageUrl); // 공유할 이미지

	var snsModule = {
		band: function () {
		window.open("http://band.us/plugin/share?body=" + encodeTitle + encodeURIComponent("\n") + encodeUrl + "&route=" + encodeUrl, "band", "width=410, height=540, resizable=no");
		},
		naverblog: function () {
		window.open("http://blog.naver.com/openapi/share?title=" + encodeTitle + "&url=" + encodeUrl, "naver blog", "width=410, height=540, resizable=no");
		},
		twitter: function () {
		window.open("http://www.twitter.com/intent/tweet?text=" + encodeTitle + "&url=" + encodeUrl + "&hashtags=" + encodeTags, 'twitter', "width=500, height=450, resizable=no");
		},
		facebook : function() {
		var url = 'http://www.facebook.com/sharer.php?u=' + encodeUrl ;
		window.open(url,'', 'width=400,height=400,left=600');
		},
		kakaoStory : function() {
			Kakao.Story.share({
				url: url,
				text: title
			});
		}
	};

	return snsModule;
}());

// url 복사하기
function copyCurrentUrl(){
	var url = window.document.location.href;
	
	$("body").append("<input type='text' id='urlSave' style='position: absolute; left: -99999px;' />");
	
	url = url.replace("#event1","");
	$('#urlSave').val(url);
	$('#urlSave').select();
	
	document.execCommand("copy");
	alert("주소가 복사되었습니다. 원하는 곳에 붙여넣기 해 주세요.");
	
	$("#urlSave").remove();
}