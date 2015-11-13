define(["PDUtilDir/grid",
        "PDUtilDir/util"], function(Grid, Util) {
	
	//初始化方法
	function init() {
		initGridLoginLogSuccess();
		initGridLoginLogFail();
	}
	
	/** 变量 */
	var grid_loginlog_success_id = "grid-loginLog-success";
	var grid_loginlog_fail_id = "grid-loginLog-fail";
	
	function initGridLoginLogSuccess() {
		Grid({
            id: "gridLoginLogSuccess",
            placeAt:grid_loginlog_success_id,
            toolbar:[
                {name:"刷新",icon:"fa fa-refresh",callback:initGridLoginLogSuccess},
                {name:"清空",icon:"fa fa-trash-o",callback:delLoginLogSuccess}
            ],
            layout:[
                {name:"登录人编号",field:"userCode"},
                {name:"登录人名称",field:"userName"},
                {name:"登录时间",field:"loginTime"},
                {name:"退出时间",field:"logoutTime"},
                {name:"访问IP",field:"clientIp"}
            ],
            data:{
                "type":"URL",
                "value": getServer() + "/sword/login/log/getSuccess"
            }
		})
	}
	
	function initGridLoginLogFail() {
		Grid({
            id: "gridLoginLogFail",
            placeAt:grid_loginlog_fail_id,
            toolbar:[
                {name:"刷新",icon:"fa fa-refresh",callback:initGridLoginLogFail},
                {name:"清空",icon:"fa fa-trash-o",callback:delLoginLogFail}
            ],
            layout:[
                {name:"登录人编号",field:"userCode"},
                {name:"登录人名称",field:"userName"},
                {name:"登录失败时间",field:"errorDate"},
                {name:"访问IP",field:"ip"},
                {name:"失败原因",field:"errorCode",format:function(data){
            		var errorCode = data.row.errorCode;
            		if ("3" == errorCode) {
            			return "用户名错误";
            		} else if ("4" == errorCode) {
            			return "密码错误";
            		} else if ("5" == errorCode) {
            			return "登录失败次数过多";
            		} else if ("6" == errorCode) {
            			return "密码过期";
            		} else if ("7" == errorCode) {
            			return "验证码错误";
            		} else if ("8" == errorCode) {
            			return "密码被锁定";
            		}
            		return userType
            	}}
            ],
            data:{
                "type":"URL",
                "value": getServer() + "/sword/login/log/getFail"
            }
		})
	}
	
	function delLoginLogSuccess() {
		Util.confirm("确定要清空登录成功信息吗？", function() {
			$.ajax({
				url : getServer() + "/sword/login/log/deleteSuccess",
				success : function(data) {
					Util.alert(data.message);
					if (data.success) {
						initGridLoginLogSuccess();
					}
				}
			})
		});
	}
	
	function delLoginLogFail() {
		Util.confirm("确定要清空登录失败信息吗？", function() {
			$.ajax({
				url : getServer() + "/sword/login/log/deleteFail",
				success : function(data) {
					Util.alert(data.message);
					if (data.success) {
						initGridLoginLogFail();
					}
				}
			})
		});
	}
	
	return init;
})