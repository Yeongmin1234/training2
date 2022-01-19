/**
 * 
 */
$(document).ready(function(e){
	
    var formObj=$("form[role='form']");

	var header = $("meta[name='_csrf_header']").attr("content");
	var token = $("meta[name='_csrf']").attr("content");

   $("button[type='submit']").on("click",function(e){

      e.preventDefault();

      var havF = $(".fUploadResult ul").html();
      var havS = $(".sUploadResult ul").html();
      var fileYN = $("input[name='file']");
	
	  var title=$("#title").val();
	  var text=$("#txtContent").val();
					
   	  if(title.length==0){
		  alert("제목을 입력해주세요.");
		  return false;
	  } else if(text.length==0 || text==' ' || text=='<p>&nbsp;</p>' || text=='<p><br></p>'){
		  alert("내용을 입력해주세요.");
		  return false;
	  }
      if(havF.length>20 || havS.length>20){
      	 fileYN.val("1")
      }else if (havF.length<20 && havS.length<20){
         fileYN.val("0")
      }

      var str="";
      $(".fUploadResult ul li").each(function(i,obj){
    	  var jobj=$(obj);
    	  str+="<input type='hidden' name='attachList["+i+"].filename' value='"+jobj.data("filename")+"'>"
    	  str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>"
    	  str+="<input type='hidden' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>"
    	  str+="<input type='hidden' name='attachList["+i+"].filetype' value='"+jobj.data("type")+"'>"
      })
	
 	  var strr="";
	  $(".sUploadResult ul li").each(function(i,obj){
	    	  var jobj=$(obj);

		  if($("#fName").length){ 
			  console.log("aaa");
			  strr+="<input type='hidden' name='attachList["+i+1+"].filename' value='"+jobj.data("filename")+"'>"
	    	  strr+="<input type='hidden' name='attachList["+i+1+"].uuid' value='"+jobj.data("uuid")+"'>"
	    	  strr+="<input type='hidden' name='attachList["+i+1+"].uploadpath' value='"+jobj.data("path")+"'>"
	    	  strr+="<input type='hidden' name='attachList["+i+1+"].filetype' value='"+jobj.data("type")+"'>"
			}
			
		  else{ 
			  console.log("bbb");
	    	  strr+="<input type='hidden' name='attachList["+i+"].filename' value='"+jobj.data("filename")+"'>"
	    	  strr+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>"
	    	  strr+="<input type='hidden' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>"
	    	  strr+="<input type='hidden' name='attachList["+i+"].filetype' value='"+jobj.data("type")+"'>"
			}

	      })
	  if(confirm("저장 하시겠습니까?")){formObj.append(str+strr).submit();}else{return false};
   })
   
   var regex = new RegExp("(.*?)\.(exe|js|sh|alz)$");
   var maxSize = 10485760; //10MB
   function checkExtension(filename, fileSize) {
	
   	  if (regex.test(filename)) {
         alert("해당 종류의 파일은 업로드할 수 없습니다.");
		$("#fUploadFile").val("");
         return false;
      }

      if (fileSize >= maxSize) {
         alert("파일 사이즈 초과");
		$("#fUploadFile").val("");
         return false;
      }
   
      return true;
   }   
   $("#fUploadFile").change(function(e) {
	  var formData = new FormData();
      
	  var inputFile = $("#fUploadFile");

      var files = inputFile[0].files;

      console.log(files);

      for (var i = 0; i < files.length; i++) {
         if (!checkExtension(files[i].name, files[i].size)) {
			$("#fUploadFile").val("");
            return false;
         }
         formData.append("uploadFile", files[i]);
      }
	$(this).css('display','none');

      $.ajax({
         url : '/fileUploadAjaxAction',
         processData : false,
         contentType : false,
		 beforeSend: function(xhr){
		            xhr.setRequestHeader(header, token)
		        },
         data : formData,
         type : 'POST',
         dataType : 'json',
         success : function(result) {
      
            console.log(result);
            
            fShowUploadResult(result); 
         }
      });       
   });
   function fShowUploadResult(uploadResultArr){
         if(!uploadResultArr || uploadResultArr.length==0){
            return; 
         }
//         var uploadUL = $(".fUploadResult ul");
         
         var str = "";
         
         $(uploadResultArr).each(function(i, obj){
           console.log(obj);
           
           if(obj.image){  
               var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
               str += "<li id='fName' style='margin-left: 8px;' data-path='"+obj.uploadPath+"'";
               str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
               str +" ><div>";
               str += "<span> "+ obj.fileName+"</span>";
               str += "<button type='button' data-file=\'"+fileCallPath+"\' "
               str += "data-type='image' style='margin-left:8px;' class='btn'>X</button>";
               str += "</div>";
               str +"</li>";
            }else{  
               var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);               
                  
               str += "<li id='fName' style='margin-left: 8px;'"
               str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
               str += "<span> "+ obj.fileName+"</span>";
               str += "<button type='button' style='margin-left:8px;' data-file=\'"+fileCallPath+"\' data-type='file' " 
               str += "class='btn'>X</button>";
               str += "</div>";
               str +"</li>";
            }
           
         });
         
         $(".fUploadResult ul").append(str);
       }
   $(".fUploadResult").on("click","button", function(e){
	   	
		  var targetFile = $(this).data("file");
		  var type = $(this).data("type");
		  
		  var targetLi=(this).closest("li");
		  console.log(targetFile);
		  
		  if (confirm("삭제 하시겠습니까?")){
			  $.ajax({
			    url: '/fileDeleteFile',
			    data: {fileName: targetFile, type:type},
			    dataType:'text',
				beforeSend: function(xhr){
		            xhr.setRequestHeader(header, token)
		        },
			    type: 'POST',
			      success: function(result){
//			         alert(result);
			         targetLi.remove();
			       }
			  });
			
			$("#fUploadFile").css('display','inline-block');
			$("#fUploadFile").val("");
			}
		  
		});
		
		
		
   	//firstFile


   //=====================================================================================================================================================================================


	//secondFile
//	if($("#fUploadResult ul").html()==""){console.log("noooooooooo")}
//	
//	   $("button[type='submit']").on("click",function(e){
//	
//	      e.preventDefault();
//	      
//	      var str="";
//	      
//	      
//	      formObj.append(str);
//	   })
	   
	   $("#sUploadFile").change(function(e) {
		  var formData = new FormData();
	      
		  var inputFile = $("#sUploadFile");
	
	      var files = inputFile[0].files;
	
	      console.log(files);
	
	      for (var i = 0; i < files.length; i++) {
	         if (!checkExtension(files[i].name, files[i].size)) {
				$("#sUploadFile").val("");
	            return false;
	         }
	         formData.append("uploadFile", files[i]);
	      }
	
	      $(this).css('display','none');
	      $.ajax({
	         url : '/fileUploadAjaxAction',
	         processData : false,
	         contentType : false,
			 beforeSend: function(xhr){
			            xhr.setRequestHeader(header, token)
			        },
	         data : formData,
	         type : 'POST',
	         dataType : 'json',
	         success : function(result) {
	      
	            console.log(result);
	            
	            sShowUploadResult(result); 
	      
	         }
	      });       
	   });
	   function sShowUploadResult(uploadResultArr){
	         if(!uploadResultArr || uploadResultArr.length==0){
	            return; 
	         }
	         
	         var str = "";
	         
	         $(uploadResultArr).each(function(i, obj){
	           console.log(obj);
	           
	           if(obj.image){  
	               var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
	               str += "<li style='margin-left: 8px;' data-path='"+obj.uploadPath+"'";
	               str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
	               str +" ><div>";
	               str += "<span> "+ obj.fileName+"</span>";
	               str += "<button type='button' data-file=\'"+fileCallPath+"\' "
				   str += "data-type='image' style='margin-left:8px;' class='btn'>X</button><br>";
	               str += "</div>";
	               str +"</li>";
	            }else{  
	               var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);               
	                  
	               str += "<li style='margin-left: 8px;'"
	               str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
	               str += "<span> "+ obj.fileName+"</span>";
	               str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
	               str += "class='btn' style='margin-left:8px'>X</button><br>";
	               str += "</div>";
	               str +"</li>";
	            }
	           
	         });
	         
	         $(".sUploadResult ul").append(str);
	       }
	   $(".sUploadResult").on("click","button", function(e){
		  
			  var targetFile = $(this).data("file");
			  var type = $(this).data("type");
			  
			  var targetLi=(this).closest("li");

			  if (confirm("삭제 하시겠습니까?")){
			  $.ajax({
			    url: '/fileDeleteFile',
			    data: {fileName: targetFile, type:type},
			    dataType:'text',
				beforeSend: function(xhr){
		            xhr.setRequestHeader(header, token)
		        },
			    type: 'POST',
			      success: function(result){
//			         alert(result);
			         targetLi.remove();
			       }
			  });
	
				 $("#sUploadFile").css('display','inline-block');
				 $("#sUploadFile").val("");
			}
			  
			});

})