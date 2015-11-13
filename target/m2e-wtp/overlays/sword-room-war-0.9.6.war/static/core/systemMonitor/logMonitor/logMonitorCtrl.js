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
    	 	var loadingLogSearchDialog = Util.loading({
	 			id : "pdMonitorLogSearchPanel",
				text : "正在加载"
	 		});
        	 //根据查询条件显示Grid
        	 var fillGridWithQuery = function(query){
        		 var config = {           
           				 id: "LogList",
            		     realSort:true,
            		     placeAt:"logShowListContent",        //存放Grid的容器ID
            		     pageSize:50,                          //一页多少条数据
            		     trEvent:[
            		              {
            		            	//单击行时，显示该行详细日志信息
            		            	  type:"click",callback:function(event){
            		            		  showLogDetailSidebar({
            		 		                    afterLoad:function(){
            		 		                    	$("#logDetailTitle").html("日志详细信息");
/*            		 		                    	Tool.deserialize("logDetailForm",event.data.row);*/
            		 		                    	$("#logDetailTime").html(event.data.row.time);
            		 		                    	$("#logDetailLevel").html(event.data.row.level);
            		 		                    	$("#logDetailModuleName").html(event.data.row.moduleName);
            		 		                    	$("#logDetailClassName").html(event.data.row.className);
            		 		                    	$("#logDetailSessionID").html(event.data.row.sessionID);
            		 		                    	$("#logDetailMsg").html(event.data.row.msg);
            		 		                    	$("#logDetailSwordExCode").html(event.data.row.swordExCode);
            		 		                    	$("#logDetailExClass").html(event.data.row.exClass);
            		 		                    	$("#logDetailExMsg").html(event.data.row.exMsg);
            		 		                    	$("#logDetailSwordStackTrace").html(event.data.row.swordStackTrace);
            		 		                    	$("#logDetailExStackTrace").html(event.data.row.exStackTrace);
            		 		                    }
            		 						});
            		            	  }
            		              }
            		          ],
            		     layout:[
            		             {name:"时间",field:"time",sort:true,width:"25%"},
            		             {name:"日志级别",field:"level",width:"10%"},
            		             {name:"SessionID",field:"sessionID",click:function(e){
            		            	 loadingLogSearchDialog.show();
            		            	 fillGridBySessionId({sessionID:e.data.row.sessionID});
            		             }},
            		             {name:"模块名",field:"moduleName",width:"20%"},
            		             {name:"消息",field:"msg",width:"40%"}
            		             ]
            		 };
    				$.ajax({
    					url : getServer() + "/sword/monitor/logMonitor/searchLog",
    					dataType:"json",
    					data :query,
    					success : function(data) {
    						Grid.init($.extend(config, {
    							data : data
    						}));
    						loadingLogSearchDialog.close();
    					}
    				});
        	 }
        	 
        	//查询具体SessionId的日志信息并显示在Grid
        	 var fillGridBySessionId = function(query){
        		 var config = {           
           				 id: "LogList",
            		     realSort:true,
            		     placeAt:"logShowListContent",        //存放Grid的容器ID
            		     pageSize:50,                          //一页多少条数据
            		     trEvent:[
            		              {
            		            	  //单击行时，显示该行详细日志信息
            		            	  type:"click",callback:function(event){
            		            		  showLogDetailSidebar({
            		 		                    afterLoad:function(){
            		 		                    	$("#logDetailTitle").html("日志详细信息");
/*            		 		                    	Tool.deserialize("logDetailForm",event.data.row);*/
            		 		                    	$("#logDetailTime").html(event.data.row.time);
            		 		                    	$("#logDetailLevel").html(event.data.row.level);
            		 		                    	$("#logDetailModuleName").html(event.data.row.moduleName);
            		 		                    	$("#logDetailClassName").html(event.data.row.className);
            		 		                    	$("#logDetailSessionID").html(event.data.row.sessionID);
            		 		                    	$("#logDetailMsg").html(event.data.row.msg);
            		 		                    	$("#logDetailSwordExCode").html(event.data.row.swordExCode);
            		 		                    	$("#logDetailExClass").html(event.data.row.exClass);
            		 		                    	$("#logDetailExMsg").html(event.data.row.exMsg);
            		 		                    	$("#logDetailSwordStackTrace").html(event.data.row.swordStackTrace);
            		 		                    	$("#logDetailExStackTrace").html(event.data.row.exStackTrace);
            		 		                    }
            		 						});
            		            	  }
            		              }
            		          ],
            		     layout:[
            		             {name:"时间",field:"time",sort:true,width:"25%"},
            		             {name:"日志级别",field:"level",width:"10%"},
            		             {name:"SessionID",field:"sessionID",click:function(e){
            		            	 loadingLogSearchDialog.show();
            		            	 fillGridBySessionId({sessionID:e.data.row.sessionID});
            		             }},
            		             {name:"模块名",field:"moduleName",width:"20%"},
            		             {name:"消息",field:"msg",width:"40%"}
            		             ]
            		 };
    				$.ajax({
    					url : getServer() + "/sword/monitor/logMonitor/searchLogBySessionId",
    					dataType:"json",
    					data :query,
    					success : function(data) {
    						Grid($.extend(config, {
    							data : data
    						}));
    						loadingLogSearchDialog.close();
    					}
    				});
        	 }
        	//弹出日志侧边栏
        	 var showLogDetailSidebar = function(param){
        		 Util.slidebar($.extend({
        			 url:getStaticPath()+"/core/systemMonitor/logMonitor/views/logDetail.html",
        			 cache:false,
        			 close:true,
        			 width:"800px"
        		 },param));
        	 };
        	 
        	 //日志查询按钮绑定单击事件
        	 $("#btnLogSearch").click(function(){
        		 loadingLogSearchDialog.show();
        		 var logQuery = Tool.serialize("pdMonitorSearchInfoEditor");
        		 fillGridWithQuery(logQuery);
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
         // 日志文件下载等待窗口
       	 	var loadingLogDownloadDialog = Util.Loading({
   	 			id : "pdMonitorLogDownloadPanel",
  				text : "正在加载"
   	 		});
        	//根据查询时间填充文件Grid
        	 var fillFileGridWithTime = function(query){
        		 var config = {           
           				 id: "LogList",
            		     realSort:true,
            		     placeAt:"logShowDownloadListContent",        //存放Grid的容器ID
            		     pageSize:10,                          //一页多少条数据
            		     layout:[
            		             {name:"修改时间",field:"lastModified",sort:true},
            		             {name:"文件名",field:"fileName",click:function(e){
            		            	 $("#downloadLogFileName").attr('value',e.data.row.fileName);
            		        		 $("#downloadLogFile").submit();
            		             }}
            		             ]
            		 };
    				$.ajax({
    					url : getServer() + "/sword/monitor/logMonitor/searchLogFile",
    					dataType:"json",
    					data :query,
    					success : function(data) {
    						Grid($.extend(config, {
    							data : data
    						}));
    						loadingLogDownloadDialog.close();
    					}
    				});
        	 }
        	 //日志下载的查询按钮绑定单击事件
        	 $("#btnLogDownloadSearch").click(function(){
        		 loadingLogDownloadDialog.show();
        		 var downloadLogTime = Tool.serialize("pdMonitorSearchFile");
        		 fillFileGridWithTime(downloadLogTime);
        		 
        	 });
        	 //日志下载日期初始化，默认为最近十天
        	 var initDownloadTime = function(){
        		 var now=new Date();
        		 var downloadEndDate=now.Format("yyyy-MM-dd hh:mm:ss"); 
        		 now.setTime(now.getTime()-10*24*3600*1000);
        		 var downloadStartDate=now.Format("yyyy-MM-dd hh:mm:ss"); 
        		 $("#downloadStartDate").val(downloadStartDate)
        		 $("#downloadEndDate").val(downloadEndDate)
        	 }
        	 initDownloadTime();
        });
    };
});