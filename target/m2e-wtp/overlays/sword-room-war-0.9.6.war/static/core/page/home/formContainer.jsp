<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- context path --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%-- PageInfoBean --%>
<jsp:useBean id="pageInfo" class="com.css.sword.common.pageInfo.bean.PageInfoBean"></jsp:useBean>
<%-- title --%>
<c:choose>
   	<c:when test="${pageInfo.systemName != null && pageInfo.systemName != '' }">  
		<c:set var="title" value="${pageInfo.systemName }" />
	</c:when>
	<c:otherwise> 
     	<c:set var="title" value="sword" />
	</c:otherwise>
</c:choose>

<!DOCTYPE html>
<html lang="en">
<head>
 	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta charset="utf-8" />
    <link rel="shortcut icon" href="${ctx }/favicon.ico">

	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <title>
    	${title }
    </title>

    <link rel="stylesheet" href="${ctx }/static/modules/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx }/static/modules/Font-Awesome/css/font-awesome.min.css" />

    <![endif]-->
    <!-- home theme -->
    <link rel="stylesheet" href="${ctx }/static/core/page/home/theme/default.css" />
    <link rel="stylesheet" data-theme href="${ctx }/static/core/page/home/theme/${theme }/style.css" />
    <!-- 
     -->
    <!-- common -->
    <link rel="stylesheet" href="${ctx }/static/core/page/home/css/common.css" />
    <link rel="stylesheet" href="${ctx }/static/app/app.css"/>

    <!-- IE8响应式布局 兼容性js文件 -->
    <!--[if lte IE 8]>
    <script src="${ctx }/static/modules/ace/dist/js/html5shiv.min.js"></script>
    <script src="${ctx }/static/modules/ace/dist/js/respond.min.js"></script>
    <![endif]-->
</head>

<body ng-controller="BodyCtrl">
	<!-- body-wrap -->
	<div class="body-wrap">


	</div>
    <!-- requireJS -->
	<script src="${ctx }/static/modules/requirejs/require.js" type="text/javascript"></script>
	
	<!-- global -->
	<script type="text/javascript">
		var console = console || {log : function(){}};
		function getServer() {
			var contextPath = '${ctx }';
		    return contextPath;
		}
		function getStaticPath() {
			return getServer() + "/static";
		}
        function getCSRFToken() {
            var token = "${sessionScope.CSRFToken}";
            return token;
        }
		require.config({
			baseUrl : getServer()+"/",
			paths : {
				"jquery":"static/modules/jquery/jquery-2.1.3.min"
			}
		})
	</script>
	
	<!-- require.config.js -->
    <script src="${ctx }/static/global/config.js"></script>
    
    <!-- jQuery IE Version -->
	<!--[if IE]>
	<script type="text/javascript">
	    require.config({
	    	paths:{
	    		"jquery":"static/modules/jquery/jquery1x.min"
	   		}
		});
	</script>
	<![endif]-->
	
	<!-- ace -->
	<!--[if !IE]> -->
	<script src="${ctx }/static/modules/jquery/jquery-2.1.3.min.js"></script>
	<!-- <![endif]-->
	<!--[if IE]>
	<script src="${ctx }/static/modules/jquery/jquery1x.min.js"></script>
	<![endif]-->
	<script src="${ctx }/static/modules/bootstrap/js/bootstrap.min.js"></script>
	<!-- 程序入口 -->
	<script>
        require(["PDAppDir/appPath", "PDCoreDir/corePath", "PDGlobalDir/base"], function () {
            require(["PDHomeDir/js/homeApp"], function(HomeApp){
            	angular.element(document).ready(function () {
	                angular.bootstrap(document, ['HomeApp']);
	            });
            })
        });
	</script>
</body>
</html>
