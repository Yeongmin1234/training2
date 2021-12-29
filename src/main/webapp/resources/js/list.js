/**
 * 
 */
// 검색버튼 선택

$(document).ready(function() {	// '$'를 쓰기 위헤선 헤더 부분에 script태그로 jquery를 추가해주어야 
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function (e) {
		// 사용자가 검색을 할 때, 검색 종류를 선택하지 않았을 경우
		if(!searchForm.find("option:selected").val()) {
			alert("검색 종류를 선택하세요.");
			return false;	// 실행 X
		}
		
		// 사용자가 검색을 할 때, 키워드를 입력하지 않았을 경우
		if(!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요.");
			return false;
		}
		
		// 검색버튼을 클릭하였을 때 1번 페이지로 이동
		searchForm.find("input[name='pageNum']").val("1");
		
		e.preventDefault();	// 기존에 이벤트가 있으면 다 취소해라!
		searchForm.submit();
	});
}) 