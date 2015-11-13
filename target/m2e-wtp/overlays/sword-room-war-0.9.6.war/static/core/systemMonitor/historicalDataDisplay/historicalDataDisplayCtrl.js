define([ "jquery" ], function($) {

	return function($compile, $scope) {
		require(["PDUtilDir/util",
		         "PDUtilDir/tool",
		         "PDUtilDir/grid","jquery", "Date","DateCN", "css!DateCss","Echarts"], function(Util,Tool,Grid,Echarts) {
			var historicalChart1=[];
			var historicalChart2=[];
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
        	var getMemoryData=function(memQuery){
        		var showUnit=$("input[name=showUnit]:checked").val();
    			var d = [];
    			$.ajax({
    				url : getServer() + "/sword/monitor/historicalDataDisplay/getMemoryData",
    				dataType:"json",
    				data :memQuery,
    				async: false, 
    				success : function(data) {
    					d=data;
    				}
    			});
        		return d;
        	}
        	var getCpuData=function(cpuQuery){
        		var showUnit=$("input[name=showUnit]:checked").val();
    			var d = [];
    			$.ajax({
    				url : getServer() + "/sword/monitor/historicalDataDisplay/getCpuData",
    				dataType:"json",
    				data :cpuQuery,
    				async: false, 
    				success : function(data) {
    					d=data;
    				}
    			});
        		return d;
        	}
        	var getSecondCacheData=function(secondCacheQuery){
        		var showUnit=$("input[name=showUnit]:checked").val();
    			var d = [];
    			$.ajax({
    				url : getServer() + "/sword/monitor/historicalDataDisplay/getSecondCacheData",
    				dataType:"json",
    				data :secondCacheQuery,
    				async: false, 
    				success : function(data) {
    					d=data;
    				}
    			});
        		return d;
        	}
        	var getPersisstenceConnectCountData=function(persisstenceConnectCountQuery){
        		var showUnit=$("input[name=showUnit]:checked").val();
    			var d = [];
    			$.ajax({
    				url : getServer() + "/sword/monitor/historicalDataDisplay/getPersisstenceConnectCountData",
    				dataType:"json",
    				data :persisstenceConnectCountQuery,
    				async: false, 
    				success : function(data) {
    					d=data;
    				}
    			});
        		return d;
        	}
        	var getCurrentWebThreadsData=function(currentWebThreadsQuery){
        		var showUnit=$("input[name=showUnit]:checked").val();
    			var d = [];
    			$.ajax({
    				url : getServer() + "/sword/monitor/historicalDataDisplay/getCurrentWebThreadsData",
    				dataType:"json",
    				data :currentWebThreadsQuery,
    				async: false, 
    				success : function(data) {
    					d=data;
    				}
    			});
        		return d;
        	}
        	var getBusyWebThreadsData=function(busyWebThreadsQuery){
        		var showUnit=$("input[name=showUnit]:checked").val();
    			var d = [];
    			$.ajax({
    				url : getServer() + "/sword/monitor/historicalDataDisplay/getBusyWebThreadsData",
    				dataType:"json",
    				data :busyWebThreadsQuery,
    				async: false, 
    				success : function(data) {
    					d=data;
    				}
    			});
        		return d;
        	}
        	var getHttpErrorCountData=function(httpErrorCountQuery){
        		var showUnit=$("input[name=showUnit]:checked").val();
    			var d = [];
    			$.ajax({
    				url : getServer() + "/sword/monitor/historicalDataDisplay/getHttpErrorCountData",
    				dataType:"json",
    				data :httpErrorCountQuery,
    				async: false, 
    				success : function(data) {
    					d=data;
    				}
    			});
        		return d;
        	}
        	
        	
        	
        	
        	var convertToMemChartData=function(data){
        		var d=[];
				for(var i=0;i<data.length;i++){
                    d.push([
	                        new Date(data[i].time),
	                        data[i].memoryRatio,
	                        data[i].freeMemory,
	                        data[i].totalMemory
	                    ]);
				}
				return d;
        	}

        	var convertToPersisstenceConnectCountChartData=function(data){			
        		var d=new Object(); 
        		for(var server in data){
        			d[server]=[];
    				for(var i=0;i<data[server].length;i++){
                        d[server].push([
            	                new Date(data[server][i].time),
            	                data[server][i].persisstenceConnectCountRatio,
            	                data[server][i].activeCount,
            	                data[server][i].maxActive
    	                    ]);
    				}
        		}
				return d;
        	}
        	var convertToCpuChartData=function(data){
        		var d=[];
				for(var i=0;i<data.length;i++){
                    d.push([
	                        new Date(data[i].time),
	                        data[i].cpuRatio
	                    ]);
				}
				return d;
        	}
        	var convertToSecondCacheChartData=function(data){
        		var d=new Object(); 
        		for(var server in data){
        			d[server]=[];
    				for(var i=0;i<data[server].length;i++){
                        d[server].push([
    	                        new Date(data[server][i].time),
    	                        data[server][i].secondCacheRatio,
    	                        data[server][i].bytes,
    	                        data[server][i].limitMaxbytes
    	                    ]);
    				}
        		}

				return d;
        	}
        	var convertToHttpErrorCountChartData=function(data){
        		var d=[];
				for(var i=0;i<data.length;i++){
                    d.push([
	                        new Date(data[i].time),
	                        data[i].httpErrorCountRatio,
	                        data[i].errorCount,
	                        data[i].requestCount
	                    ]);
				}
				return d;
        	}
        	var convertToBusyWebThreadsChartData=function(data){
        		var d=[];
				for(var i=0;i<data.length;i++){
                    d.push([
	                        new Date(data[i].time),
	                        data[i].busyWebThreadsRatio,
	                        data[i].currentThreadsBusy,
	                        data[i].currentThreadCount
	                    ]);
				}
				return d;
        	}
        	var convertToCurrentWebThreadsChartData=function(data){
        		var d=[];
				for(var i=0;i<data.length;i++){
                    d.push([
	                        new Date(data[i].time),
	                        data[i].currentWebThreadsRatio,
	                        data[i].currentThreadCount,
	                        data[i].maxThreads
	                    ]);
				}
				return d;
        	}
       	 $("input[name=showUnit]").click(function(){
       		var showUnit=$("input[name=showUnit]:checked").val();
       		searchHistoricalData();       		  
       	 });
       	$("#searchStartTime").datetimepicker().on('changeDate', function(ev){
       		searchHistoricalData();
       	});
       	$("#searchEndTime").datetimepicker().on('changeDate', function(ev){
       		searchHistoricalData();
       	});
       	 var searchHistoricalData=function(){
       	 	var query =Tool.serialize("pdMonitorSearchInfoEditor");
       	 	query["showUnit"]=$("input[name=showUnit]:checked").val();
       	 	var memData=getMemoryData(query);
       	 	var memEchartData=convertToMemChartData(memData);

       	 	var cpuData=getCpuData(query);
       	 	var cpuEchartData=convertToCpuChartData(cpuData);
       	 	var secondCacheData=getSecondCacheData(query);
       	 	var secondCacheEchartData=convertToSecondCacheChartData(secondCacheData);
       	 	var persisstenceConnectCountData=getPersisstenceConnectCountData(query);
       	 	var persisstenceConnectCountEchartData=convertToPersisstenceConnectCountChartData(persisstenceConnectCountData);
       	 	var httpErrorCountData=getHttpErrorCountData(query);
    	 	var httpErrorCountEchartData=convertToHttpErrorCountChartData(httpErrorCountData);
			
			var busyWebThreadsData=getBusyWebThreadsData(query);
    	 	var busyWebThreadsEchartData=convertToBusyWebThreadsChartData(busyWebThreadsData);
			
			var currentWebThreadsData=getCurrentWebThreadsData(query);
    	 	var currentWebThreadsEchartData=convertToCurrentWebThreadsChartData(currentWebThreadsData);
       	 	var historicalEchartOption1 = {
            		title : {
            			text: '服务器历史状态信息'
               		},
        		    tooltip : {
        		        trigger: 'item',
        		        formatter : function (params) {
        		        	var seriesName=params.seriesName;
        		            var date = new Date(params.value[0]);
        		            data = date.getFullYear() + '-'
        		                   + (date.getMonth() + 1) + '-'
        		                   + date.getDate() + ' '
        		                   + date.getHours() + ':'
        		                   + date.getMinutes();
        		            var str=data+ '<br/>'
		            		+ seriesName + '：'
		            		+ params.value[1]+'%<br/>';
                      		var showUnit=$("input[name=showUnit]:checked").val();
                      		if(showUnit!='ORIGIN'){
            		            return str+"Tips：原始数据可显示详细状态";
                      		}
                      		if(params.seriesName=="MEM内存占比"){
                      			str+="freeMemory:"+params.value[2]+ '<br/>'+"totalMemory:"+params.value[3];
                      		}else if(params.seriesName=="正在运行的Web线程数占比"){
                      			str+="currentThreadsBusy:"+params.value[2]+ '<br/>'+"currentThreadCount:"+params.value[3];
                      		}
                      		
        		            return str;
        		        }
        		    },
        		    toolbox: {
        		        show : true,
        		        feature : {
        		            mark : {show: true},
        		            dataView : {show: true, readOnly: false},
        		            restore : {show: true},
        		            saveAsImage : {show: true}
        		        }
        		    },
        		    legend : {
        		        data : ['MEM内存占比','Cpu占比','正在运行的Web线程数占比']
        		    },
        		    grid: {
        		        y2: 80
        		    },
        		    xAxis : [
        		        {
        		            type : 'time',
        		            splitNumber:10
        		        }
        		    ],
        		    yAxis : [
        		        {
        		            type : 'value',
        		            axisLabel : {
        		                formatter: '{value} %'
        		            }
        		        }
        		    ],
        		    series : [
        		        {
        		            name: 'MEM内存占比',
        		            type: 'line',
        		            showAllSymbol: true,
        		            data: memEchartData
        		        },
        		        {
        		            name: 'Cpu占比',
        		            type: 'line',
        		            showAllSymbol: true,
        		            data: cpuEchartData
        		        },
         		        {
         		            name: '正在运行的Web线程数占比',
         		            type: 'line',
         		            showAllSymbol: true,
         		            data: busyWebThreadsEchartData
         		        }
        		    ]
        		};
       	 var historicalEchartOption2 = {
     		    tooltip : {
    		        trigger: 'item',
    		        formatter : function (params) {
    		        	var seriesName=params.seriesName;
    		            var date = new Date(params.value[0]);
    		            data = date.getFullYear() + '-'
    		                   + (date.getMonth() + 1) + '-'
    		                   + date.getDate() + ' '
    		                   + date.getHours() + ':'
    		                   + date.getMinutes();
    		            var str=data+ '<br/>'
	            		+ seriesName + '：'
	            		+ params.value[1]+'%<br/>';
                  		var showUnit=$("input[name=showUnit]:checked").val();
                  		if(showUnit!='ORIGIN'){
        		            return str+"Tips：原始数据可显示详细状态";
                  		}
                  		if(params.seriesName=="Http请求错误数占比"){
                  			str+="errorCount:"+params.value[2]+ '<br/>'+"requestCount:"+params.value[3];
                  		}else if(params.seriesName=="当前Web线程数占比"){
                  			str+="currentThreadCount:"+params.value[2]+ '<br/>'+"maxThreads:"+params.value[3];
                  		}
                  		
    		            return str;
    		        }
    		    },
     		    toolbox: {
     		        show : true,
     		        feature : {
     		            mark : {show: true},
     		            dataView : {show: true, readOnly: false},
     		            restore : {show: true},
     		            saveAsImage : {show: true}
     		        }
     		    },
     		    legend : {
     		        data : ['当前Web线程数占比','Http请求错误数占比']
     		    },
     		    grid: {
     		        y2: 80
     		    },
     		    xAxis : [
     		        {
     		            type : 'time',
     		            splitNumber:10
     		        }
     		    ],
     		    yAxis : [
     		        {
     		            type : 'value',
     		            axisLabel : {
     		                formatter: '{value} %'
     		            }
     		        }
     		    ],
     		    series : [
     		        {
     		            name: '当前Web线程数占比',
     		            type: 'line',
     		            showAllSymbol: true,
     		            data: currentWebThreadsEchartData
     		        },
     		        {
     		            name: 'Http请求错误数占比',
     		            type: 'line',
     		            showAllSymbol: true,
     		            data: httpErrorCountEchartData
     		        }
     		    ]
     		};
       	 var historicalEchartOption3 = {
        		title : {
        			text: '持久层连接数占比'
           		},
      		    tooltip : {
     		        trigger: 'item',
     		        formatter : function (params) {
     		        	var seriesName=params.seriesName;
     		            var date = new Date(params.value[0]);
     		            data = date.getFullYear() + '-'
     		                   + (date.getMonth() + 1) + '-'
     		                   + date.getDate() + ' '
     		                   + date.getHours() + ':'
     		                   + date.getMinutes();
     		            var str=data+ '<br/>'
 	            		+ seriesName + '：'
 	            		+ params.value[1]+'%<br/>';
                   		var showUnit=$("input[name=showUnit]:checked").val();
                   		if(showUnit!='ORIGIN'){
         		            str+"Tips：原始数据可显示详细状态";
                   		}else{
                   			str+="activeCount:"+params.value[2]+ '<br/>'+"maxActive:"+params.value[3];
                   		}
     		            return str;
     		        }
     		    },
      		    toolbox: {
      		        show : true,
      		        feature : {
      		            mark : {show: true},
      		            dataView : {show: true, readOnly: false},
      		            restore : {show: true},
      		            saveAsImage : {show: true}
      		        }
      		    },
      		    legend : {
      		    },
      		    grid: {
      		        y2: 80
      		    },
      		    xAxis : [
      		        {
      		            type : 'time',
      		            splitNumber:10
      		        }
      		    ],
      		    yAxis : [
      		        {
      		            type : 'value',
      		            axisLabel : {
      		                formatter: '{value} %'
      		            }
      		        }
      		    ],
      		    series : [
//        		        {
////        		            name: '持久层连接数占比',
////        		            type: 'line',
////        		            showAllSymbol: true,
////        		            data: persisstenceConnectCountEchartData
//        		        }
      		    ]
      		};
       	 var historicalEchartOption4 = {
       		    title : {
       		        text: '二级缓存内存占比'
       		    },
      		    tooltip : {
     		        trigger: 'item',
     		        formatter : function (params) {
     		        	var seriesName=params.seriesName;
     		            var date = new Date(params.value[0]);
     		            data = date.getFullYear() + '-'
     		                   + (date.getMonth() + 1) + '-'
     		                   + date.getDate() + ' '
     		                   + date.getHours() + ':'
     		                   + date.getMinutes();
     		            var str=data+ '<br/>'
 	            		+ seriesName + '：'
 	            		+ params.value[1]+'%<br/>';
                   		var showUnit=$("input[name=showUnit]:checked").val();
                   		if(showUnit!='ORIGIN'){
         		            str+"Tips：原始数据可显示详细状态";
                   		}else{
                   			str+="bytes:"+params.value[2]+ '<br/>'+"limitMaxbytes:"+params.value[3];
                   		}
     		            return str;
     		        }
     		    },
      		    toolbox: {
      		        show : true,
      		        feature : {
      		            mark : {show: true},
      		            dataView : {show: true, readOnly: false},
      		            restore : {show: true},
      		            saveAsImage : {show: true}
      		        }
      		    },
      		    legend : {
      		    },
      		    grid: {
      		        y2: 80
      		    },
      		    xAxis : [
      		        {
      		            type : 'time',
      		            splitNumber:10
      		        }
      		    ],
      		    yAxis : [
      		        {
      		            type : 'value',
      		            axisLabel : {
      		                formatter: '{value} %'
      		            }
      		        }
      		    ],
      		    series : [
      		    ]
      		};
       	 
       	 	var extendEchartOption = function(option,echartData){
       	 		var legendData=[];
       	 		var series=[];
       	 		for(var server in echartData){
       	 			if(echartData[server].length>0){
       	 				legendData.push(server);
	       	 			series.push(
	       	 					{
	       	 							name:server,
	       	 							type:'line',
	       	 							showAllSymbol: true,
	       	 							data: echartData[server]
	       	 			});
       	 			}
       	 		}
       	 		var legend={};
       	 		legend['data']=legendData;
       	 		return $.extend(option,{legend:legend,series:series});
       	 	}
       	 
       	 
       	 		var secondCacheOption=extendEchartOption(historicalEchartOption4,secondCacheEchartData);
       	 		
       	 		var persisstenceConnectCountOption=extendEchartOption(historicalEchartOption3,persisstenceConnectCountEchartData);
       	 
       	 		var historicalCaseDiv1=$("#historicalEchart1")[0];
       	 		historicalChart1=echarts.init(historicalCaseDiv1);	                    
       	 		historicalChart1.setOption(historicalEchartOption1,true);
       	 		
       	 		var historicalCaseDiv2=$("#historicalEchart2")[0];
       	 		historicalChart2=echarts.init(historicalCaseDiv2);	                    
       	 		historicalChart2.setOption(historicalEchartOption2,true);

       	 		
       	 		var historicalCaseDiv3=$("#historicalEchart3")[0];
       	 		historicalChart3=echarts.init(historicalCaseDiv3);	                    
       	 		historicalChart3.setOption(persisstenceConnectCountOption,true);
       	 		
       	 		var historicalCaseDiv4=$("#historicalEchart4")[0];
       	 		historicalChart4=echarts.init(historicalCaseDiv4);	                    
       	 		historicalChart4.setOption(secondCacheOption,true);
       	 		
       	 	}
       	 	$("#pdHistoricalDataDisplay").on("click",function(){
       	 		window.setTimeout(function(){
       	 			historicalChart1.resize();
       	 			historicalChart2.resize();
       	 			historicalChart3.resize();
       	 			historicalChart4.resize();
       	 		}, 300);

       	 	});
       	 	
       	 	
       	
       	
       	
       	 	$("#pdMonitorBtnRefreshCurrentData").on("click",function(){

       	 		window.setTimeout(function(){
           	 		searchCurrentData();
       	 		}, 300);
       	 	});
        	var getCurrentMemoryData=function(){
    			var currentData = {};
    			$.ajax({
    				url : getServer() + "/sword/monitor/currentDataDisplay/getMemoryData",
    				dataType:"json",
    				async: false, 
    				success : function(data) {
    					if(data.status=="success"){
    						currentData=data.data;
    					}
    				}
    			});
        		return currentData;
        	}
        	var getCurrentCpuData=function(){
    			var currentData = [];
    			$.ajax({
    				url : getServer() + "/sword/monitor/currentDataDisplay/getCpuData",
    				dataType:"json",
    				async: false, 
    				success : function(data) {
    					if(data.status=="success"){
    						currentData=data.data;
    					}
    				}
    			});
        		return currentData;
        	}
        	var getCurrentPersisstenceConnectCountData=function(){
    			var currentData = new Object(); 
    			$.ajax({
    				url : getServer() + "/sword/monitor/currentDataDisplay/getPersisstenceConnectCountData",
    				dataType:"json",
    				async: false, 
    				success : function(data) {
						currentData=data;
    				}
    			});
        		return currentData;
        	}
        	var getCurrentSecondCacheData=function(){
    			var currentData = new Object(); 
    			$.ajax({
    				url : getServer() + "/sword/monitor/currentDataDisplay/getSecondCacheData",
    				dataType:"json",
    				async: false, 
    				success : function(data) {
						currentData=data;
    				}
    			});
        		return currentData;
        	}
        	var getCurrentHttpErrorCountData=function(){
    			var currentData = [];
    			$.ajax({
    				url : getServer() + "/sword/monitor/currentDataDisplay/getHttpErrorCountData",
    				dataType:"json",
    				async: false, 
    				success : function(data) {
    					if(data.status=="success"){
    						currentData=data.data;
    					}
    				}
    			});
        		return currentData;
        	}
        	var getCurrentBusyWebThreadsData=function(){
    			var currentData = [];
    			$.ajax({
    				url : getServer() + "/sword/monitor/currentDataDisplay/getBusyWebThreadsData",
    				dataType:"json",
    				async: false, 
    				success : function(data) {
    					if(data.status=="success"){
    						currentData=data.data;
    					}
    				}
    			});
        		return currentData;
        	}
        	var getCurrentWebThreadsDataCurrent=function(){
    			var currentData = [];
    			$.ajax({
    				url : getServer() + "/sword/monitor/currentDataDisplay/getCurrentWebThreadsData",
    				dataType:"json",
    				async: false, 
    				success : function(data) {
    					if(data.status=="success"){
    						currentData=data.data;
    					}
    				}
    			});
        		return currentData;
        	}


	 		
	 		
	 		
	 		
       	 	var searchCurrentData=function(){
           	 	var currentMemData=getCurrentMemoryData();
           	 	var currentCpuData=getCurrentCpuData();
           	 	var currentPersisstenceConnectCountData=getCurrentPersisstenceConnectCountData();
           	 	var currentSecondCacheData=getCurrentSecondCacheData();
           	 	var currentHttpErrorCountData=getCurrentHttpErrorCountData();
           	 	var currentBusyWebThreadsData=getCurrentBusyWebThreadsData();
           	 	var currentWebThreadsData=getCurrentWebThreadsDataCurrent();
           	 var gaugeOption1 = {
                  	title : {
                 		text: '服务器当前状态信息'
                    	},
           			tooltip : {
      	 				formatter: function (params) {
      	 					var str=params.seriesName+':'+params.value+'%<br/>'+'numerator:'+params.data.numerator+'<br/>'+'denominator:'+params.data.denominator;	
      	 					return str;
      	 				}
           			},
            	     toolbox: {
            	         show : true,
            	         feature : {
            	             saveAsImage : {show: true}
            	         }
            	     },
            	  series : [
            	         {
            	             name:'Cpu占比',
            	             type:'gauge',
            	             z: 3,
            	             min:0,
            	             max:100,
            	             splitNumber:10,
            	             axisLine: {            // 坐标轴线
            	                 lineStyle: {       // 属性lineStyle控制线条样式
            	                     width: 10
            	                 }
            	             },
            	             axisTick: {            // 坐标轴小标记
            	                 length :15,        // 属性length控制线长
            	                 lineStyle: {       // 属性lineStyle控制线条样式
            	                     color: 'auto'
            	                 }
            	             },
            	             splitLine: {           // 分隔线
            	                 length :20,         // 属性length控制线长
            	                 lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
            	                     color: 'auto'
            	                 }
            	             },
            	             title : {
            	                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
            	                     fontWeight: 'bolder',
            	                     fontSize: 20,
            	                     fontStyle: 'italic'
            	                 }
            	             },
            	             detail :  {formatter:'{value}%'},

            	             data:[{value: currentCpuData.cpuRatio, name: 'Cpu占比',                 	 		
            	            	 tooltip : {
            	            		 formatter: function (params) {
            	            			 var str=params.seriesName+':'+params.value+'%<br/>';
            	            			 return str;
            	            		 }
            	            	 }
            	             }]
            	         },
            	      {
            	             name:'MEM内存占比',
            	             type:'gauge',
            	            center : ['25%', '55%'],    // 默认全局居中
            	            radius : '50%',
            	             z: 3,
            	             min:0,
            	             max:100,
            	             splitNumber:10,
            	            endAngle:45,
            	             axisLine: {            // 坐标轴线
            	                 lineStyle: {       // 属性lineStyle控制线条样式
            	                     width: 10
            	                 }
            	             },
            	             axisTick: {            // 坐标轴小标记
            	                 length :15,        // 属性length控制线长
            	                 lineStyle: {       // 属性lineStyle控制线条样式
            	                     color: 'auto'
            	                 }
            	             },
            	             splitLine: {           // 分隔线
            	                 length :20,         // 属性length控制线长
            	                 lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
            	                     color: 'auto'
            	                 }
            	             },
            	             title : {
            	                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
            	                     fontWeight: 'bolder',
            	                     fontSize: 20,
            	                     fontStyle: 'italic'
            	                 }
            	             },
            	             detail :  {formatter:'{value}%'},
            	             data:[{value: currentMemData.memoryRatio, name: 'MEM内存占比',freeMemory:currentMemData.freeMemory,totalMemory:currentMemData.totalMemory,
                	             tooltip : {
                    	 				formatter: function (params) {
                    	 					var str=params.data.name+':'+params.data.value+'%<br/>'+"freeMemory:"+params.data.freeMemory+'<br/>'+"totalMemory:"+params.data.totalMemory;
                    	 					return str;
                    	 				}
                 	             }
            	             }]
            	         },


            	      {
            	             name:'运行Web线程数占比',
            	             type:'gauge',
            	            center : ['75%', '50%'],   
            	            radius : '50%',
            	             z: 3,
            	             min:0,
            	             max:100,
            	             startAngle:135,
            	             endAngle:45,
            	             splitNumber:5,
            	             axisLine: {            // 坐标轴线
            	                 lineStyle: {       // 属性lineStyle控制线条样式
            	                     width: 10
            	                 }
            	             },
            	             axisTick: {            // 坐标轴小标记
            	                 length :15,        // 属性length控制线长
            	                 lineStyle: {       // 属性lineStyle控制线条样式
            	                     color: 'auto'
            	                 }
            	             },
            	            axisLabel: {
            	                formatter:function(v){
            	                	return v+"";
            	                }
            	            },
            	             splitLine: {           // 分隔线
            	                 length :20,         // 属性length控制线长
            	                 lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
            	                     color: 'auto'
            	                 }
            	             },
            	             title : {
            	                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
            	                     fontWeight: 'bolder',
            	                     fontSize: 20,
            	                     fontStyle: 'italic'
            	                 },
            	                 offsetCenter: [0, '-55%']
            	             },
            	             detail :  {formatter:'{value}%',offsetCenter: [0, '-40%']},
            	             data:[{value: currentBusyWebThreadsData.busyWebThreadsRatio, name: '运行Web线程数占比',currentThreadsBusy:currentBusyWebThreadsData.currentThreadsBusy,currentThreadCount:currentBusyWebThreadsData.currentThreadCount,
            	            	 tooltip : {
                  	 				formatter: function (params) {
                  	 					var str=params.seriesName+':'+params.value+'%<br/>'+'currentThreadsBusy:'+params.data.currentThreadsBusy+'<br/>'+'currentThreadCount:'+params.data.currentThreadCount;	
                  	 					return str;
                  	 				}
                       	 		}}]
            	         } ,          	       	      
            	         {
            	        	 name:'当前Web线程数占比',
            	             type:'gauge',
            	            center : ['75%', '50%'],   
            	            radius : '50%',
            	             z: 3,
            	             min:0,
            	             max:100,
            	             startAngle:315,
            	             endAngle:225,
            	             splitNumber:5,
            	             axisLine: {            // 坐标轴线
            	                 lineStyle: {       // 属性lineStyle控制线条样式
            	                     width: 10
            	                 }
            	             },
            	             axisTick: {            // 坐标轴小标记
            	                 length :15,        // 属性length控制线长
            	                 lineStyle: {       // 属性lineStyle控制线条样式
            	                     color: 'auto'
            	                 }
            	             },
            	            axisLabel: {
            	                formatter:function(v){
            	                	return v+"";
            	                }
            	            },
            	             splitLine: {           // 分隔线
            	                 length :20,         // 属性length控制线长
            	                 lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
            	                     color: 'auto'
            	                 }
            	             },
            	             title : {
            	                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
            	                     fontWeight: 'bolder',
            	                     fontSize: 20,
            	                     fontStyle: 'italic'
            	                 },
            	                 offsetCenter: [0, '35%'],
            	             },
             	             detail :  {formatter:'{value}%'},
             	             data:[{value: currentWebThreadsData.currentWebThreadsRatio, name: '当前Web线程数占比',currentThreadCount:currentWebThreadsData.currentThreadCount,maxThreads:currentWebThreadsData.maxThreads,
                       	 		tooltip : {
                         	         formatter: function (params) {
                         	        	var str=params.seriesName+':'+params.value+'%<br/>'+'currentThreadCount:'+params.data.currentThreadCount+'<br/>'+'maxThreads:'+params.data.maxThreads;
                         	        	
                         	        	return str;
                         	         }
                         	     }}]
             	         }
            	 	]
            	 	};
               	 var gaugeOption2 = {
               	 		tooltip : {
               	         formatter: function (params) {
               	        	var str=params.seriesName+':'+params.value+'%<br/>'+'errorCount:'+params.data.errorCount+'<br/>'+'requestCount:'+params.data.requestCount;
               	        	
               	        	return str;
               	         }
               	     },
               	     toolbox: {
               	         show : true,
               	         feature : {
               	             saveAsImage : {show: true}
               	         }
               	     },
               	  series : [
               	           {
                   	             name:'Http请求错误数占比',
                   	             type:'gauge',
                   	             z: 3,
                   	             min:0,
                   	             max:100,
                   	             splitNumber:10,
                   	             axisLine: {            // 坐标轴线
                   	                 lineStyle: {       // 属性lineStyle控制线条样式
                   	                     width: 10
                   	                 }
                   	             },
                   	             axisTick: {            // 坐标轴小标记
                   	                 length :15,        // 属性length控制线长
                   	                 lineStyle: {       // 属性lineStyle控制线条样式
                   	                     color: 'auto'
                   	                 }
                   	             },
                   	             splitLine: {           // 分隔线
                   	                 length :20,         // 属性length控制线长
                   	                 lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
                   	                     color: 'auto'
                   	                 }
                   	             },
                   	             title : {
                   	                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                   	                     fontWeight: 'bolder',
                   	                     fontSize: 20,
                   	                     fontStyle: 'italic'
                   	                 }
                   	             },
                   	             detail :  {formatter:'{value}%'},
                   	             data:[{value: currentHttpErrorCountData.httpErrorCountRatio, name: 'Http请求错误数占比',errorCount:currentHttpErrorCountData.errorCount,requestCount:currentHttpErrorCountData.requestCount}]
                   	         }
               	 	]
               	 	};
            	 	
            	 


            	var secondCacheGaugeOption = {
                 	title : {
                 		text: '二级缓存内存占比'
                    	},
         	 		tooltip : {
         	         formatter: function (params) {
         	        	var str=params.seriesName+':'+params.value+'%<br/>'+'bytes:'+params.data.bytes+'<br/>'+'limitMaxbytes:'+params.data.limitMaxbytes;
         	        	
         	        	return str;
         	         }
         	     },
         	     toolbox: {
         	         show : true,
         	         feature : {
         	             saveAsImage : {show: true}
         	         }
         	     },
         	  series : [

         	 	]
         	 	};
            	
            	
            	var persisitenceGaugeOption = {
                     	title : {
                     		text: '持久层连接数占比'
                        	},
                        	tooltip : {
	                	         formatter: function (params) {
	                	        	var str=params.seriesName+':'+params.value+'%<br/>'+'activeCount:'+params.data.activeCount+'<br/>'+'maxActive:'+params.data.maxActive;
	                	        	
	                	        	return str;
	                	         }
	                	     },
             	     toolbox: {
             	         show : true,
             	         feature : {
             	             saveAsImage : {show: true}
             	         }
             	     },
             	  series : [
             	       	      ]
             	 	};
           	 	var getPersisstenceConnectCountSeries= function(currentPersisstenceConnectCountData){
           	 		var propertyNum=Object.getOwnPropertyNames(currentPersisstenceConnectCountData).length;
           	 		var delta=100/Math.pow(2,propertyNum);
       	 			var index=0;
       	 			var series=[];
           	 		for(var server in currentPersisstenceConnectCountData){
           	 			var coordinate=delta*(index*2+1);
           	 			coordinate=coordinate.toString();
           	 			index++;
           	 			var showData=currentPersisstenceConnectCountData[server];
           	 			series.push({
        	       	             name:server,
         	       	             type:'gauge',
         	       	             z: 3,
         	       	             min:0,
         	       	             max:100,
         	       	             center : [coordinate+'%', '55%'],    // 默认全局居中
         	       	             splitNumber:5,
         	       	             axisLine: {            // 坐标轴线
         	       	                 lineStyle: {       // 属性lineStyle控制线条样式
         	       	                     width: 10
         	       	                 }
         	       	             },
         	       	             axisTick: {            // 坐标轴小标记
         	       	                 length :15,        // 属性length控制线长
         	       	                 lineStyle: {       // 属性lineStyle控制线条样式
         	       	                     color: 'auto'
         	       	                 }
         	       	             },
         	       	          axisLabel: {
         	     	                formatter:function(v){
         	     	                	return v+"";
         	     	                }
         	     	            },
         	       	             splitLine: {           // 分隔线
         	       	                 length :20,         // 属性length控制线长
         	       	                 lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
         	       	                     color: 'auto'
         	       	                 }
         	       	             },
         	       	             title : {
         	       	                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
         	       	                     fontWeight: 'bolder',
         	       	                     fontSize: 20,
         	       	                     fontStyle: 'italic'
         	       	                 }
         	       	             },
         	       	             detail :  {formatter:'{value}%'},
         	       	             data:[{value: showData.persisstenceConnectCountRatio, name: server,activeCount:showData.activeCount,maxActive:showData.maxActive
         	              	 		}]
         	       	         });
                        	
           	 		}
           	 		return series;
           	 	}
           	 	
           	 	var getSecondCacheSeries= function(currentSecondCacheData){
           	 		var propertyNum=Object.getOwnPropertyNames(currentSecondCacheData).length;
           	 		var delta=100/Math.pow(2,propertyNum);
       	 			var index=0;
       	 			var series=[];
           	 		for(var server in currentSecondCacheData){
           	 			var coordinate=delta*(index*2+1);
           	 			coordinate=coordinate.toString();
           	 			index++;
           	 			var showData=currentSecondCacheData[server];
           	 			series.push({
        	       	             name:server,
         	       	             type:'gauge',
         	       	             z: 3,
         	       	             min:0,
         	       	             max:100,
         	       	             center : [coordinate+'%', '55%'],    // 默认全局居中
         	       	             splitNumber:5,
         	       	             axisLine: {            // 坐标轴线
         	       	                 lineStyle: {       // 属性lineStyle控制线条样式
         	       	                     width: 10
         	       	                 }
         	       	             },
         	       	             axisTick: {            // 坐标轴小标记
         	       	                 length :15,        // 属性length控制线长
         	       	                 lineStyle: {       // 属性lineStyle控制线条样式
         	       	                     color: 'auto'
         	       	                 }
         	       	             },
         	       	          axisLabel: {
         	     	                formatter:function(v){
         	     	                	return v+"";
         	     	                }
         	     	            },
         	       	             splitLine: {           // 分隔线
         	       	                 length :20,         // 属性length控制线长
         	       	                 lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
         	       	                     color: 'auto'
         	       	                 }
         	       	             },
         	       	             title : {
         	       	                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
         	       	                     fontWeight: 'bolder',
         	       	                     fontSize: 20,
         	       	                     fontStyle: 'italic'
         	       	                 }
         	       	             },
         	       	             detail :  {formatter:'{value}%'},
         	       	             data:[{value: showData.secondCacheRatio, name: server,bytes:showData.bytes,limitMaxbytes:showData.limitMaxbytes
         	              	 		}]
         	       	         });
                        	
           	 		}
           	 		return series;
           	 	}
            	
            	
           	 var persisstenceConnectCountSeries=getPersisstenceConnectCountSeries(currentPersisstenceConnectCountData);
           	var secondCacheSeries= getSecondCacheSeries(currentSecondCacheData);
            	
           	$.extend(persisitenceGaugeOption, {series : persisstenceConnectCountSeries});
           	$.extend(secondCacheGaugeOption, {series : secondCacheSeries});
            	
           	 	
           	 	
                
       	 		gauge1.setOption(gaugeOption1,true);
           	 	
              
    	 		gauge2.setOption(gaugeOption2,true);
    	 		
       	 		
           
    	 		gauge4.setOption(secondCacheGaugeOption,true);
    	 		
    
    	 		gauge5.setOption(persisitenceGaugeOption,true);
       	 	}
	 		

       	 	
       	 	
   	 		var gaugeCaseDiv1=$("#gauge1")[0];
   	 		gauge1=echarts.init(gaugeCaseDiv1);	    
   	 		var gaugeCaseDiv2=$("#gauge2")[0];
	 		gauge2=echarts.init(gaugeCaseDiv2);	      
   	 		var gaugeCaseDiv4=$("#secondCacheGauge")[0];
	 		gauge4=echarts.init(gaugeCaseDiv4);	         
   	 		var gaugeCaseDiv5=$("#persisitenceGauge")[0];
	 		gauge5=echarts.init(gaugeCaseDiv5);	                
       	 	
      		 var now=new Date();
       		 var endTimeStr=now.Format("yyyy-MM-dd hh:mm:ss"); 
       		 now.setTime(now.getTime()-24*3600*1000);
       		 var startTimeStr=now.Format("yyyy-MM-dd hh:mm:ss"); 
       		 $("#searchStartTime").val(startTimeStr);
       		 $("#searchEndTime").val(endTimeStr);
       		 searchHistoricalData();
       		 searchCurrentData();
       		 
       		 
       		 
//       		clearInterval(timeTicket);
       		timeTicket = setInterval(function (){
       			searchCurrentData();
       		},10000)
       		
       		
		});
	};
});