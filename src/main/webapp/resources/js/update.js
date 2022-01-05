 /**
 * 
 */
$(document).ready(function(){
		
		
		(function(){
				var bno=$("#bno").val();
		$.getJSON("fileGetAttachList",{bno:bno},function(arr){
		if(arr.length==0){console.log("aaa");$(".fUploadDiv").find("input").css('display','inline-block');}
		var str="";
		$(arr[0]).each(function(i,attach){
			if(attach.filetype=="true"){
			 	var fileCallPath =  encodeURIComponent( attach.uploadpath+ "/"+attach.uuid+"_"+attach.filename);
				str +="<li id='fName' style='margin-left: 8px;' data-path='"+attach.uploadpath+"'";
				str +=" data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'>"
				str +="<div>";
				str += "<span> "+attach.filename+"</span>";
                str += "<button type='button' data-file=\'"+fileCallPath+"\' ";
                str += "data-type='image' style='margin-left:8px;' class='btn'>X</button>";
				str +="</div>";  
				str +="</li>";  
				}
			else{  
               var fileCallPath =  encodeURIComponent( attach.uploadpath+"/"+ attach.uuid +"_"+attach.filename);               
                  
               str += "<li id='fName' style='margin-left: 8px;'"
               str += "data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"' ><div>";
               str += "<span> "+ attach.filename+"</span>";
               str += "<button type='button' style='margin-left:8px;' data-file=\'"+fileCallPath+"\' data-type='file' " 
               str += "class='btn'>X</button>";
               str += "</div>";
               str +"</li>";
            }
			})
			$(".fUploadResult ul").html(str);
		}) 
		
		
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
			    type: 'POST',
			      success: function(result){
			         targetLi.remove();
			       }
			  });
			
			$("#fUploadFile").css('display','inline-block');
			$("#fUploadFile").val("");
			}
		});
	})(); 
	
	 var regex = new RegExp("(.*?)\.(exe|js|sh|alz)$");
	 var maxSize = 10485760; 
	

   function checkExtension(filename, fileSize) {

      if (fileSize >= maxSize) {
         alert("파일 사이즈 초과");
		$("input[type='file']").val(null);
         return false;
      }
      if (regex.test(filename)==true) {
         alert("해당 종류의 파일은 업로드할 수 없습니다.");
		$("input[type='file']").val(null);
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
			$("input[type='file']").val(null);
            return false;
         }
     
         formData.append("uploadFile", files[i]);
      }
	  $(this).css('display','none');

      $.ajax({
         url : '/fileUploadAjaxAction',
         processData : false,
         contentType : false,
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
         
         var str = "";
         
         $(uploadResultArr).each(function(i, obj){
           console.log(obj);
           
           if(obj.image){
               var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/_"+obj.uuid +"_"+obj.fileName);
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
                var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
                  
               str += "<li id='fName' style='margin-left: 8px;'"
               str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
               str += "<span> "+ obj.fileName+"</span>";
               str += "<button type='button' style='margin-left:8px;' data-file=\'"+fileLink+"\' data-type='file' " 
               str += "class='btn'>X</button>";
               str += "</a>";
               str += "</div>";
               str +"</li>";
            }
           
         });
         
          $(".fUploadResult ul").append(str);
       }



   var formObj=$("form[role='form']");

   $("button[type='submit']").on("click",function(e){

      e.preventDefault();
	  
      var havF = $(".fUploadResult ul").html();
      var havS = $(".sUploadResult ul").html();
      var fileYN = $("input[name='file']");

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
 
    	  });
      	formObj.append(str).submit();
   }) 

})

//================================================================================================================================

$(document).ready(function(){
	(function(){
			var bno=$("#bno").val();
			$.getJSON("fileGetAttachList",{bno:bno},function(arr){
				console.log("arr.length : "+arr.length)
			if(arr.length!=2){console.log("aaa");$(".sUploadDiv").find("input").css('display','inline-block');}
			var str="";
			$(arr[1]).each(function(i,attach){
				if(attach.filetype=="true"){
				 	var fileCallPath =  encodeURIComponent( attach.uploadpath+ "/"+attach.uuid+"_"+attach.filename);
					str +="<li style='margin-left: 8px;' data-path='"+attach.uploadpath+"'";
					str +=" data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'>"
					str +="<div>";
					str += "<span> "+attach.filename+"</span>";
	                str += "<button type='button' data-file=\'"+fileCallPath+"\' ";
	                str += "data-type='image' style='margin-left:8px;' class='btn'>X</button>";
					str +="</div>";  
					str +="</li>";  
					}
				else{  
	               var fileCallPath =  encodeURIComponent( attach.uploadpath+"/"+ attach.uuid +"_"+attach.fileName);               
	                  
	               str += "<li style='margin-left: 8px;'"
	               str += "data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.image+"' ><div>";
	               str += "<span> "+ attach.filename+"</span>";
	               str += "<button type='button' style='margin-left:8px;' data-file=\'"+fileCallPath+"\' data-type='file' " 
	               str += "class='btn'>X</button>";
	               str += "</a>";
	               str += "</div>";
	               str +"</li>";
	            }
				})
				$(".sUploadResult ul").html(str);
			}) 
			 $(".sUploadResult").on("click","button", function(e){
		   	
			  var targetFile = $(this).data("file");
			  var type = $(this).data("type");
			  
			  var targetLi=(this).closest("li");
			  console.log(targetFile);
			  
			  if (confirm("삭제 하시겠습니까?")){
				  $.ajax({
				    url: '/fileDeleteFile',
				    data: {fileName: targetFile, type:type},
				    dataType:'text',
				    type: 'POST',
				      success: function(result){
				         targetLi.remove();
				       }
				  });
				
				$("#sUploadFile").css('display','inline-block');
				$("#sUploadFile").val("");
				}
			});
		})(); 
		
		var regex = new RegExp("(.*?)\.(exe|js|sh|alz)$");
	 	var maxSize = 10485760; 
	
		function checkExtension(filename, fileSize) {

	      if (fileSize >= maxSize) {
	         alert("파일 사이즈 초과");
			$("input[type='file']").val(null);
	         return false;
	      }
	      if (regex.test(filename)==true) {
	         alert("해당 종류의 파일은 업로드할 수 없습니다.");
			$("input[type='file']").val(null);
	         return false;
	      }
	      return true;
	   } 

	   $("#sUploadFile").change(function(e) {
		

	      var formData = new FormData();
	
	      var inputFile = $("#sUploadFile");
	
	      var files = inputFile[0].files;
	
	      console.log(files);
	
	      for (var i = 0; i < files.length; i++) {
	
	         if (!checkExtension(files[i].name, files[i].size)) {
				$("input[type='file']").val(null);
	            return false;
	         }
	     
	         formData.append("uploadFile", files[i]);
	      }
	
		  $(this).css('display','none');
	      $.ajax({
	         url : '/fileUploadAjaxAction',
	         processData : false,
	         contentType : false,
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
	               str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.filetype+"'"
	               str +" ><div>";
	               str += "<span> "+ obj.fileName+"</span>";
	               str += "<button type='button' data-file=\'"+fileCallPath+"\' "
	               str += "data-type='image' style='margin-left:8px;' class='btn'>X</button>";
	               str += "</div>";
	               str +"</li>";
	            }else{ 
	               var fileCallPath =  encodeURIComponent( obj.uploadpath+"/"+ obj.uuid +"_"+obj.fileName);               
	                var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
	                  
	               str += "<li style='margin-left: 8px;'"
	               str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
	               str += "<span> "+ obj.fileName+"</span>";
	               str += "<button type='button' style='margin-left:8px;' data-file=\'"+fileCallPath+"\' data-type='file' " 
	               str += "class='btn'>X</button>";
	               str += "</div>";
	               str +"</li>";
	            }
	           
	         });
	         
	          $(".sUploadResult ul").append(str);
	       }
	
	 var formObj=$("form[role='form']");
	
	   $("button[type='submit']").on("click",function(e){
	
	      e.preventDefault();
	
			var str="";
			 $(".sUploadResult ul li").each(function(i,obj){
	    	  var jobj=$(obj);

	    	  if($("#fName").length){ 
				  console.log("aaa");
				  str+="<input type='hidden' name='attachList["+i+1+"].filename' value='"+jobj.data("filename")+"'>"
		    	  str+="<input type='hidden' name='attachList["+i+1+"].uuid' value='"+jobj.data("uuid")+"'>"
		    	  str+="<input type='hidden' name='attachList["+i+1+"].uploadpath' value='"+jobj.data("path")+"'>"
		    	  str+="<input type='hidden' name='attachList["+i+1+"].filetype' value='"+jobj.data("type")+"'>"
				}
			
			  else{ 
				  console.log("bbb");
		    	  str+="<input type='hidden' name='attachList["+i+"].filename' value='"+jobj.data("filename")+"'>"
		    	  str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>"
		    	  str+="<input type='hidden' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>"
		    	  str+="<input type='hidden' name='attachList["+i+"].filetype' value='"+jobj.data("type")+"'>"
				}
	    	  });

	      	formObj.append(str).submit();
	   }) 




	
})