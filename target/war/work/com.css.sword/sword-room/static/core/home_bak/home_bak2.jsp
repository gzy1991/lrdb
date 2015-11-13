<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!-- PageInfoBean -->
<jsp:useBean id="pageInfo" class="com.css.sword.common.pageInfo.bean.PageInfoBean"></jsp:useBean>

<!DOCTYPE html>
<html lang="en">
<head>
 	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta charset="utf-8" />
    <link rel="shortcut icon" href="${ctx }/favicon.ico">

	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <title>
    	<c:choose>
        	<c:when test="${pageInfo.systemName != null && pageInfo.systemName != '' }">  
				${pageInfo.systemName }
			</c:when>
			<c:otherwise> 
			     sword
			</c:otherwise>
		</c:choose> 
    </title>

    <link rel="stylesheet" href="${ctx }/static/modules/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx }/static/modules/Font-Awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="${ctx }/static/modules/ace/css/ace-fonts.css" />
    <link rel="stylesheet" href="${ctx }/static/modules/ace/css/ace.css" />
    <link rel="stylesheet" href="${ctx }/static/core/home/style/home.css" />
    <!-- ace兼容 -->
    <!--[if lte IE 9]>
    <link rel="stylesheet" href="${ctx }/static/modules/ace/css/ace-part2.min.css"/>
    <link rel="stylesheet" href="${ctx }/static/modules/ace/css/ace-ie.min.css"/>
    <![endif]-->
    <!-- home css -->
    <link rel="stylesheet" href="${ctx }/static/core/home/home.css" />
    <link rel="stylesheet" href="${ctx }/static/app/app.css"/>
    
    <!-- IE8响应式布局 兼容性js文件 -->
    <!--[if lte IE 8]>
    <script src="${ctx }/static/modules/ace/js/html5shiv.js"></script>
    <script src="${ctx }/static/modules/ace/js/respond.min.js"></script>
    <![endif]-->
</head>

<body ng-controller="BodyCtrl">
<!-- header -->
<div class="header">
	<div class="logo"></div>
	<div class="shop">
		<a href="#" class="icon icon-task"><span>17</span></a>
        <a href="#" class="icon icon-message"><span>5</span></a>
        <a href="#" class="icon icon-mail"><span>1</span></a>
	</div>
	<div class="user">
		<div class="user-select">
			<span class="user-select-name">Sherry</span>
			<span class="user-select-trigger icon-dropdown">^</span>
		</div>
		<ul class="user-list">
			<li><span></span></li>
		</ul>
	</div>
</div>
<!-- end header -->
<!-- main -->
<div class="main main-container" id="main-container">
	<!-- main sidebar -->
	<div id="sidebar" class="sidebar no-skin responsive sidebar-fixed">
		<!-- main menu -->
		<ul sidebar-menu class="nav nav-list"></ul>
	    <!-- main menu toggle -->
	    <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
	        <i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
	    </div>
	    <!-- end menu toggle -->
	</div>
	<!-- end main sidebar -->
	<!-- main content -->
	<div class="main-content">
		<div class="status breadcrumbs">
			<ul class="breadcrumb">
				<li>
					<i class="ace-icon fa fa-home home-icon"></i>
					<a href="../../index.html">首页</a>
				</li>
			</ul>
		</div>
		<div class="page-content">
			<div ng-view></div>
		</div>
	</div>
	<!-- end main content -->
	<!-- main tools -->
	<div class="tools">
		<a href="#" class="tool">
			<span class="ico_tools" title="导出Excel"></span>
		</a>
	</div>
	<!-- end main tools -->
</div>
<!-- end main -->
    <!-- requireJS load & config -->
	<script src="${ctx }/static/modules/requirejs/require.js" type="text/javascript"></script>

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

    <script src="${ctx }/static/global/config.js"></script>

    <!-- jQuery version control -->
	<!--[if IE]>
	<script type="text/javascript">
	    require.config({
	    	paths:{
	    		"jquery":"static/modules/jquery/jquery1x.min"
	   		}
		});
	</script>
	<![endif]-->
	
	<!-- 程序入口 -->
	<script>
        require(["Ace", "PDAppDir/appPath", "PDCoreDir/corePath", "PDGlobalDir/base"], function (Ace) {
            require(["PDCoreDir/home/homeApp", "PDLoginDir/js/loginout"], function(HomeApp, Loginout){
	        	angular.element(document).ready(function () {
	                angular.bootstrap(document, ['HomeApp']);
	                Ace.init();
	                $("#pd_web_loginout_menuitem").click(function () { Loginout.Logout(); });
	                Loginout.init();
	            });
            })
        });
	</script>
</body>
</html>
