define(["jquery"],function($){

    return function($compile,$scope){
        require(["PDUtilDir/util",
                 "PDUtilDir/tool",
                 "PDUtilDir/grid","jquery", "Date","DateCN", "css!DateCss"],function(Util,Tool,Grid){
    		// 对Date的扩展，将 Date 转化为指定格式的String   
    		// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
    		// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
    		// 例子：   
    		// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
    		// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   	    		
        	Date.prototype.Format = function(fmt) {
        		var o = {
        				"M+" : this.getMonth() + 1, // 月份
        				"d+" : this.getDate(), // 日
        				"h+" : this.getHours(), // 小时
        				"m+" : this.getMinutes(), // 分
        				"s+" : this.getSeconds(), // 秒
        				"q+" : Math.floor((this.getMonth() + 3) / 3), // 季度
        				"S" : this.getMilliseconds()// 毫秒		
        		};
								
        		if (/(y+)/.test(fmt))
        			fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        		for ( var k in o)
        			if (new RegExp("(" + k + ")").test(fmt))
        				fmt = fmt.replace(RegExp.$1,(RegExp.$1.length == 1) ? (o[k]): (("00" + o[k]).substr(("" + o[k]).length)));			
        		return fmt;
							
        	}  
        	
        	
        	//*******************************************************************日志查询标签页初始化以及事件绑定************************************************************************
        	//初始化查询开始时间日期组件
        	$("#searchStartTime").datetimepicker({
                language : "cn",
                //输出格式化
                format : 'yyyy-mm-dd hh:ii:ss',
                todayBtn : true,
                //设置最精确的时间选择视图
                minView : 'hour',
                todayHighlight : true,
                //显示“上午”“下午”
                showMeridian : true,
                autoclose : true
            });
        	//初始化查询结束时间日期组件
        	$("#searchEndTime").datetimepicker({
                language : "cn",
                //输出格式化
                format : 'yyyy-mm-dd hh:ii:ss',
                todayBtn : true,
                //设置最精确的时间选择视图
                minView : 'hour',
                todayHighlight : true,
                //显示“上午”“下午”
                showMeridian : true,
                autoclose : true
            });
        	
        	//将查询时间单选框与查询日期组件绑定
       	 $("input[name=recentTime]").click(function(){
       		 var hours=$("input[name=recentTime]:checked").val();
       		 var now=new Date();
       		 var endTimeStr=now.Format("yyyy-MM-dd hh:mm:ss"); 
       		 now.setTime(now.getTime()-hours*3600*1000);
       		 var startTimeStr=now.Format("yyyy-MM-dd hh:mm:ss"); 
       		 $("#searchStartTime").val(startTimeStr)
       		 $("#searchEndTime").val(endTimeStr)
       		  
       	 });
      // 日志查询等待窗口
    	 	var loadingAlarmLogSearchDiaalarmLog = Util.loading({
	 			id : "pdMonitorAlarmLogSearchPanel",
				text : "正在加载"
	 		});
        	 //根据查询条件显示Grid
        	 var fillGridWithQuery = function(query){
        		 var config = {           
           				 id: "AlarmLogList",
            		     realSort:true,
            		     placeAt:"alarmLogShowListContent",        //存放Grid的容器ID
            		     pageSize:50,                          //一页多少条数据
            		     layout:[
            		             {name:"时间",field:"time",sort:true},
            		             {name:"应用服务器",field:"server"},
            		             {name:"目标服务器",field:"targetServer"},
            		             {name:"消息",field:"msg",width:"50%"}
            		             ]
            		 };
    				$.ajax({
    					url : getServer() + "/sword/monitor/alarmLogMonitor/searchAlarmLog",
    					dataType:"json",
    					data :query,
    					success : function(data) {
    						Grid.init($.extend(config, {
    							data : data
    						}));
    						loadingAlarmLogSearchDiaalarmLog.close();
    					}
    				});
        	 }
        	 


        	 
        	 //日志查询按钮绑定单击事件
        	 $("#btnAlarmLogSearch").click(function(){
        		 loadingAlarmLogSearchDiaalarmLog.show();
        		 var alarmLogQuery = Tool.serialize("pdMonitorSearchInfoEditor");
        		 fillGridWithQuery(alarmLogQuery);
        	 });
        	 //初始化查询时间
        	 $("input[name=recentTime]:checked").click();
        	//*******************************************************************日志下载标签页初始化以及事件绑定************************************************************************
        	 
        	//初始化下载开始时间日期组件
         	$("#downloadStartDate").datetimepicker({
                 language : "cn",
                 //输出格式化
                 format : 'yyyy-mm-dd hh:ii:ss',
                 todayBtn : true,
                 //设置最精确的时间选择视图
                 minView : 'hour',
                 todayHighlight : true,
                 //显示“上午”“下午”
                 showMeridian : true,
                 autoclose : true
             });
         	//初始化下载结束时间日期组件
         	$("#downloadEndDate").datetimepicker({
                 language : "cn",
                 //输出格式化
                 format : 'yyyy-mm-dd hh:ii:ss',
                 todayBtn : true,
                 //设置最精确的时间选择视图
                 minView : 'hour',
                 todayHighlight : true,
                 //显示“上午”“下午”
                 showMeridian : true,
                 autoclose : true
             });




        });
    };
});