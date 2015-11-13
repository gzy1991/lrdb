<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>gzy_1</title>

    <script type="text/javascript">
    function loadXMLDoc()
    {
      var xmlhttp;
      if (window.XMLHttpRequest)
         {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
        }
      else
         {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      xmlhttp.onreadystatechange=function()
      {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
      {
      document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
      }
      }
      xmlhttp.open("GET","http://localhost:8080/sword-web-core/sword/gzy/getGzyPage?pageNumber=1&pageSize=10",true);
      xmlhttp.send();
}
</script>
</head>

<body>

<div id="myDiv"><h2>Let AJAX change this text</h2></div>
<button type="button" onclick="loadXMLDoc()">通过 AJAX 改变内容</button>

</body>
</html>