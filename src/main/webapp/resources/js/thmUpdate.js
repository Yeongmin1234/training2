/**
 * 
 */
$(document).ready(function(e){
	var ofn=$("#ofn").val();
	
   var formObj=$("form[role='form']");

   $(".button--default").on("click",function(e){

      e.preventDefault();
      		var title=$("#title").val();
			var text=$("#txtContent").val();
			
		   	if(title.length==0){
				alert("제목을 입력해주세요.");
				return false;
			} else if(text.length==0){
				alert("내용을 입력해주세요.");
				return false;
			}
		var str=""
	if($("#txt").text()==""){
	 $(".tuploadResult ul li").each(function(i,obj){
	    	  var jobj=$(obj);
			  str+="<input type='hidden' id='try' name='thumbnail' value='/resources/thumb"+"/s_"+jobj.data("uuid")+"_"+jobj.data("filename")+"'>";
	      })
		}else{
      $(".tuploadResult ul li").each(function(i){
		 str+="<input type='hidden' id='try' name='thumbnail' value='"+ofn+"'>";
      })
		}
      formObj.append(str).submit();
   })
   var regex = new RegExp("(.*?)\.(jpg|jpeg|png|gif)$");
   var maxSize = 5242880; 
   // checkExtension함수 선언
   function checkExtension(filename, fileSize) {
      if (fileSize >= maxSize) {
         alert("파일 사이즈 초과");
		$("input[type='file']").val(null);
         return false;
      }
      if (regex.test(filename)==false) {
         alert("해당 종류의 파일은 업로드할 수 없습니다.");
		$("input[type='file']").val(null);
         return false;
      }
      return true;
   } 


	var ofn=$("#ofn").val();
	var txt=$("#txt");
	var last=ofn.charAt(ofn.length-1)
	var cut=ofn.substring(56,ofn.indexOf(last))
	var li = $("#uBtn").closest('li');
	txt.html(cut+last);
	$("#uBtn").on("click",function(){
		if(confirm("삭제하시겠습니까?")){
		li.remove();	
		}
	})


	

   $("input[name='tuploadFile']").change(function(e) {
	
      var formData = new FormData();

      var inputFile = $("input[name='tuploadFile']");

      var files = inputFile[0].files;

      console.log(files);

      for (var i = 0; i < files.length; i++) {
         // checkExtension함수 호출
         if (!checkExtension(files[i].name, files[i].size)) {
            return false;
         }
     
         formData.append("tuploadFile", files[i]);
      }

      $.ajax({
         url : '/uploadAjaxActions',
         processData : false,
         contentType : false,
         data : formData,
         type : 'POST',
         dataType : 'json',
         success : function(result) {
      
            console.log(result);
            
            showUploadResult(result);
      

         }
      }); //$.ajax
      
   }); //$("input[type='file']").change(function(e) { 이벤트 끝
   function showUploadResult(uploadResultArr){
    
         if(!uploadResultArr || uploadResultArr.length==0){
            return;
         }
         var uploadUL = $(".tuploadResult ul");
        
		uploadUL.find('li').remove();
		
         var str = "";
         
         $(uploadResultArr).each(function(i, obj){
           console.log(obj);
           
           if(obj.image){
               var fileCallPath =  encodeURIComponent("\\thumb/s_"+obj.uuid +"_"+obj.fileName);
               str += "<li data-path='"+obj.uploadPath+"'";
               str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
               str +=" ><div>";
               str += "<span> "+ obj.fileName+"</span>";
               str += "<button type='button' data-file=\'"+fileCallPath+"\' ";
               str += "data-type='image'>X</button><br>"
               str += "</div>";
               str +="</li>";
            } 
         });
         
         uploadUL.append(str);
       }
   $(".tuploadResult").on("click","button", function(e){
	   
		  var targetFile = $(this).data("file");
		  var type = $(this).data("type");
		  
		  console.log(targetFile);
			  var targetLi=(this).closest("li");
		  
		  $.ajax({
		    url: '/tdeleteFile',
		    data: {fileName: targetFile, type:type},
		    dataType:'text',
		    type: 'POST',
		      success: function(result){
		         alert(result);
		         targetLi.remove();
		       }
		  }); //$.ajax
		  
		});
   
   
})