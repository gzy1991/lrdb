<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!-- LoginBean -->
<jsp:useBean id="rsa" class="com.css.sword.common.login.security.loginBean" ></jsp:useBean>
<jsp:setProperty property="pageContext" name="rsa" value="<%=pageContext %>"/>
<!-- PageInfoBean -->
<jsp:useBean id="pageInfo" class="com.css.sword.common.pageInfo.bean.PageInfoBean"></jsp:useBean>
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
    <!-- login css -->
    <link rel="stylesheet" href="${ctx }/static/core/page/login/theme/default.css">
    <link rel="stylesheet" href="${ctx }/static/core/page/login/theme/${theme }/style.css">
    
    <!-- IE8响应式布局 兼容性js文件 -->
    <!--[if lte IE 8]>
    <script src="${ctx }/static/modules/ace/js/html5shiv.js"></script>
    <script src="${ctx }/static/modules/ace/js/respond.min.js"></script>
    <![endif]-->
</head>

<body>
	<div class="login_bg">
    </div>
    <div class="login_main">
        <div class="login_wrap">
            <div class="login_wrap_left">
                <div class="login_img">
                	<!-- 
                	<img src="${ctx }/static/core/page/login/image/blue_pic.png" />
                	 -->
                </div>
            </div>
            <div class="login_wrap_right">
            	<div class="login_wrap_right_bg"></div>
            	<div class="login_content">
                    <h1 class="logo mt95">SwordPlus中国软件</h1>
		            <h2 class="motto mt90">随需应变&nbsp;服务共融</h2>
		            <form id="pd_web_login_form">
		                <div class="login_item mt25">
		                    <div class="input_wrap">
		                        <label class="sr-only" for="pd_web_login_name">用户名</label>
	                            <input id="pd_web_login_name" name="pd_web_login_name" class="input" placeholder="用户名" type="text" value="${rsa.user}" >
		                        <b class="icon icon_user"></b>
		                        <div class="error">
		                        </div>
		                    </div>
		                </div>
		                <div class="login_item mt20">
		                    <div class="input_wrap">
		                        <label class="sr-only" for="pd_web_pwd">密码</label>
	                            <input id="pd_web_pwd" name="pd_web_pwd" class="input" placeholder="密码" type="password" value="${rsa.sPwd}">
		                        <b class="icon icon_lock"></b>
		                        <div class="error">
		                        </div>
		                    </div>
		                </div>
		                <div class="login_item mt20 clearFix">
		                    <img class="codeImg fl" src="${ctx }/sword/login/captcha?SwordControllerName=captcha" id="pd_web_captcha_img" />
		                    <div class="input_wrap fr">
		                        <label class="sr-only" for="pd_web_captcha">验证码</label>
	                            <input id="pd_web_captcha" name="pd_web_captcha" class="input code" placeholder="验证码" type="text" >
		                        <b class="icon icon_check"></b>
		                        <div class="error">
		                        </div>
		                    </div>
		                </div>
		                <div class="login_item mt20">
		                    <div class="input_wrap mt20 clearFix">
		                        <div class="remeber_wrap fl">
		                            <label>
	                                	<input id="pd_web_check_pwd" name="pd_web_check_pwd" class="remeber" ${rsa.checkPwd?"checked='checked'":""} type="checkbox" /> 记住我
	                                </label>
		                            <div class="remeber_tip">
		                                为了您的信息安全，请不要在网吧或公用电脑上使用此功能
		                            </div>
		                        </div>
		                        <a class="submit fr" href="javascript:;" id="pd_web_btn_submit">登&nbsp;录</a>
		                    </div>
		                </div>
		            </form>
                </div>
                <div class="login_bottom">
                	<span>@Copyright中国软件与技术服务股份有限公司</span>
                </div>
            </div>
        </div>
    </div>
	<!-- js -->
	<!-- requireJS -->
	<script src="${ctx }/static/modules/requirejs/require.js" type="text/javascript"></script>
    <!-- config.js -->
    <script type="text/javascript" src="${ctx }/static/global/config.js"></script>

	<!-- 全局js设置 -->
	<script type="text/javascript">
	var rsaKeyExponent="${rsa.publicKeyExponent}";
	var rsaKeyModulus="${rsa.publicKeyModulus}";  
	//function p(){document.getElementById("pwd").value = "${rsa.sPwd}";
	//	};
	//	p();
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
				"jquery":"static/modules/jquery/jquery.min"
			}
		})
	</script>
	
	<!-- jquery IE版本 -->
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
	
	<script  type="text/javascript" src="${ctx }/static/core/page/login/js/lgnPage.js">
	</script>
	
</body>
</html>
