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
<%-- theme --%>
<c:choose>
   	<c:when test="${pageInfo.theme != null && pageInfo.theme != '' }">  
		<c:set var="theme" value="${pageInfo.theme }" />
	</c:when>
	<c:otherwise> 
     	<c:set var="theme" value="blue" />
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
    <link rel="stylesheet" href="${ctx }/static/modules/ace_bak/css/ace-fonts.css" />
    <link rel="stylesheet" href="${ctx }/static/modules/ace_bak/css/ace.css" />
    <!-- ace兼容 -->
    <!--[if lte IE 9]>
    <link rel="stylesheet" href="${ctx }/static/modules/ace_bak/css/ace-part2.min.css"/>
    <link rel="stylesheet" href="${ctx }/static/modules/ace_bak/css/ace-ie.css"/>
    <![endif]-->
    <!-- home theme -->
    <link rel="stylesheet" href="${ctx }/static/core/page/home_bak/theme/default.css" />
    <link rel="stylesheet" data-theme href="${ctx }/static/core/page/home_bak/theme/${theme }/style.css" />
    <%--
    <link rel="stylesheet" data-theme href="${ctx }/static/core/page/home/theme/${theme }/style.css" />
     --%>
    <!-- common -->
    <link rel="stylesheet" href="${ctx }/static/core/page/home_bak/theme/common.css" />
    <link rel="stylesheet" href="${ctx }/static/app/app.css"/>
    
    <!-- IE8响应式布局 兼容性js文件 -->
    <!--[if lte IE 8]>
    <script src="${ctx }/static/modules/ace_bak/js/html5shiv.js"></script>
    <script src="${ctx }/static/modules/ace_ace/js/respond.min.js"></script>
    <![endif]-->
</head>

<body ng-controller="BodyCtrl">
	<div class="body-wrap">
		<!-- header -->
		<div class="header">
			<div class="logo">
				<!-- 
				<img src="${ctx }/static/core/page/home/image/logo.png" />
				 -->
				<span>${title }</span>
			</div>
			<div class="shop">
				<!-- 
				<a href="javascript:;" class="icon icon-task"><span>5</span></a>
		        <a href="javascript:;" class="icon icon-message"></a>
		        <a href="javascript:;" class="icon icon-mail"></a>
		         -->
		        <a href="javascript:;" id="pd_web_loginout_menuitem" title="退出" class="icon icon-logout"></a>
			</div>
			<div class="user">
				<div class="user-select">
					<span class="user-select-name" id="pd_web_username_home">欢迎您……</span>
					<!-- 
					<span class="user-select-trigger icon-dropdown"></span>
					 -->
				</div>
				<!-- 
				<ul class="user-list">
					<li><span></span></li>
				</ul>
				 -->
			</div>
		</div>
		<!-- end header -->
		<!-- sidebar -->
		<div id="sidebar" class="sidebar no-skin responsive sidebar-fixed">
			<!-- 
			<div class="sidebar-wrap">
			 -->
				<!-- main menu -->
				<ul sidebar-menu class="nav nav-list"></ul>
			    <!-- main menu toggle -->
			    <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
			        <i class="ace-icon ace-icon-arrow fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
			    </div>
			    <!-- end menu toggle -->
			<!--     
			</div>
			 -->
		</div>
		<!-- end sidebar -->
		<!-- main -->
		<div class="main">
			<div class="cs-layout-status breadcrumbs">
				<ul class="breadcrumb">
					<li>
						<i class="ace-icon fa fa-home home-icon"></i>
						<a href="javascript:;">首页</a>
					</li>
				</ul>
			</div>
			<div class="cs-layout-page">
				<div ng-view></div>
			</div>
		</div>
		<div class="cs-bt-tbar">
			<div data-type="shortcut" class="cs-bt-tbar-tab">
				<span class="fa fa-link"></span>
				<div class="cs-bt-tbar-sub shortcut">
				</div>
			</div>				
		</div>
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
            require(["PDHomeDir/js/homeApp", "PDLoginDir/js/loginout"], function(HomeApp, Loginout){
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
