/**
 * Sword基础框架 ： sword-monitor 
 * Copyright 中国软件与技术服务股份有限公司
 */
/**
 * @功能描述 
 *  
 * 系统监控下持久层监控js实现页面包含六个标签页的实现
 * @author YaoGuanhong
 * @创建时间 2015年7月10日 下午1:13:56
 * @History 修订历史<br>
 * 
 */


define(["PDUtilDir/grid",
        "PDUtilDir/util", 
        "ZTree","css!ZTreeCss"], 
        function(Grid, Util){

	/**
	 * 首页(基本信息)表格配置
	 */
//	var homePageGridBaseConfig ={
//			id:"monitor_tab_menu",
//			title:"基本信息",
//			tableBodyHeight:"200px",
//			pageSize:6,
//			cache:false,
//			pagination:false,
//			nowrap:false,
//			layout:[{name:"指标",field:"parameter",width:"15%"},
//			        {name:"指标值",field:"value",width:"85%"}
//			],
//			data:[]
//	}
	
	/**
	 * 首页手动绘制表格
	 */
	function drawTable(data,elementId){
		for (var i = 0; i < data.length; i++) {
			drawRow(data[i],elementId);
		}
	}
	
	
	/**
	 * 绘制表格中的每一列
	 */
	function drawRow(rowData,elementId,width) {
		var row = $("<tr  />")
		$(elementId).append(row);
		row.append($("<td width= \""+width+"\" >"+rowData.parameter+"</td>"));
		row.append($("<td >"+rowData.value+"</td>"));

	}
	
	
	
	
	

	/**	
	 * 初始化首页的表格信息
	 */
	function loadHomePageGrid(){
		$.ajax({
			url:getServer() + "/sword/monitor/dbmonitor/homepageFront",
//			data:{SwordControllerName:"DBmonitorSwordController"},
			success:function(data){
				if(data.status=="success"){
					var rowData=[];
					var info = data.data.Content;
					rowData.push({"parameter":"驱动","value":info.Drivers});
					rowData.push({"parameter":"Druid版本","value":info.Version});
//					重置功能暂时不设置
//					rowData.push({"parameter":"重置次数","value":info.ResetCount.toString()});
//					if(info.ResetEnable == true){
//						rowData.push({"parameter":"是否允许重置","value":"允许"});
//
//					}else{
//						rowData.push({"parameter":"是否允许重置","value":"不允许"});
//						/*如果不允许重置 重置按钮无效*/
//						$("#btn_submit_base").attr("disabled","disabled");
//					}
//					rowData.push({"parameter":"java版本","value":info.JavaVersion});
					rowData.push({"parameter":"jvm名称","value":info.JavaVMName});
					rowData.push({"parameter":"classpath路径","value":info.JavaClassPath});
					rowData.push({"parameter":"连接池启动时间","value":info.StartTime});
				}else{

				}
				drawTable(rowData,"#monitor_tab_table","25%");
//				Grid($.extend(homePageGridBaseConfig, {
//					data:rowData
//				}));
			}
		})
	}

	/**
	 * 路径变量
	 */
	var path = getStaticPath() + "/core/systemMonitor/dbMonitor";

	/**
	 * 数据源页面 当前需要展示的数据源树的节点
	 */
	var dataSourceTreeCurrentNode = null;

	/**
	 * 数据源页面的树id
	 */
	var dataSourceTreeId = "monitor_tree_datasourceDir";

	/**
	 * 数据源页面的表格id
	 */
	var dataSourceGridId = "monitor_grid_datasource";


	/**
	 * 数据源页面的初始化
	 */
	function iniDataSource(){
		//初始化数据源的表格
		//Grid(dataSourceGridBaseConfig);	
		createDatasourceTree();
	}




	/**
	 * 数据源页面表格初始化
	 */
//	var dataSourceGridBaseConfig ={
//			id:"monitor_grid_datasource",
//			//title:"数据源指标信息",//能否动态展示
//			tableBodyHeight:"180 0px",
//			pageSize:100,
//			pagination:false,
//			cache:false,
//			nowrap:false,
//			layout:[{name:"指标 ",field:"parameter",width:"32%"},
//			        {name:"指标值 (时间单位为毫秒)",field:"value",width:"68%"},
//			        //{name:"说明",field:"description"}
//			        ],
//			        data:[]
//	}




	/**
	 * 数据源页面树的初始化
	 */
	function createDatasourceTree(){
		var currentDbName = null;
		var currentClickPhysicName = null;
		$.ajax({
			url:getServer() + "/sword/monitor/dbmonitor/dataSourceFront",
//			data:{SwordControllerName:"DBmonitorSwordController"},
			success:function(data){

				var arr = [];
				if(data.status=="fail"){
					Utils.alert("读取不到持久层配置信息");
				}else{
					currentDbName = data.currentDbName;
					currentClickPhysicName = data.currentPhysicName;
					for(var i = 0,dir;dir = data.treeList[i++];){
						arr.push({"id":dir.id,"parentId":dir.parentId,"name":dir.name,"physicName":dir.physicDsName});
					}
					//配置数据源页面的属性
					var setting = {
							data:{
								key:{
									name:"name"
								},
								simpleData:{
									enable:true,
									idKey:"id",
									pIdKey:"parentId",
									rootPid:null
								}

							},
							view:{
								showLine:true
							},
							callback:{
								onClick : function(event, treeId, treeNode, clickFlag) {
									dataSourceTreeCurrentNode = treeNode;
									var currentClickPhysicName = dataSourceTreeCurrentNode.physicName;
									var dbBaseName = dataSourceTreeCurrentNode.name;
									loadDBbyJdbcUrl(currentClickPhysicName,dbBaseName);
								}
							}

					}
					//初始化
					$.fn.zTree.init($("#" + dataSourceTreeId), setting, arr);


					//展开所有
					$.fn.zTree.getZTreeObj(dataSourceTreeId).expandAll(true);


					loadDBbyJdbcUrl(currentClickPhysicName,currentDbName);


				}
			}
		});
	}



	/**
	 * 数据源页面 请求不同数据源的信息 在表格中显示
	 */

	function loadDBbyJdbcUrl(currentClickPhysicName,currentDbName){
		if(currentClickPhysicName!=null){
			$.ajax({
				url:getServer() + "/sword/monitor/dbmonitor/databasegriddetailFront",
//				data:{SwordControllerName:"DBmonitorSwordController","physicName":currentClickPhysicName},
				data:{"physicName":currentClickPhysicName},
				success:function(data){
					if(data.status=="success"){
						var rowData=[];
						var dbGridData = data.data;
						if(dbGridData == null){
							$("#db_detail").text(currentDbName+"数据源指标信息未获取到 由该连接池未建立引起 ");
							$("#monitor_tab_datasource_table").empty();
						
//							Grid($.extend(dataSourceGridBaseConfig, {
//								data:rowData
//							}));
							
						}else{
							$("#db_detail").text(currentDbName+"数据源指标信息");
							
						

						rowData.push({"parameter":"用户名","value":dbGridData.UserName,"description":"指定建立连接时使用的用户名"});
						rowData.push({"parameter":"连接地址","value":dbGridData.URL,"description":"jdbc连接字符串"});
						rowData.push({"parameter":"数据库类型","value":dbGridData.DbType,"description":"数据库类型"});
						rowData.push({"parameter":"驱动类名","value":dbGridData.DriverClassName,"description":"jdbc驱动类名"});
						rowData.push({"parameter":"filter类名","value":dbGridData.FilterClassNames,"description":"filter的类名"});
						rowData.push({"parameter":"获取连接时检测","value":dbGridData.TestOnBorrow,"description":"是否在获得连接后检测其可用性"});
						rowData.push({"parameter":"空闲时检测","value":dbGridData.TestWhileIdle.toString(),"description":"是否在连接空闲一段时间后检测其可用性"});
						rowData.push({"parameter":"连接放回连接池时检测","value":dbGridData.TestOnReturn.toString(),"description":"是否在连接放回连接池后检测其可用性"});
						rowData.push({"parameter":"初始化连接大小","value":dbGridData.InitialSize,"description":"连接池建立时创建的初始化连接数"});
						rowData.push({"parameter":"最小空闲连接数","value":dbGridData.MinIdle,"description":"连接池中最小的活跃连接数"});
						rowData.push({"parameter":"最大连接数","value":dbGridData.MaxActive,"description":"连接池中最大的活跃连接数"});
						rowData.push({"parameter":"查询超时时间","value":dbGridData.QueryTimeout.toString(),"description":"查询超时时间"});
						rowData.push({"parameter":"事务查询超时时间","value":dbGridData.TransactionQueryTimeout.toString(),"description":"事务查询超时时间"});
						rowData.push({"parameter":"登录超时时间","value":dbGridData.LoginTimeout.toString()});
						rowData.push({"parameter":"连接有效性检查类名","value":dbGridData.ValidConnectionCheckerClassName});
						rowData.push({"parameter":"ExceptionSorter类名","value":dbGridData.ExceptionSorterClassName});
						rowData.push({"parameter":"默认autocommit设置","value":dbGridData.DefaultAutoCommit});


						rowData.push({"parameter":"默认只读设置","value":dbGridData.DefaultReadOnly});
						rowData.push({"parameter":"默认事务隔离","value":dbGridData.DefaultTransactionIsolation});
						rowData.push({"parameter":"等待次数","value":dbGridData.NotEmptyWaitCount,"description":"获取连接时最多等待多少次"});
						rowData.push({"parameter":"等待最大时长","value":dbGridData.NotEmptyWaitMillis,"description":"获取连接时最多等待多长时间"});
						rowData.push({"parameter":"等待线程数量","value":dbGridData.WaitThreadCount.toString(),"description":"当前等待获取连接的线程数"});
						rowData.push({"parameter":"事务启动数","value":dbGridData.StartTransactionCount,"description":"事务开始的个数"});
						rowData.push({"parameter":"事务时间分布","value":dbGridData.TransactionHistogram,"description":"事务运行时间分布，分布区间为[0-10 ms, 10-100 ms, 100-1 s, 1-10 s, 10-100 s, >100 s]"});
						rowData.push({"parameter":"池中连接数","value":dbGridData.PoolingCount,"description":"当前连接池中的数目"});
						rowData.push({"parameter":"池中连接数峰值","value":dbGridData.PoolingPeak,"description":"连接池中数目的峰值"});
						rowData.push({"parameter":"池中连接数峰值时间","value":dbGridData.PoolingPeakTime,"description":"连接池数目峰值出现的时间"});
						rowData.push({"parameter":"活跃连接数","value":dbGridData.ActiveCount.toString(),"description":"当前连接池中活跃连接数"});
						rowData.push({"parameter":"活跃连接数峰值","value":dbGridData.ActivePeak.toString(),"description":"连接池中活跃连接数峰值"});
						rowData.push({"parameter":"活跃连接数峰值时间","value":dbGridData.ActivePeakTime,"description":"活跃连接池峰值出现的时间"});
						rowData.push({"parameter":"逻辑连接打开次数","value":dbGridData.LogicConnectCount.toString(),"description":"产生的逻辑连接建立总数"});
						rowData.push({"parameter":"逻辑连接关闭次数","value":dbGridData.LogicCloseCount.toString(),"description":"产生的逻辑连接关闭总数"});
						rowData.push({"parameter":"逻辑连接错误次数","value":dbGridData.LogicConnectErrorCount.toString(),"description":"产生的逻辑连接出错总数"});
						rowData.push({"parameter":"物理连接打开次数","value":dbGridData.PhysicalConnectCount.toString(),"description":"产生的物理连接建立总数"});
						rowData.push({"parameter":"物理关闭数量","value":dbGridData.PhysicalCloseCount.toString(),"description":"产生的物理关闭总数"});
						rowData.push({"parameter":"物理连接错误次数","value":dbGridData.PhysicalConnectErrorCount.toString(),"description":"产生的物理连接失败总数"});
						rowData.push({"parameter":"执行数","value":dbGridData.ExecuteCount.toString()});
						rowData.push({"parameter":"错误数","value":dbGridData.ErrorCount.toString()});
						rowData.push({"parameter":"提交数","value":dbGridData.CommitCount.toString()});
						rowData.push({"parameter":"回滚数","value":dbGridData.RollbackCount.toString()});
//						rowData.push({"parameter":"PSCache访问次数","value":dbGridData.PSCacheAccessCount.toString(),"description":"PSCache访问总数"});
//						rowData.push({"parameter":"PSCache命中次数","value":dbGridData.PSCacheHitCount.toString(),"description":"PSCache命中次数"});
//						rowData.push({"parameter":"PSCache丢失次数","value":dbGridData.PSCacheMissCount.toString(),"description":"PSCache丢失次数"});
						rowData.push({"parameter":"连接持有时间分布","value":dbGridData.ConnectionHoldTimeHistogram,"description":"连接持有时间分布，分布区间为[0-1 ms, 1-10 ms, 10-100 ms, 100ms-1s, 1-10 s, 10-100 s, 100-1000 s, >1000 s]"});
//						rowData.push({"parameter":"Clob打开次数","value":dbGridData.ClobOpenCount.toString(),"description":"Clob打开数"});
//						rowData.push({"parameter":"Blob打开次数","value":dbGridData.BlobOpenCount.toString(),"description":"Blob打开数"});

						
						
						drawTable(rowData,"#monitor_tab_datasource_table","30%");


//						Grid($.extend(dataSourceGridBaseConfig, {
//							data:rowData
//						}));
						}
					}
					
				}
			});
		}
	}



	/**
	 * sql页面的表格基本配置
	 */
	var sqlGridBaseConfig = {
			id:"monitor_tab_sql",
			//tableBodyHeight:"400px",
			pageSize:10,    
			pagination:true,
			cache:false,
			nowrap:false,
			layout:[
			        {name:"SQL (时间单位为毫秒)",field:"sql",width:"70%",click:function(e){
			        	on_btn_sql_click(e.data.row);
			        }},
			        {name:"执行总次数",sort:true,field:"exeCount",width:"15%"},
			        //{name:"执行时间",sort:true,field:"exeTime",width:"15%"},
			        {name:"平均执行时间",sort:true,field:"AveTime",width:"17%"},
			        {name:"最慢执行时间",sort:true,field:"slowest",width:"17%"},
			        /*{name:"事务中",field:"inTransaction"},
			        {name:"错误数",field:"errorCount"},
			        {name:"更新行数",field:"updateLines"},
			        {name:"读取行数",field:"readLines"},
			        {name:"执行中",field:"exe"},
			        {name:"最大并发",field:"concurrent"}*/
			        ],
			data:[],
			trEvent:[{type:"click",callback:function(e){
			        	on_btn_sql_click(e.data.row);
			        }
			        }]
	}

	 


	//sql单击行事件
	function on_btn_sql_click(row) {
		Util.slidebar({
			url:path + "/views/dbMonitorSql.html",
			width:"500px",
			close:true,
			afterLoad : function() {
				$("#sqlName").html(row.sql);
				$("#exeCount").val(row.exeCount);
				$("#AveTime").val(row.AveTime);
				
				$("#slowest").val(row.slowest);
				$("#inTransaction").val(row.inTransaction);
				$("#errorCount").val(row.errorCount);
				$("#updateLines").val(row.updateLines);
				$("#readLines").val(row.readLines);
				$("#exe").val(row.exe);

				var Histogram = row.Histogram.toString().split(",");

				$("#exeTime_0_1").val(Histogram[0]);
				$("#exeTime_1_10").val(Histogram[1]);
				$("#exeTime_10_100").val(Histogram[2]);
				$("#exeTime_100_1000").val(Histogram[3]);
				$("#exeTime_1_10s").val(Histogram[4]);
				$("#exeTime_10_100s").val(Histogram[5]);
				$("#exeTime_100_1000s").val(Histogram[6]);
				$("#moreThan1000s").val(Histogram[7]);



				var ExecuteAndResultHoldTimeHistogram = row.ExecuteAndResultHoldTimeHistogram.toString().split(",");
				$("#exeTime_0_1RS").val(ExecuteAndResultHoldTimeHistogram[0]);
				$("#exeTime_1_10RS").val(ExecuteAndResultHoldTimeHistogram[1]);
				$("#exeTime_10_100RS").val(ExecuteAndResultHoldTimeHistogram[2]);
				$("#exeTime_100_1000RS").val(ExecuteAndResultHoldTimeHistogram[3]);
				$("#exeTime_1_10sRS").val(ExecuteAndResultHoldTimeHistogram[4]);
				$("#exeTime_10_100sRS").val(ExecuteAndResultHoldTimeHistogram[5]);
				$("#exeTime_100_1000sRS").val(ExecuteAndResultHoldTimeHistogram[6]);
				$("#moreThan1000sRS").val(ExecuteAndResultHoldTimeHistogram[7]);

				var FetchRowCountHistogram = row.FetchRowCountHistogram.toString().split(",");
				$("#readLines0").val(FetchRowCountHistogram[0]);
				$("#readLines1_9").val(FetchRowCountHistogram[1]);
				$("#readLines10_99").val(FetchRowCountHistogram[2]);
				$("#readLines100_999").val(FetchRowCountHistogram[3]);
				$("#readLines1000_9999").val(FetchRowCountHistogram[4]);
				$("#moreThan9999").val(FetchRowCountHistogram[5]);


				var EffectedRowCountHistogram =row.EffectedRowCountHistogram.toString().split(",");
				$("#upLines0").val(EffectedRowCountHistogram[0]);
				$("#upLines1_9").val(EffectedRowCountHistogram[1]);
				$("#upLines10_99").val(EffectedRowCountHistogram[2]);
				$("#upLines100_999").val(EffectedRowCountHistogram[3]);
				$("#upLines1000_9999").val(EffectedRowCountHistogram[4]);
				$("#upmoreThan9999").val(EffectedRowCountHistogram[5]);


				$(":input").prop("readonly",true);

			}
		});
	}



	/**
	 * SQL页面的初始化
	 */
	function iniDataSql(){
		var rowData=[];
		$.ajax({
			url:getServer() + "/sword/monitor/dbmonitor/sqlDataDetailFront",
//			data:{SwordControllerName:"DBmonitorSwordController"},
			success:function(data){
				if(data.status=="success"){
					var gridData = data.data.Content;
					if(gridData!=null){
						for(var i = 0,dir;dir = gridData[i++];){
							rowData.push({"sql":dir.SQL,"exeCount":dir.ExecuteCount.toString(),"exeTime":dir.TotalTime,
								"slowest":dir.MaxTimespan.toString(),"inTransaction":dir.InTransactionCount,
								"errorCount":dir.ErrorCount,"updateLines":dir.EffectedRowCount,
								"readLines":dir.FetchRowCount,"exe":dir.RunningCount,
								"concurrent":dir.ConcurrentMax,"Histogram":dir.Histogram,
								"ExecuteAndResultHoldTimeHistogram":dir.ExecuteAndResultHoldTimeHistogram,
								"FetchRowCountHistogram":dir.FetchRowCountHistogram,"AveTime":dir.AveTime.toString(),
								"EffectedRowCountHistogram":dir.EffectedRowCountHistogram
							});
						}
					}else{
						rowData=[];
					}
				}
				//初始化sql监控页面的表格
				Grid($.extend(sqlGridBaseConfig, {
					data:rowData
				}));
			}

		})


	}



	/**
	 * web页面的表格基本配置
	 */
	var webGridBaseConfig = {
			id:"monitor_tab_web",
			pagination:false,
			cache:false,
			nowrap:false,
			layout:[
			        {name:"指标",field:"parameter"},
			        {name:"指标值",field:"value"},
			        {name:"指标",field:"parameter_second"},
			        {name:"指标值",field:"value_second"}
			        ],
			        data:[]
	}

	/**
	 * web应用监控
	 */
	function initWebApp(){
		var rowData=[];
		$.ajax({
			url:getServer() + "/sword/monitor/dbmonitor/webDataDetailFront",
//			data:{SwordControllerName:"DBmonitorSwordController"},
			success:function(data){
				if(data.status=="success"){
					var gridData = data.data.Content[0];
					if(gridData!=null){

						rowData.push({"parameter":"ContextPath","value":gridData.ContextPath,"parameter_second":"事务回滚数","value_second":gridData.JdbcRollbackCount.toString()});
						rowData.push({"parameter":"执行中","value":gridData.RunningCount,"parameter_second":"Jdbc执行数","value_second":gridData.JdbcExecuteCount});
						rowData.push({"parameter":"最大并发","value":gridData.ConcurrentMax,"parameter_second":"Jdbc执行时间(毫秒)","value_second":gridData.JdbcExecuteTimeMillis});
						rowData.push({"parameter":"请求次数","value":gridData.RequestCount,"parameter_second":"读取行数","value_second":gridData.JdbcFetchRowCount});
						rowData.push({"parameter":"SessionCount","value":gridData.SessionCount,"parameter_second":"更新行数","value_second":gridData.JdbcUpdateCount});
						rowData.push({"parameter":"事务提交数","value":gridData.JdbcCommitCount.toString(),"parameter_second":"","":""});

						/*rowData.push({"parameter":"ContextPath","value":gridData.ContextPath});
							rowData.push({"parameter":"执行中","value":gridData.RunningCount});
							rowData.push({"parameter":"最大并发","value":gridData.ConcurrentMax});
							rowData.push({"parameter":"请求次数","value":gridData.RequestCount});
							rowData.push({"parameter":"SessionCount","value":gridData.SessionCount});
							rowData.push({"parameter":"事务提交数","value":gridData.JdbcCommitCount.toString()});
							rowData.push({"parameter":"事务回滚数","value":gridData.JdbcRollbackCount.toString()});
							rowData.push({"parameter":"Jdbc执行数","value":gridData.JdbcExecuteCount});
							rowData.push({"parameter":"Jdbc执行时间(毫秒)","value":gridData.JdbcExecuteTimeMillis});
							rowData.push({"parameter":"读取行数","value":gridData.JdbcFetchRowCount});
							rowData.push({"parameter":"更新行数","value":gridData.JdbcUpdateCount});
							rowData.push({"parameter":"OSMacOSXCount","value":gridData.OSMacOSXCount});
							rowData.push({"parameter":"OSWindowsCount","value":gridData.OSWindowsCount});
							rowData.push({"parameter":"OSLinuxCount","value":gridData.OSLinuxCount});
							rowData.push({"parameter":"OSSymbianCount","value":gridData.OSSymbianCount});
							rowData.push({"parameter":"OSFreeBSDCount","value":gridData.OSFreeBSDCount});
							rowData.push({"parameter":"OSOpenBSDCount","value":gridData.OSOpenBSDCount});
							rowData.push({"parameter":"OSAndroidCount","value":gridData.OSAndroidCount});
							rowData.push({"parameter":"OSWindows98Count","value":gridData.OSWindows98Count});
							rowData.push({"parameter":"OSWindowsXPCount","value":gridData.OSWindowsXPCount});

							rowData.push({"parameter":"OSWindows2000Count","value":gridData.OSWindows2000Count});
							rowData.push({"parameter":"OSWindowsVistaCount","value":gridData.OSWindowsVistaCount});
							rowData.push({"parameter":"OSWindows7Count","value":gridData.OSWindows7Count});
							rowData.push({"parameter":"OSAndroid15Count","value":gridData.OSAndroid15Count});
							rowData.push({"parameter":"OSAndroid16Count","value":gridData.OSAndroid16Count});
							rowData.push({"parameter":"OSAndroid20Count","value":gridData.OSAndroid20Count});
							rowData.push({"parameter":"OSAndroid21Count","value":gridData.OSAndroid21Count});
							rowData.push({"parameter":"OSAndroid22Count","value":gridData.OSAndroid22Count});
							rowData.push({"parameter":"OSAndroid23Count","value":gridData.OSAndroid23Count});
							rowData.push({"parameter":"OSAndroid30Count","value":gridData.OSAndroid30Count});
							rowData.push({"parameter":"OSAndroid31Count","value":gridData.OSAndroid31Count});
							rowData.push({"parameter":"OSAndroid32Count","value":gridData.OSAndroid32Count});
							rowData.push({"parameter":"OSAndroid40Count","value":gridData.OSAndroid40Count});
							rowData.push({"parameter":"OSLinuxUbuntuCount","value":gridData.OSLinuxUbuntuCount});
							rowData.push({"parameter":"BrowserIECount","value":gridData.BrowserIECount});
							rowData.push({"parameter":"BrowserFirefoxCount","value":gridData.BrowserFirefoxCount});
							rowData.push({"parameter":"BrowserChromeCount","value":gridData.BrowserChromeCount});
							rowData.push({"parameter":"BrowserSafariCount","value":gridData.BrowserSafariCount});
							rowData.push({"parameter":"BrowserOperaCount","value":gridData.BrowserOperaCount});
							rowData.push({"parameter":"BrowserIE5Count","value":gridData.BrowserIE5Count});
							rowData.push({"parameter":"BrowserIE6Count","value":gridData.BrowserIE6Count});
							rowData.push({"parameter":"BrowserIE7Count","value":gridData.BrowserIE7Count});
							rowData.push({"parameter":"BrowserIE8Count","value":gridData.BrowserIE8Count});
							rowData.push({"parameter":"BrowserIE9Count","value":gridData.BrowserIE9Count});
							rowData.push({"parameter":"BrowserIE10Count","value":gridData.BrowserIE10Count});
							rowData.push({"parameter":"Browser360SECount","value":gridData.Browser360SECount});
							rowData.push({"parameter":"DeviceAndroidCount","value":gridData.DeviceAndroidCount});
							rowData.push({"parameter":"DeviceIpadCount","value":gridData.DeviceIpadCount});
							rowData.push({"parameter":"DeviceIphoneCount","value":gridData.DeviceIphoneCount});
							rowData.push({"parameter":"DeviceWindowsPhoneCount","value":gridData.DeviceWindowsPhoneCount});
							rowData.push({"parameter":"BotCount","value":gridData.BotCount});
							rowData.push({"parameter":"BotBaiduCount","value":gridData.BotBaiduCount});
							rowData.push({"parameter":"BotYoudaoCount","value":gridData.BotYoudaoCount});
							rowData.push({"parameter":"BotGoogleCount","value":gridData.BotGoogleCount});
							rowData.push({"parameter":"BotMsnCount","value":gridData.BotMsnCount});
							rowData.push({"parameter":"BotBingCount","value":gridData.BotBingCount});
							rowData.push({"parameter":"BotSosoCount","value":gridData.BotSosoCount});
							rowData.push({"parameter":"BotSogouCount","value":gridData.BotSogouCount});
							rowData.push({"parameter":"BotYahooCount","value":gridData.BotYahooCount});*/
					}			
				}else{
					rowData=[];
				}
				//初始化web监控页面的表格
				Grid($.extend(webGridBaseConfig, {
					data:rowData
				}));
			}
		})
	}


	/**
	 * uri页面的基本配置(已经改为service页面)
	 */
	var uriGridBaseConfig={
			id:"monitor_tab_URI",
			//tableBodyHeight:"400px",
			pageSize:10,    
			//index:true,
			pagination:true,
			cache:false,
			nowrap:false,
			layout:[
			        {name:"服务名称 (时间单位为毫秒)",sort:true,field:"uri",width:"48%",click:function(e){
			        	on_btn_service_click(e.data.row);
			        }},
			        {name:"请求次数",sort:true,field:"RequestCount",width:"12%"},
			        {name:"平均请求时间",sort:true,field:"AveRequestTimeMillis",width:"18%"},
			        {name:"jdbc平均执行时间",sort:true,field:"AveJdbcTimeMillis",width:"22%"},
			        //{name:"请求时间",sort:true,field:"RequestTimeMillis",width:"12%"},
			        // {name:"执行",field:"RunningCount"},
			        // {name:"最大并发",field:"ConcurrentMax"},
			        {name:"jdbc执行数",sort:true,field:"JdbcExecuteCount",width:"18%"},
			        // {name:"jdbc出错数",field:"JdbcExecErrorCount"},
			        //{name:"jdbc执行时间",sort:true,field:"JdbcExecuteTimeMillis",width:"18%"},
			        // {name:"事务提交数",field:"CommitCount"},
			        // {name:"事务回滚数",field:"RollbackCount"},
			        //{name:"读取行数",field:"FetchRowCount"},
			        //{name:"更新行数",field:"UpdateCount"}
			        ],
			 data:[],
			 trEvent:[{type:"click",callback:function(e){
				 	
		        	on_btn_service_click(e.data.row);
		        }
		        }]
	}


	/**
	 * service(原URI监控)监控页面单击行事件
	 */
	function on_btn_service_click(row){
		Util.slidebar({
			url:path + "/views/dbMonitorService.html",
			width:"500px",
			close:true,
			afterLoad : function() {
				$("#service_Name").text(row.uri);
				$("#service_requestCount").val(row.RequestCount);
				//$("#service_requestTime").val(row.RequestTimeMillis);
				$("#service_AveRequestTimeMillis").val(row.AveRequestTimeMillis);
				$("#service_lastAccessTime").val(row.LastAccessTime);
				$("#service_inExe").val(row.RunningCount);
				$("#service_maxConcurrent").val(row.ConcurrentMax)
				$("#service_jdbcPeak").val(row.JdbcExecutePeak);
				$("#service_jdbcCount").val(row.JdbcExecuteCount);
				$("#service_jdbcErrorCount").val(row.JdbcExecuteErrorCount);
				//$("#service_jdbcTime").val(row.JdbcExecuteTimeMillis);
				$("#service_AvejdbcTime").val(row.AveJdbcTimeMillis);
				$("#service_commitCount").val(row.JdbcCommitCount);
				
				$("#service_rollTransactionCount").val(row.JdbcRollbackCount);
				$("#service_readLines").val(row.JdbcFetchRowCount);
				$("#service_jdbcSelectPeak").val(row.JdbcFetchRowPeak);
				
				
				$("#service_updateLines").val(row.JdbcUpdateCount);
				$("#service_jdbcUpdatePeak").val(row.JdbcUpdatePeak);
				$("#service_jdbcPoolConnectionOpenCount").val(row.JdbcPoolConnectionOpenCount);
				
				$("#service_jdbcPoolConnectionCloseCount").val(row.JdbcPoolConnectionCloseCount);
				$("#service_jdbcResultSetOpenCount").val(row.JdbcResultSetOpenCount);
				$("#service_jdbcResultSetCloseCount").val(row.JdbcResultSetCloseCount);
				
				
				
				$(":input").prop("readonly",true);

			}
		});
	}

	
	
	
	/**
	 * URI监控页面显示(改为service监控页面)
	 */
	function iniURI(){
		var rowData=[];
		$.ajax({
			url:getServer() + "/sword/monitor/dbmonitor/uriDataDetailFront",
//			data:{SwordControllerName:"DBmonitorSwordController"},
			success:function(data){
				if(data.status=="success"){
					var gridData = data.data.Content;
					if(gridData!=null){
						for(var i = 0,dir;dir = gridData[i++];){
							rowData.push({"uri":dir.URI,
								"RequestCount":dir.RequestCount.toString(),
								"RequestTimeMillis":dir.RequestTimeMillis.toString(),
								"LastAccessTime":dir.LastAccessTime,
								"ErrorCount":dir.ErrorCount.toString(),
								"RunningCount":dir.RunningCount.toString(),
								"ConcurrentMax":dir.ConcurrentMax.toString(),
								"JdbcExecuteCount":dir.JdbcExecuteCount.toString(),
								"JdbcExecuteTimeMillis":dir.JdbcExecuteTimeMillis.toString(),
								"JdbcExecuteErrorCount":dir.JdbcExecuteErrorCount.toString(),
								"JdbcCommitCount":dir.JdbcCommitCount.toString(),
								"JdbcRollbackCount":dir.JdbcRollbackCount.toString(),
								"JdbcFetchRowCount":dir.JdbcFetchRowCount.toString(),
								"JdbcFetchRowPeak":dir.JdbcFetchRowPeak.toString(),
								"JdbcUpdateCount":dir.JdbcUpdateCount.toString(),
								"JdbcExecutePeak":dir.JdbcExecutePeak.toString(),
								"JdbcUpdatePeak":dir.JdbcUpdatePeak.toString(),
								"JdbcPoolConnectionOpenCount":dir.JdbcPoolConnectionOpenCount.toString(),
								"JdbcPoolConnectionCloseCount":dir.JdbcPoolConnectionCloseCount.toString(),
								"JdbcResultSetOpenCount":dir.JdbcResultSetOpenCount.toString(),
								"JdbcResultSetCloseCount":dir.JdbcResultSetCloseCount.toString(),
								"AveRequestTimeMillis":dir.AveRequestTimeMillis.toString(),
								"AveJdbcTimeMillis":dir.AveJdbcTimeMillis.toString(),

							});
						}

					}			
				}else{
					rowData=[];
				}
				//初始化uri监控页面的表格
				Grid($.extend(uriGridBaseConfig, {
					data:rowData
				}));
			}

		})
	}

	/**
	 * session页面的基本配置
	 */
	var sessionGridBaseConfig={
			id:"monitor_tab_Session",
			//tableBodyHeight:"400px",
			pageSize:10,
			index:true,
			pagination:true,
			cache:false,
			nowrap:false,
			layout:[
			        {name:"SESSIONID",field:"Sessionid",width:"30%"},
			        // {name:"Principal",field:"Principal"},
			        {name:"创建时间",field:"CreateTime"},
			        {name:"最后访问时间",field:"LastAccessTime"},
			        {name:"访问ip地址",field:"RemoteAddress"},
			        {name:"请求次数",field:"RequestCount"},
			        {name:"总共请求时间(毫秒)",field:"RequestTimeMillisTotal"},
			        //{name:"执行中",field:"JRunningCount"},
			        //{name:"最大并发",field:"ConcurrentMax"},
			        //  {name:"jdbc执行数",field:"JdbcExecuteCount"},
			        //  {name:"jdbc执行时间(毫秒)",field:"JdbcExecuteTimeMillis"},
			        //  {name:"事务提交数",field:"JdbcCommitCount"},
			        //  {name:"事务回滚数",field:"JdbcRollbackCount"},
			        // {name:"读取行数",field:"JdbcFetchRowCount"},
			        // {name:"更新行数",field:"JdbcUpdateCount"},
			        ],
			        data:[]
	}


	/**
	 * session监控页面显示
	 */
	function iniSession(){
		var rowData=[];
		$.ajax({
			url:getServer() + "/sword/monitor/dbmonitor/sessionDataDetailFront",
//			data:{SwordControllerName:"DBmonitorSwordController"},
			success:function(data){
				if(data.status=="success"){
					var gridData = data.data.Content;
					if(gridData!=null){
						for(var i = 0,dir;dir = gridData[i++];){
							rowData.push({"Sessionid":dir.SESSIONID,/*"Principal":dir.Principal,*/"CreateTime":dir.CreateTime,"LastAccessTime":dir.LastAccessTime,
								"RemoteAddress":dir.RemoteAddress,"RequestCount":dir.RequestCount,
								"RequestTimeMillisTotal":dir.RequestTimeMillisTotal/*,"JRunningCount":dir.RunningCount,"ConcurrentMax":dir.ConcurrentMax,"JdbcExecuteCount":dir.JdbcExecuteCount,
								"JdbcExecuteTimeMillis":dir.JdbcExecuteTimeMillis,"JdbcCommitCount":dir.JdbcCommitCount,
								"JdbcRollbackCount":dir.JdbcRollbackCount,"JdbcFetchRowCount":dir.JdbcFetchRowCount,
								"JdbcUpdateCount":dir.JdbcUpdateCount*/
							});
						}

					}			
				}else{
					rowData=[];
				}
				//初始化uri监控页面的表格
				Grid($.extend(sessionGridBaseConfig, {
					data:rowData
				}));
			}

		})
	}






	/**
	 * 整个持久层监控模块的初始化
	 */
	function initProcess() {
		
//		$( "#monitor_toggle" ).click(function() {     
//			   $('#monitor_left_dataSource').toggle();
//			});
		/*
		 * 初始化首页的表格
		 */
	//	Grid(homePageGridBaseConfig);
		loadHomePageGrid();		
		iniDataSource();

		iniDataSql();
		initWebApp();
		iniURI();
		
		//iniSession()
	}



	return {
		init : initProcess

	}
});