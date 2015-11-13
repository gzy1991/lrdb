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
    <link rel="stylesheet" href="${ctx }/static/modules/ace/dist/css/ace-fonts.min.css" />
    <!-- 
    <link rel="stylesheet" href="${ctx }/static/modules/ace/dist/css/ace.min.css" />
     -->
    <link rel="stylesheet" href="${ctx }/static/modules/ace/assets/css/ace.css" />
    <!-- ace兼容 -->
    <!--[if lte IE 9]>
    <link rel="stylesheet" href="${ctx }/static/modules/ace/dist/css/ace-part2.min.css"/>
    <link rel="stylesheet" href="${ctx }/static/modules/ace/dist/css/ace-ie.min.css"/>
    <![endif]-->
    <!-- home theme -->
    <link rel="stylesheet" href="${ctx }/static/core/page/home/theme/default.css" />
    <link rel="stylesheet" data-theme href="${ctx }/static/core/page/home/theme/${theme }/style.css" />
    <!-- 
     -->
    <!-- common -->
    <link rel="stylesheet" href="${ctx }/static/core/page/home/css/common.css" />
    <link rel="stylesheet" href="${ctx }/static/app/app.css"/>
    <!-- 
     -->
     
    <!-- IE8响应式布局 兼容性js文件 -->
    <!--[if lte IE 8]>
    <script src="${ctx }/static/modules/ace/dist/js/html5shiv.min.js"></script>
    <script src="${ctx }/static/modules/ace/dist/js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="no-skin" ng-controller="BodyCtrl">
	<!-- body-wrap -->
	<div class="body-wrap">
		<div id="navbar" class="navbar navbar-default navbar-fixed-top">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<!-- #section:basics/sidebar.mobile.toggle -->
				<button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
					<span class="sr-only">Toggle sidebar</span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>
				</button>

				<!-- /section:basics/sidebar.mobile.toggle -->
				<div class="navbar-header pull-left">
					<!-- #section:basics/navbar.layout.brand -->
					<div class="logo">
						<!-- 
						<img src="${ctx }/static/core/page/home/image/logo.png" />
						 -->
						<span>${title }</span>
					</div>
				</div>
				
				<div class="navbar-header-toolbar pull-right">
					<span id="pd_web_username_home" class="user-name" >欢迎您……</span>
					<span id="pd_web_loginout_menuitem" class="power-off" title="退出登录"><i class="fa fa-power-off"></i></span>
				</div>

				<!-- #section:basics/navbar.dropdown -->
				<div class="navbar-buttons navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">

						<!-- /section:basics/navbar.user_menu -->
					</ul>
				</div>

				<!-- /section:basics/navbar.dropdown -->
			</div><!-- /.navbar-container -->
		</div>

		<!-- /section:basics/navbar.layout -->
		<div id="main-container" class="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<!-- #section:basics/sidebar -->
			<div id="sidebar" class="sidebar responsive sidebar-fixed">
				<script type="text/javascript">
					try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
				</script>

				<ul id="sidebar-menu" class="nav nav-list"></ul><!-- /.nav-list -->

				<!-- #section:basics/sidebar.layout.minimize -->
				<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
					<i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
				</div>

				<!-- /section:basics/sidebar.layout.minimize -->
				<script type="text/javascript">
					try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
				</script>
			</div>

			<!-- /section:basics/sidebar -->
			<div class="main-content">
				<div class="main-content-inner">
					<!-- #section:basics/content.breadcrumbs -->
					<div class="breadcrumbs breadcrumbs-fixed" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>

						<ul class="breadcrumb">
							<li>
								<i class="ace-icon fa fa-home home-icon"></i>
								<a href="javascript:;">首页</a>
							</li>
						</ul><!-- /.breadcrumb -->

						<!-- /section:basics/content.searchbox -->
					</div>

					<!-- /section:basics/content.breadcrumbs -->
					<div class="page-content">
						<div ui-view></div>
					</div><!-- /.page-content -->
				</div>
			</div><!-- /.main-content -->
			
			<!-- footer -->
			<div class="footer">
			  <div class="footer-inner">
			    <div class="footer-content">
			       @Copyright中国软件与技术服务股份有限公司
			    </div>
			  </div>
			</div><!-- /.footer -->
		</div><!-- /.main-container -->
		<div class="cs-bt-tbar">
			<div data-type="shortcut" class="cs-bt-tbar-tab">
				<span class="fa fa-link"></span>
				<div class="cs-bt-tbar-sub shortcut">
				</div>
			</div>				
		</div>
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
	<script src="${ctx }/static/modules/ace/dist/js/ace.min.js"></script>
	<script src="${ctx }/static/modules/ace/dist/js/ace-elements.min.js"></script>
	<script src="${ctx }/static/modules/ace/dist/js/ace-extra.min.js"></script>
	<!-- 程序入口 -->
	<script>
        require(["PDAppDir/appPath", "PDCoreDir/corePath", "PDGlobalDir/base"], function () {
            require(["PDHomeDir/js/homeApp", "PDLoginDir/js/loginout"], function(HomeApp, Loginout){
            	angular.element(document).ready(function () {
	                angular.bootstrap(document, ['HomeApp']);
	                $("#pd_web_loginout_menuitem").click(function () { Loginout.Logout(); });
	                Loginout.init();
	            });
            })
        });
	</script>
</body>
</html>
