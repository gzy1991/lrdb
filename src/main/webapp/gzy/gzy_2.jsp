<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>gzy_2</title>

    <script src="jquery-2.1.4.min.js">
    </script>
    <script>
   $(document).ready(function(){
       $("#btn1").click(function(){
           $('#test').load('http://localhost:8080/sword-web-core/sword/gzy/getGzyPage?pageNumber=1&pageSize=10');
  })
})
</script>
</head>
<body>

<h3 id="test">请点击下面的按钮，通过 jQuery AJAX 改变这段文本。</h3>
<button id="btn1" type="button">获得外部的内容</button>

</body>
</html>