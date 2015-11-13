define(
		[ "PDUtilDir/util", "PDUtilDir/tool", "PDUtilDir/grid",
				"PDUtilDir/inputSelect", "PDUtilDir/org/orgSelect", "jquery",
				"Date", "DateCN", "css!DateCss", "Echarts", "ZTree",
				"css!ZTreeCss" ],
		function(Util, Tool, Grid, inputSelect, orgUtil) {

			/**
			 * 定义全局变量：流程分类ID，统计年度
			 */
			var globalProcDirId = null;
			var globalDateTime = null;

			/**
			 * 定义各种组件的初始化逻辑
			 */
			// 初始化流程分类树
			var initProcessDirData = function() {

				$.ajax({
					url : getServer()
							+ "/sword/wfm/efficiency/loadProcDirTreeData",
					dataType : "json",
					data : {

					},
					success : function(data) {
						inputSelect({
							id : "eficiencyAnalizedProcessType",
							key : {
								id : "id",
								name : "name",
								pid : "parentId",
								rootId : null
							},
							data : data.allDatas,
							simpleData : true,
							initData : [ data.initData ],
							// 启用文本搜索
							searchAble : true,
							// 选择之后回调方法：id，选择的id数组，data，选择的数据数组
							callback : function(id, data) {
								globalProcDirId = data[0].id;
								loadProcDefTree(globalProcDirId);
								reloadAllData();
							}
						});
						// 第一次初始化，没有点击事件的时候
						globalProcDirId = data.initData;
						loadProcDefTree(data.initData);
						reloadAllData();
					}
				});
			};

			// 初始化 统计年度为当前年度。
			var initDateYear = function() {
				// 初始化查询开始时间日期组件
				var myDate = new Date();
				globalDateTime = myDate.getFullYear();
				$("#eficiencyAnalizedYear").val(globalDateTime);
				var datePicker = $("#eficiencyAnalizedYear").datetimepicker({
					language : "cn",
					// 输出格式化
					format : 'yyyy',
					todayBtn : false,
					// 设置最精确的时间选择视图
					startView : 'decade',
					minView : 'decade',
					todayHighlight : true,
					// 显示“上午”“下午”
					showMeridian : false,
					autoclose : true
				});

				datePicker.on("changeYear", function(ev) {
					globalDateTime = ev.date.getFullYear();
					reloadAllData();
				});
			};

			/*
			 * 重新查询所有图表，必须确保流程分类和统计年度都已经选中值，所以这个函数只能由流程分类和统计年度的 change事件触发
			 */
			var reloadAllData = function() {
				if (!globalDateTime || !globalProcDirId) {
					return;
				}
				reloadProcessCountChart(globalDateTime, globalProcDirId);
				reloadProcessCosumeTimeTrendChart(globalDateTime,
						globalProcDirId);
				reloadProcessStatusRatioChart(globalDateTime, globalProcDirId);
				reloadProcessDataGrid(globalDateTime, globalProcDirId);

			};

			/**
			 * 以下为所有加载图形数据的方法，每个图形分成两部分
			 */
			/*
			 * 初始化 流程次数对比组件实例
			 */
			var processCountContrastChart = echarts
					.init($("#processCountContrast")[0]);
			/*
			 * 加载 流程发起结束次数对比数据
			 */
			var reloadProcessCountChart = function(date, proDirId) {

				$
						.ajax({
							url : getServer()
									+ "/sword/wfm/efficiency/loadProcessCountChartData",
							dataType : "json",
							data : {
								dateTime : date,
								proDirId : proDirId
							},
							success : function(data) {

								var option = {
									title : {
										text : date + '年度各月流程发起量和结束量（个）'

									},
									tooltip : {
										trigger : 'axis'
									},
									legend : {
										y : 'bottom',
										data : [ '发起数量', '完成数量' ]
									},
									toolbox : {
										show : true,
										feature : {
											dataView : {
												show : true,
												title : "指标说明",
												readOnly : true,
												optionToContent : function() {
													return " 1. 按月统计各个月发起流程的数量和结束流程的数量。   \n"
															+ " 2. 因存在跨月流程，所以各月流程发起量不一定等于结束量。 \n"
															+ " 3. 因存在跨年流程，全年流程发起总量不一定等于全年流程结束总量。\n"
															+ " 4. 在发起量和结束量的折线上会标记出最大值和最小值两个点。\n"
															+ " 5. 以虚线的形式展现流程发起量和结束量的平均值。";
												},
												lang : [ '指标说明：', '返回图示' ]
											},
											saveAsImage : {
												show : true
											}
										}
									},
									// 是否允许拖拽重新计算
									calculable : false,
									xAxis : [ {
										type : 'category',
										boundaryGap : false,
										data : data.timeList
									} ],
									yAxis : [ {
										type : 'value',
									} ],
									series : [ {
										name : '发起数量',
										type : 'line',
										data : data.createCountList,
										markPoint : {
											data : [ {
												type : 'max',
												name : '最大值'
											}, {
												type : 'min',
												name : '最小值'
											} ]
										},
										markLine : {
											data : [ {
												type : 'average',
												name : '平均值'
											} ]
										}
									}, {
										name : '完成数量',
										type : 'line',
										data : data.completeCountList,
										markPoint : {
											data : [ {
												type : 'max',
												name : '最大值'
											}, {
												type : 'min',
												name : '最小值'
											} ]
										},
										markLine : {
											data : [ {
												type : 'average',
												name : '平均值'
											} ]
										}
									} ]
								};

								processCountContrastChart.setOption(option,
										true);
							}
						});

			};

			/*
			 * 初始化 流程状态比例图 组件实例
			 */
			var processStatusRatioChart = echarts
					.init($("#processStatusRatio")[0]);
			/*
			 * 加载 流程状态比例图 数据
			 */
			var reloadProcessStatusRatioChart = function(date, proDirId) {
				$
						.ajax({
							url : getServer()
									+ "/sword/wfm/efficiency/loadProcessStatusRatioChartData",
							dataType : "json",
							data : {
								dateTime : date,
								proDirId : proDirId
							},
							success : function(data) {

								var option = {
									title : {
										text : date + '年度流程结束量与未结束量的比例'
									},
									tooltip : {
										trigger : 'item',
										formatter : "{a} <br/>{b} : {c} ({d}%)"
									},
									legend : {
										orient : 'horizontal',
										y : 'bottom',
										data : [ '已结束', '未结束', '运行中', '挂起',
												'已完成', '已作废', '已终止' ]
									},
									toolbox : {
										show : true,
										feature : {
											dataView : {
												show : true,
												title : "指标说明",
												readOnly : true,
												optionToContent : function() {
													return " 1. 统计范围是在选择的统计周期内发起的流程数量。   \n"
															+ " 2. 内部饼图是这些流程当前时刻已经结束和未结束的比例。 \n"
															+ " 3. 外部圆环是这些流程当前时刻各种状态的比例。 \n"
															+ " 4. '未结束' 状态包含：'运行中','挂起'。\n"
															+ " 5. '已结束' 状态包括：'已完成','已终止','已作废'。\n"
															+ " 6. 百分比计算到小数点后两位。";
												},
												lang : [ '指标说明：', '返回图示' ]
											},
											saveAsImage : {
												show : true
											}
										}
									},
									calculable : false,
									series : [
											{
												name : '流程比例',
												type : 'pie',
												radius : [ '40%', '60%' ],
												center : [ '50%', '50%' ],
												itemStyle : {
													normal : {
														label : {
															position : 'outer',
															formatter : "{b}: {c}({d}%)"
														}
													}

												},
												data : [ {
													value : data.running,
													name : '运行中'
												}, {
													value : data.suspended,
													name : '挂起'
												}, {
													value : data.completed,
													name : '已完成'
												}, {
													value : data.aborted,
													name : '已作废'
												}, {
													value : data.terminated,
													name : '已终止'
												} ]
											},
											{
												name : '流程比例',
												type : 'pie',
												radius : '35%',
												center : [ '50%', '50%' ],
												itemStyle : {
													normal : {
														label : {
															position : 'inner',
															formatter : "{b}\n {c}({d}%)"
														},
														labelLine : {
															show : false
														}
													}

												},
												data : [ {
													value : data.open,
													name : '未结束'
												}, {
													value : data.closed,
													name : '已结束'
												} ]
											} ]
								};

								processStatusRatioChart.setOption(option, true);
							}
						});
			};

			/*
			 * 初始化 各月流程耗时 趋势图 组件实例
			 */
			var processCosumeTimeTrendChart = echarts
					.init($("#processCosumeTimeTrend")[0]);
			/*
			 * 加载 各月流程耗时 趋势图 数据
			 */
			var reloadProcessCosumeTimeTrendChart = function(date, proDirId) {

				$
						.ajax({
							url : getServer()
									+ "/sword/wfm/efficiency/loadProcessCosumeTimeTrendChartData",
							dataType : "json",
							data : {
								dateTime : date,
								proDirId : proDirId
							},
							success : function(data) {

								var option = {
									title : {
										text : date + '年度各月已完成流程平均耗时（分钟）'

									},
									tooltip : {
										trigger : 'axis'
									},
									toolbox : {
										show : true,
										feature : {
											dataView : {
												show : true,
												title : "指标说明",
												readOnly : true,
												optionToContent : function() {
													return " 1. 统计结束时间在某月的流程平均处理耗时。   \n"
															+ " 2. 处理耗时为从流程发起到流程结束的绝对时长，未剔除非工作时间。 \n";
												},
												lang : [ '指标说明：', '返回图示' ]
											},
											saveAsImage : {
												show : true
											}
										}
									},
									// 是否允许拖拽重新计算
									calculable : false,
									xAxis : [ {
										type : 'category',
										boundaryGap : false,
										data : data.timeList
									} ],
									yAxis : [ {
										type : 'value',
										axisLabel : {
											formatter : '{value} 分钟'
										}
									} ],
									series : [ {
										name : '流程耗时',
										type : 'line',
										data : data.processCosumeTimeList,
										markPoint : {
											data : [ {
												type : 'max',
												name : '最大值'
											}, {
												type : 'min',
												name : '最小值'
											} ]
										},
										markLine : {
											data : [ {
												type : 'average',
												name : '平均值'
											} ]
										}
									} ]
								};

								processCosumeTimeTrendChart.setOption(option,
										true);
							}
						});

			};

			/*
			 * 加载 流程整体数据监控统计 表格
			 */
			var reloadProcessDataGrid = function(date, proDirId) {
				$.ajax({
					url : getServer()
							+ "/sword/wfm/efficiency/loadProcessGridData",
					dataType : "json",
					data : {
						dateTime : date,
						proDirId : proDirId
					},
					success : function(data) {

						Grid({
							id : "processDataGrid",
							title : date + '年度流程整体数据监控统计',
							index : false,
							pagination : false,
							cache : false,
							layout : [ {
								name : "统计指标",
								field : "name"

							}, {
								name : "数量",
								field : "value",
								sort : false
							} ],
							data : data.allData
						});
					}
				});
			};

			/**
			 * 根据流程分类ID，加载这个分类以及子分类下所有的流程定义数据
			 */
			/**
			 * 定义流程定义树的配置项
			 */
			var procDefTreeSetting = {
				data : {
					key : {
						name : "name"
					},
					simpleData : {
						enable : true,
						idKey : "id",
						pIdKey : "parentId",
						rootPid : null
					}

				},
				view : {
					showLine : true
				},
				callback : {
					onClick : function(event, treeId, treeNode, clickFlag) {
						// var dataTime = $( "#eficiencyAnalizedYear").val();
						reloadActivityConsumeTimeChart(globalDateTime,
								treeNode.id,treeNode.name);
						reloadUserActivityDataGrid(globalDateTime, treeNode.id,
								treeNode.name);

					}
				}

			};
			var loadProcDefTree = function(procDicId) {
				$.ajax({
					url : getServer()
							+ "/sword/wfm/efficiency/loadProcDefListByDic",
					dataType : "json",
					data : {
						procDicId : procDicId
					},
					success : function(data) {

						// 初始化
						$.fn.zTree.init($("#processDefTreeDiv"),
								procDefTreeSetting, data.procDefList);

						// 展开所有
						$.fn.zTree.getZTreeObj("processDefTreeDiv").expandAll(
								true);
					}
				});
			};

			/**
			 * 加载 一个流程定义全部环节 耗时 数据，由流程定义树 点击触发
			 */
			
			var reloadActivityConsumeTimeChart = function(dateTime, proDefId,proDefName) {
				var activityIdList = null;
				var activityConsumeTimeChart = echarts
						.init($("#activityConsumeTime")[0]);
				activityConsumeTimeChart.on('click',
						function(event) {
							var actIndex = event.dataIndex;
							var actId = activityIdList[actIndex];
							var actName = event.name;
							reloadOneActivityTimeRatioChart(dateTime, proDefId,
									actId, actName);
							reloadOneActivityTrendChart(dateTime, proDefId, actId,
									actName);
						});
				$
						.ajax({
							url : getServer()
									+ "/sword/wfm/efficiency/loadActivityCosumeTimeChartData",
							dataType : "json",
							data : {
								proDefId : proDefId,
								dateTime : dateTime
							},
							success : function(data) {
								activityIdList = data.activityIdList;
								var option = {
									title : {
										text : proDefName + '-各环节耗时（分钟）'
									},
									tooltip : {
										trigger : 'axis',
										axisPointer : { // 坐标轴指示器，坐标轴触发有效
											type : 'shadow' // 默认为直线，可选为：'line'
										// | 'shadow'
										}
									},
									legend : {
										orient : 'horizontal',
										y : 'bottom',
										data : [ '完整用时', '办理时长', '闲置时长' ]
									},
									toolbox : {
										show : true,
										feature : {
											dataView : {
												show : true,
												title : "指标说明",
												readOnly : true, 
												optionToContent : function() {
													return " 1. 使用三条曲线面积图描述一个流程流转过程中每个环节的办理时长。   \n"
															+ " 2. 完整用时：表示从环节发起到环节完成的绝对时长。 \n"
															+ " 3. 办理时长：表示从办理人员签收开始到提交任务的绝对时长。 \n"
															+ " 4. 闲置时长：表示从环节发起到办理人员签收之间的绝对时长。 \n"
															+ " 5. 图形从左到右，以环节的完整用时递减排序。 \n"
															+ " 6. 统计范围是环节的完成时间在当前所选统计年度。 \n"
															+ " 7. 操作提示： 左键单击曲线上的点可以显示这个环节的详细信息。";
												},
												lang : [ '指标说明：', '返回图示' ]
											},
											saveAsImage : {
												show : true
											}
										}
									},
									// calculable : true,
									xAxis : [ {
										type : 'category',
										data : data.activityNameList
									} ],
									yAxis : [ {
										type : 'value'
									} ],
									series : [ {
										name : '办理时长',
										type : 'line',
										stack : '耗时',
										smooth : true,
										itemStyle : {
											normal : {
												areaStyle : {
													type : 'default'
												}
											}
										},
										data : data.cosumeTimeList
									}, {
										name : '闲置时长',
										type : 'line',
										stack : '耗时',
										smooth : true,
										itemStyle : {
											normal : {
												areaStyle : {
													type : 'default'
												}
											}
										},
										data : data.freeTimeList
									}, {
										name : '完整用时',
										type : 'line',
										smooth : true,
										itemStyle : {
											normal : {
												areaStyle : {
													type : 'default'
												}
											}
										},
										data : data.allTimeList
									}

									]
								};

								activityConsumeTimeChart
										.setOption(option, true);
							}
						});
			};
			/**
			 * 一个流程定义的某一个环节的 时间比例图
			 */
			var reloadOneActivityTimeRatioChart = function(dateTime, proDefId,
					actId, actName) {
				var activityTimeRatioChart = echarts
						.init($("#oneActivityTimeRatio")[0]);
				$
						.ajax({
							url : getServer()
									+ "/sword/wfm/efficiency/loadOneActivityTimeRatioChartData",
							dataType : "json",
							data : {
								dateTime : dateTime,
								proDefId : proDefId,
								activityDefId : actId
							},
							success : function(data) {

								var option = {
									title : {
										text : actName + '-时间比例图'
									},
									tooltip : {
										trigger : 'item',
										formatter : "{b} <br/> {c} ({d}%)"
									},
									legend : {
										orient : 'horizontal',
										y : 'bottom',
										data : [ '办理时长', '闲置工作时长', "闲置非工作时长" ]
									},
									toolbox : {
										show : true,
										feature : {
											dataView : {
												show : true,
												title : "指标说明",
												readOnly : true, 
												optionToContent : function() {
													return " 1. 统计范围为选中周期内完成的所有环节。   \n"
															+ " 2. 每个环节的完整用时 = 办理时长 + 闲置时长（工作时长 + 非工作时长） \n";
												},
												lang : [ '指标说明：', '返回图示' ]
											},
											saveAsImage : {
												show : true
											}
										}
									},
									calculable : false,
									series : [ {
										name : '耗时比例',
										type : 'pie',
										radius : '80%',
										center : [ '55%', '50%' ],
										itemStyle : {
											normal : {
												label : {
													position : 'inner',
													formatter : "{b}\n ({d}%)"
												},
												labelLine : {
													show : false
												}
											}

										},
										data : [ {
											value : data.consumeTime,
											name : '办理时长'
										}, {
											value : data.freeTime,
											name : '闲置工作时长'
										}, {
											value : data.notworkTime,
											name : '闲置非工作时长'
										} ]
									} ]
								};

								activityTimeRatioChart.setOption(option, true);
							}
						});
			};
			/**
			 * 加载单个环节 按月统计的时间趋势图
			 */
			var reloadOneActivityTrendChart = function(dateTime, proDefId,
					actId, actName) {
				var oneActivityTrendChart = echarts
						.init($("#oneActivityTrend")[0]);
				$
						.ajax({
							url : getServer()
									+ "/sword/wfm/efficiency/loadOneActivityTrendChartData",
							dataType : "json",
							data : {
								dateTime : dateTime,
								proDefId : proDefId,
								activityDefId : actId
							},
							success : function(data) {

								option = {
									title : {
										text : actName + '-办理时间趋势图'
									},
									tooltip : {
										trigger : 'axis'
									},
									toolbox : {
										show : true,
										feature : {
											dataView : {
												show : true,
												title : "指标说明",
												readOnly : true, 
												optionToContent : function() {
													return " 1. 统计范围为选中周期内完成的所有环节。   \n"
															+ " 2. 此图的平均耗时为完整用时的平均值。 \n"
															+ " 3. 此图的办理人次为 完成次数。";
												},
												lang : [ '指标说明：', '返回图示' ]
											},
											saveAsImage : {
												show : true
											}
										}
									},
									calculable : false,
									legend : {
										orient : 'horizontal',
										y : 'bottom',
										data : [ '平均耗时', '办理人次' ]
									},
									xAxis : [ {
										type : 'category',
										data : data.timeList
									} ],
									yAxis : [ {
										type : 'value',
										name : '办理耗时',
										axisLabel : {
											formatter : '{value} 分钟'
										}
									}, {
										type : 'value',
										name : '人次'

									} ],
									series : [

									{
										name : '办理人次',
										type : 'bar',
										yAxisIndex : 1,
										data : data.actInstCountList
									}, {
										name : '平均耗时',
										type : 'line',
										data : data.totelTimeList
									} ]
								};

								oneActivityTrendChart.setOption(option, true);
							}
						});
			};
			
			/**
			 * 加载一个流程所有环节所有人办理明细数据列表
			 */
			var reloadUserActivityDataGrid = function(dateTime, proDefId,
					proDefName) {
				$.ajax({
					url : getServer()
							+ "/sword/wfm/efficiency/loadUserActivityGridData",
					dataType : "json",
					data : {
						dateTime : dateTime,
						proDefId : proDefId,
					},
					success : function(data) {

						Grid({
							id : "userActivityDataGrid",
							title : dateTime + '年度' + proDefName + '-所有环节详细数据',
							index : false,
							pagination : true,
							pageSize : 6,
							cache : false,
							layout : [
									{
										name : "环节ID",
										field : "actDefId"

									},
									{
										name : "环节名称",
										field : "actDefName"
									},
									{
										name : "用户名称",
										field : "userName"

									},
									{
										name : "处理人次/年",
										field : "workItemCount"
									},
									{
										name : "平均处理时间（分钟）",
										field : "avgConsumeTime",
										click : function(e) {
											reloadOneUserActivityTrendChart(
													e.data.row.actDefName,
													e.data.row.userName,
													dateTime,
													e.data.row.userId,
													proDefId, e.data.row.actDefId);
										}
									} ],
							data : data.allData
						});
					}
				});
			};
			
			/**
			 * 加载一个用户在一个环节的办理时间趋势图，此函数由表格单击事件触发
			 */
			var reloadOneUserActivityTrendChart = function(activityDefName,
					userName, dateTime, userId, proDefId, actDefId) {
				var oneUserActivityTrendChart = echarts
						.init($("#oneUserActivityTrend")[0]);
				$
						.ajax({
							url : getServer()
									+ "/sword/wfm/efficiency/loadOneUserActivityTrendChartData",
							dataType : "json",
							data : {
								dateTime : dateTime,
								userId : userId,
								proDefId : proDefId,
								actDefId : actDefId
							},
							success : function(data) {

								option = {
									title : {
										text : userName + '-' + activityDefName
												+ '-时间趋势图'
									},
									tooltip : {
										trigger : 'axis'
									},
									toolbox : {
										show : true,
										feature : {
											dataView : {
												show : true,
												title : "指标说明",
												readOnly : true, 
												optionToContent : function() {
													return " 1. 按照任务完成的日期统计月份。  \n"
															+ " 2. 同一个流程实例同一个人办理多次则计数统计多次。 \n"
															+ " 3. 耗时为任务完整用时，即从任务发起时间到任务结束时间的绝对时长。";
												},
												lang : [ '指标说明：', '返回图示' ]
											},
											saveAsImage : {
												show : true
											}
										}
									},
									calculable : false,
									legend : {
										orient : 'horizontal',
										y : 'bottom',
										data : [ '平均耗时', '办理次数' ]
									},
									xAxis : [ {
										type : 'category',
										data : data.timeList
									} ],
									yAxis : [ {
										type : 'value',
										name : '办理耗时',
										axisLabel : {
											formatter : '{value} 分钟'
										}
									}, {
										type : 'value',
										name : '人次'

									} ],
									series : [

									{
										name : '办理次数',
										type : 'bar',
										yAxisIndex : 1,
										data : data.workItemCountList
									}, {
										name : '平均耗时',
										type : 'line',
										data : data.avgConsumeTimeList
									} ]
								};

								oneUserActivityTrendChart.setOption(option,
										true);
							}
						});
			};
			
			
			/*
			 * 绑定用户选择事件
			 */
			orgUtil.CS_OrgSelect({
				id : "btn_userSearch",
				multi : false,
				title : "人员选择",
				tagData : [ "user" ],
				callback : function(data) {
					var allUsers = data.user;
					
					var userId = allUsers[0].userUuid;
					var msg = "您选择了："+allUsers[0].userName;

					$('#input_userSelect').val(msg);
					
					reloadUserProcessDataGrid(globalDateTime, globalProcDirId, userId);
				}
			});
			
			/**
			 * 处理人效率监控 - 单个人员所有流程明细表格数据
			 */
			var reloadUserProcessDataGrid = function(dateTime, proDirId,
					userID) {
				$.ajax({
					url : getServer()
							+ "/sword/wfm/efficiency/loadUserProcessGridData",
					dataType : "json",
					data : {
						dateTime : dateTime,
						proDirId : proDirId,
						userID : userID
					},
					success : function(data) {

						Grid({
							id : "userProcessDataGrid",
							title : dateTime+'年度已结束任务详细数据',
							index : false,
							pagination : false,
							pageSize : 5,
							cache : false,
							layout : [
									{
										name : "流程ID",
										field : "proDefId"

									},
									{
										name : "流程名称",
										field : "proDefName"
									},
									{
										name : "用户名称",
										field : "userName"
									},
									{
										name : "处理人次/年",
										field : "workItemCount"
									},
									{
										name : "平均处理时间（分钟）",
										field : "avgConsumeTime",
										click : function(e) {

											reloadOneUserProcessTrendChart(
													dateTime,
													e.data.row.proDefId,
													e.data.row.proDefName,
													e.data.row.userId,
													e.data.row.userName);

										}
									} ],
							data : data.allData
						});
					}
				});
			};
			
			/**
			 * 加载一个用户一个流程 的办理次数和用时  趋势图
			 */
			var reloadOneUserProcessTrendChart = function(dateTime, procDefId,
					procDefName, userId, userName) {
				var oneUserProcessTrendChart = echarts
						.init($("#oneUserProcessTrend")[0]);
				$
						.ajax({
							url : getServer()
									+ "/sword/wfm/efficiency/loadOneUserProcessTrendChartData",
							dataType : "json",
							data : {
								dateTime : dateTime,
								procDefId : procDefId,
								userId : userId
							},
							success : function(data) {

								option = {
									title : {
										text : userName + '-' + procDefName
												+ '-办理次数和用时趋势图'
									},
									tooltip : {
										trigger : 'axis'
									},
									toolbox : {
										show : true,
										feature : {
											dataView : {
												show : true,
												title : "指标说明",
												readOnly : true, 
												optionToContent : function() {
													return " 1. 按照任务完成的日期统计月份。  \n"
													+ " 2. 同一个流程实例同一个人办理多次则计数统计多次。 \n"
													+ " 3. 耗时为任务完整用时，即从任务发起时间到任务结束时间的绝对时长。";
												}
											},
											saveAsImage : {
												show : true
											}
										}
									},
									calculable : false,
									legend : {
										orient : 'horizontal',
										y : 'bottom',
										data : [ '平均耗时', '办理人次' ]
									},
									xAxis : [ {
										type : 'category',
										data : data.timeList
									} ],
									yAxis : [ {
										type : 'value',
										name : '办理耗时',
										axisLabel : {
											formatter : '{value} 分钟'
										}
									}, {
										type : 'value',
										name : '人次'

									} ],
									series : [

									{
										name : '办理人次',
										type : 'bar',
										yAxisIndex : 1,
										data : data.workItemList
									}, {
										name : '平均耗时',
										type : 'line',
										data : data.avgConsumeTimeList
									} ]
								};

								oneUserProcessTrendChart
										.setOption(option, true);
							}
						});
			};
			
			/**
			 * 绑定按钮的响应事件
			 */
			$('#initAllDataButton').click(function(event) {
				$.ajax({
					url : getServer() + "/sword/wfm/efficiency/initAllData",
					dataType : "json",
					data : {},
					success : function(data) {

					}
				});
			});

			$('#loadNewDataButton')
					.click(
							function(event) {
								$
										.ajax({
											url : getServer()
													+ "/sword/wfm/efficiency/processLastestData",
											dataType : "json",
											data : {
												dateTime : date
											},
											success : function(data) {

											}
										});
							});

			$('#refreshETLStatus')
					.click(
							function(event) {
								$
										.ajax({
											url : getServer()
													+ "/sword/wfm/efficiency/getEfficiencyConfig",
											dataType : "json",
											data : {

											},
											success : function(data) {

												Grid({
													id : "processEfficientyStatusGrid",
													title : '流程效率分析数据处理状态',
													index : false,
													pagination : false,
													cache : false,
													layout : [ {
														name : "状态名称",
														field : "configid"

													}, {
														name : "状态值",
														field : "configvalue"
													} ],
													data : data
												});
											}
										});
							});


			/**
			 * 初始化整个页面，设置页面各个控件的默认值，绑定响应事件
			 */
			function initAll() {
				// 1. 设置统计年度默认值为 当前年。
				initDateYear();
				// 2. 设置流程分类的默认值
				initProcessDirData();

				// 3. 对《人员选择》，《初始化数据》，《最新数据》，《刷新状态》 绑定响应事件
			}

			return {
				initAll : initAll
			}
		});