define(["PDUtilDir/grid",
        "PDUtilDir/util"], function(Grid, Util){
	
	//初始化方法
	function init() {
		initGridLoginLog();
	}
	
	/** 变量 */
	var grid_loginlog_id = "grid-loginlog-cuser";

	function initGridLoginLog() {
		Grid({
            id: "gridLoginLog",
            placeAt:grid_loginlog_id,
            toolbar:[
                {name:"刷新",icon:"fa fa-refresh",callback:initGridLoginLog},
                {name:"清空",icon:"fa fa-trash-o",callback:delLoginLog}
            ],
            layout:[
                {name:"登录时间",field:"loginTime"},
                {name:"退出时间",field:"logoutTime"},
                {name:"访问IP",field:"clientIp"}
            ],
            data:{
                "type":"URL",
                "value": getServer() + "/sword/login/log/getByCurrentUser"
            }
		})
	}
	
	function delLoginLog() {
		Util.confirm("确定要清空登录信息吗？", function() {
			$.ajax({
				url : getServer() + "/sword/login/log/deleteByCurrentUser",
				success : function(data) {
					Util.alert(data.message);
					if (data.success) {
						initGridLoginLog();
					}
				}
			})
		});
	}
	
	return {
		init : init
	}
})