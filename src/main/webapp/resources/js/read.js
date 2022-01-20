/**
 * 
 */
$(document).ready(function(){
	var bno=$("#bno").val();
	var cate=$("#cate").val();
	console.log(bno)
	//alert(bno)
	$.getJSON(cate+"/fileGetAttachList",{bno:bno},function(arr){
		console.log(arr)
		if(arr.length==0){console.log("aaa");$(".uploadResult").parent().parent().css('display','none');}
		var str="";
		$(arr).each(function(i,attach){
			console.log(attach.filetype=="true");
			if(attach.filetype=="true"){ 
				var fileCallPath =  encodeURIComponent( attach.uploadpath+ "/"+attach.uuid +"_"+attach.filename);
				str +="<li style='list-style-type: decimal;margin-left:20px;' data-path='"+attach.uploadpath+"'";
				str +=" data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'>"
				str +="<div>";
				str +="<span><a style='color: #222;' href='/fileDownload?fileName="+fileCallPath+"'>"+ attach.filename+"</a></span>";
				str +="</div>";  
				str +="</li>";  
			}else{	 
			var FileCallPath =  encodeURIComponent( attach.uploadpath+ "/"+attach.uuid +"_"+attach.filename);
				str += "<li style='list-style-type: decimal;margin-left:20px;'"
				str += "data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'>";
				str += "<div><span><a style='color: #222;' href='/fileDownload?fileName="+FileCallPath+"'>"+ attach.filename+"</a></span>";
				str += "</div>";
				str +"</li>";
			}
		}) 
		$(".uploadResult ol").html(str);
	})
})