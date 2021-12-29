/**
 * 
 */
$(document).ready(function(e){

	var h = $(".hello");
   $("#img_upload_submit").on("click",function(e){

      e.preventDefault();
    	
//			var title=$("#title").val();
//			var text=$("#txtContent").val();
//			
//		   	if(title.length==0){
//				alert("제목을 입력해주세요.");
//				return false;
//			} else if(text.length==0){
//				alert("내용을 입력해주세요.");
//				return false;
//			}
			
      var str="";
      $(".uploadResult ul li").each(function(i,obj){
    	  var jobj=$(obj);
    	  
    	  str+="<input type='text' name='attachList["+i+"].filename' value='"+jobj.data("filename")+"'>"
    	  str+="<input type='text' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>"
    	  str+="<input type='text' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>"
    	  str+="<input type='text' name='attachList["+i+"].filetype' value='"+jobj.data("type")+"'>"
      })
      formObj.append(str).submit();
//      h.append(str);
   })// $("button[type='submit']") 끝
   
   var regex = new RegExp("(.*?)\.(jpg|jpeg|png|gif)$");
   var maxSize = 5242880; 

   function checkExtension(filename, fileSize) {
		
      if (regex.test(filename)==false) {
         alert("해당 종류의 파일은 업로드할 수 없습니다.");
		$("input[type='file']").val(null);
         return false;
      }
      if (fileSize >= maxSize) {
         alert("파일 사이즈 초과");
		$("input[type='file']").val(null);
         return false;
      }
      return true;
   } // checkExtension함수 끝
   $("#uploadFile").change(function(e) {
	alert("aaaaaa");
      var formData = new FormData();

      var inputFile = $("input[name='uploadFile']");

      var files = inputFile[0].files;

      console.log(files);

      for (var i = 0; i < files.length; i++) {

         if (!checkExtension(files[i].name, files[i].size)) {
            return false;
         }
     
         formData.append("uploadFile", files[i]);
      }

      $.ajax({
         url : '/uploadAjaxAction',
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
      
   }); //$("input[type='file']").change(function(e) { 이벤트 끝.


   function showUploadResult(uploadResultArr){
    
         if(!uploadResultArr || uploadResultArr.length==0){
            return;
         }
         var uploadUL = $(".uploadResult ul");
         
         var str = "";
         
         $(uploadResultArr).each(function(i, obj){
           console.log(obj);
           
           if(obj.image){
               var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
               str += "<li data-path='"+obj.uploadPath+"'";
               str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
               str +=" ><div>";
               str += "<span> "+ obj.fileName+"</span>";
               str += "<button type='button' class='delBtn' data-file=\'"+fileCallPath+"\' ";
               str += "data-type='image'>X</button><br>"
//  			   str += "<img src='/resources/img"+fileCallPath+"'>";
               str += "</div>";
               str +="</li>";
            }
           
         });
         
         uploadUL.append(str);
       }
   $(".uploadResult").on("click","button", function(e){
	   
		  var targetFile = $(this).data("file");
		  var type = $(this).data("type");
		  
		  console.log(targetFile);
			  var targetLi=(this).closest("li");
		  
		  $.ajax({
		    url: '/deleteFile',
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