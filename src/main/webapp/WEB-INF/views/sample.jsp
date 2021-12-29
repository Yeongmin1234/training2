<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<title>Page Title</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script src="/resources/js/jquery-1.12.4.min.js"></script>

<style>
h1 {text-align: center;}
button{text-align: center;}
#editor{margin-bottom : 20px}
</style>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
</head>
<body>
<!-- TOAST UI Editor가 들어갈 div태그 -->
<form role="form">
	<div id="editor"></div>
	<button id="btn">버튼</button>
	<div class="uploadResultArr"><ul></ul></div>
</form>

<script src="/resources/js/toastui-editor-all2.js"></script>
<script>
const editor = new toastui.Editor({
el: document.querySelector('#editor'),
previewStyle: 'vertical',
height: '700px',
initialEditType: 'wysiwyg',
});
$("#btn").click(function(){
	alert(editor.getHTML());
})

editor.addHook('addImageBlobHook', (a, callback) => {callback(a.name)});
</script>
</body>
</html>
