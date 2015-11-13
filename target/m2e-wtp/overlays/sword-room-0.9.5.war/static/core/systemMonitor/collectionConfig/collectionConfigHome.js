/**
 * Sword基础框架 ： sword-monitor 
 * Copyright 中国软件与技术服务股份有限公司
 */
/**
 * @功能描述 
 *  
 * 系统监控下服务器监控的实现
 * @author YaoGuanhong
 * @创建时间 2015年8月12日 上午9:23
 * @History 修订历史<br>
 * 
 */

define(["PDUtilDir/grid",
        "PDUtilDir/util", 
        "PDUtilDir/dialog",
        "PDUtilDir/tool",], 
        function(Grid, Util,Dialog,Tool){

	/**
	 * 采集全局总开关
	 * 全局默认频率为60秒 下拉框的value
	 */
	var wholeSwitch = "N";
	var wholeFrequence = 60;
	/**
	 * 路径变量
	 */
	var path = getStaticPath() + "/core/systemMonitor/collectionConfig";

	var collectionSidebar=null;
	var alarmSidebar=null;

	var _WayAndTargetModel= [];
	var _WayAndTargetModelNew= [];
	function loadGlobalSwitchAndFrequence(){
		/*
		 * 从后台数据库或缓存读取
		 * 总开关状态
		 */
		$.ajax({
			url:getServer()+"/sword/monitor/collectionConfig/getCollectionGlobalSetting",
			async:false,  
			success:function(data){
				if(data!=null){
					wholeSwitch = data.enable;
					wholeFrequence = data.freq;
				}
			}
		});
	}


	/**
	 * 绑定监控配置采集总开关 开启对话框
	 * 
	 */		
	$("#monitor_collection_switch").on("change",function(){
		var status = $(this).val();
		var contentIndialog = null;
		if(status == "Y") {
			contentIndialog = "确定开启监控采集吗?"
		}else{
			contentIndialog = "确定关闭监控采集吗?"
		}
		Util.confirm(contentIndialog,function(){
			/**
			 * 向后台请求改变总开关状态
			 */
			$.ajax({
				url:getServer()+"/sword/monitor/collectionConfig/setCollectionGlobalSetting",
				data:{freq:wholeFrequence,enable:status},
				success:function(data){
					if(data!=null&&data.status=="success"){
						if(status == "Y"){
							$("#monitor_collection_frequence").prop("disabled",false);
						}else{
							$("#monitor_collection_frequence").prop("disabled",true);
						}
						iniTable();
						wholeSwitch = status;
					}else{
						//TODO 如果后台设置不成功?
					}
				}
			});
		},function(){
			$("#monitor_collection_switch").val(wholeSwitch); 
		});		

	});

	/**
	 * 绑定监控全局采集频率  开启对话框
	 */		
	$("#monitor_collection_frequence").on("change",function(){
		if(wholeSwitch){
			var contentIndialog =$(this).find("option:selected").text();  
			var frontFreq = $(this).val();
			Util.confirm("全局采集频率修改为"+contentIndialog+"分钟?",function(){
				/**
				 * 点击确定
				 * 向后台请求修改全局频率设置
				 */
				$.ajax({
					url:getServer()+"/sword/monitor/collectionConfig/setCollectionGlobalSetting",
					data:{freq:frontFreq,enable:wholeSwitch},
					success:function(data){
						if(data!=null&&data.status=="success"){
							wholeFrequence = frontFreq;
							iniTable();
						}
					}
				});

			},function(){
				/*
				 * 点击取消
				 */
				$("#monitor_collection_frequence").val(wholeFrequence);

			});


		}
	});


	/**
	 * 刷新页面时 如果开关为关 则全局频率不可调
	 */
	function globalSwitchAndFreq(){

		if(wholeSwitch=="N"){
			$("#monitor_collection_frequence").prop("disabled",true);		
		}
		$("#monitor_collection_switch").val(wholeSwitch);
		$("#monitor_collection_frequence").val(wholeFrequence);


	}

	/**
	 * 采集列表采集信息设置响应
	 */
	function on_btn_collection_click(clickdata){
		/*
		 * 如果是主动收集信息的 则不会显示采集信息侧边栏
		 * 
		 */

		if(wholeSwitch=="Y"){

			if(clickdata.enumKey != "LOG"&&clickdata.enumKey != "SERVICE"){
				var getCollectData = clickdata; 
				collectionSidebar=Util.slidebar({
					url:path+"/views/collectionItem.html",
					width:"600px",
					close:true,
					afterLoad:function() {
						/*
						 * 以下代码需要修改 
						 * TODO 待加校验 处理全局的状况
						 */
						$("input[type='radio'][name=collection_freq][value="+getCollectData.freq+"]").attr("checked", "checked");

						$("#collection_Name").val(clickdata.desc);


						if(getCollectData.collectEnable){
							$("input[name=itemEnable][value='Y']").attr("checked",'checked');
						}else{
							$("input[name=itemEnable][value='N']").attr("checked",'checked');
						}

						$("#saveCollectionSetting").bind("click",function(){
							var collectionFreq = $("input[name=collection_freq]:checked").val();
							//如果是全局默认 则将freq设置为0 返回后台


							var collectionEnable =$("input[name=itemEnable]:checked").val();
							
							
							$.ajax({
								url:getServer()+"/sword/monitor/collectionConfig/setCollectionSetting",
								data:{name:getCollectData.enumKey,enable:collectionEnable,freq:collectionFreq,scheduleId:getCollectData.scheduleId},
								success:function(data){
									if(data!=null&&data.status=="success"){
										//整个表格更新
										//未来优化：表格的某行数据更新 TO
										iniTable();
										collectionSidebar.close();
									}
								}
							})
						})

					}
				});

			}
		}else{
			Util.alert("请先开启采集总开关","操作无效");
		}

	}



	var convertAlarmModel=function(mapModel){
		var rowData = [];
		var way;
		for(way in mapModel){
			if(way=="LOG"){
				rowData.push({"way":way,"targetList":mapModel[way],"action":""});
			}else{
				rowData.push({"way":way,"targetList":mapModel[way],"action":"删除"});
			}
		}
		return rowData ;
	};
	/*
	 * 编辑告警信息
	 */
	function on_btn_alarm_click(clickdata) {
		if(wholeSwitch=="Y"){
			var alarmData = clickdata;
			alarmSidebar=Util.slidebar({
				url:path+"/views/alarmSetting.html",
				width:"600px",
				close:true,
				afterLoad:function() {
					/**
					 * 告警条件设置下的有效告警方式的grid配置
					 */
					var way=[];
					var alarmWaysBaseConfig ={
							id:"haveWays",
							cache:false,
							pagination:false,
							nowrap:false,
							layout:[{name:"方式",field:"way",width:"75%",click:function(e){
								on_btn_way_showTatget(e.data.row);
							}},
							{name:"是否删除",field:"action",width:"25%",click:function(e){
								ob_btn_delete_way_and_target(e.data.row);
							}}
							],
							data:[]
					}
					
					
					
					
					
					$("#conditionName").html(alarmData.desc.replace("采集",""));
					$("#alarm_operator").val(alarmData.operator);
					$("#threshold").val(alarmData.threshold);
					if(alarmData.alarmEnable){
						$("input[name=alarmEnable][value='Y']").attr("checked",'checked');
					}else{
						$("input[name=alarmEnable][value='N']").attr("checked",'checked');
					}
					var rowData = [];
					_WayAndTargetModel=alarmData.alarmWayAndTargetMap;
					_WayAndTargetModelNew= JSON.parse(JSON.stringify(alarmData.alarmWayAndTargetMap));

					rowData=convertAlarmModel(alarmData.alarmWayAndTargetMap);
					/*
					 * 初始化告警方式表格
					 */
					Grid($.extend(alarmWaysBaseConfig, {
						data:rowData
					}));
					
					
					
					
					/**
					 * 添加告警方式绑定事件
					 */
					$("#setWay").bind("click",function(){
						var currentWay = $("#currentWay").val(); 
						if(!_WayAndTargetModelNew.hasOwnProperty(currentWay)){
							_WayAndTargetModelNew[currentWay]=[];
							var rowData=convertAlarmModel(_WayAndTargetModelNew);
							Grid($.extend(alarmWaysBaseConfig, {
								data:rowData
							}));
						}
					})

					/**
					 * 点击告警方式列表中的是否删除 将方式以及对应的target全部删除
					 */
					function ob_btn_delete_way_and_target(clickdata){

						var deleteWay=clickdata.way;
						if(_WayAndTargetModelNew.hasOwnProperty(deleteWay)){
							delete _WayAndTargetModelNew[deleteWay];
							var rowData=convertAlarmModel(_WayAndTargetModelNew);
							Grid($.extend(alarmWaysBaseConfig, {
								data:rowData
							}));
						}
					}
				    var targetRule = function(one,two){
				        return one.target==two.target?true:false;
				    };

					function delete_target(clickdatas){
						for(var i in clickdatas){
							var index = Tool.indexOfJsonArray({"target":clickdatas[i].target},_WayAndTargetModelNew[way],targetRule);
							_WayAndTargetModelNew[way].splice(index,1);
						}

					}
					
					/**
					 * 点击告警方式列表中的方式，展现出方式对应的所有target
					 */
					function on_btn_way_showTatget(clickData){
						if(clickData.way!="LOG"){
							way=clickData.way;
							var dialog = Dialog({
								id:"targetList",
								title:"发送对象设置",
								width:"512px",
								url:path +"/views/waySetDialog.html",
								afterLoad:function(){
									var config={
											//placeAt:"wayGrid",
											id:"wayGrid",
											multi:true,
											pageSize:5,
											layout: [{name:"联系人 ",field:"target"}],
											data:[],
											toolbar:[{
												name:"删除",
												callback:function(e){
													delete_target( Grid.getGrid("wayGrid").getSelectedRow());
													var gridData =_WayAndTargetModelNew[clickData.way];
													Grid($.extend(config, {data:gridData}));
												}
											}]
									}
									var gridData =_WayAndTargetModelNew[clickData.way];
									Grid($.extend(config, {data:gridData}));
									
									$("#addTarget").bind("click",function(){
										var input = $("#inputTarget").val();
										//手机号码以13,14,15,17,18开头的9位数
										var phoneReg = /^0?1[3|4|5|7|8][0-9]\d{8}$/;
										var mailReg = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;  
										var result=false;
										var alertMsg="";
										if(way=="MAIL"){
											result=mailReg.test(input);
											alertMsg="邮箱格式有误！";
										}else if(way=="SMS"){
											result=phoneReg.test(input);
											alertMsg="手机号码格式有误！";
										}
										if(result){
											var alarmTarget={"target":input};
											_WayAndTargetModelNew[way].push(alarmTarget);
											var gridData =_WayAndTargetModelNew[clickData.way];
											Grid($.extend(config, {data:gridData}));
										}else{
											  Util.alert(alertMsg);
										}

									})
								}
							})
						}
					}
					$("#saveAlarmSetting").bind("click",function(){
						var alarmSetting={
								"enable":$("input[name=alarmEnable]:checked").val(),
								"operator":$("#alarm_operator").val(),
								"threshold":$("#threshold").val(),
								"itemname":alarmData.enumKey};
						var data = {
								"alarmSetting":JSON.stringify(alarmSetting),
								"oldWayAndTarget":JSON.stringify(_WayAndTargetModel),
								"newWayAndTarget":JSON.stringify(_WayAndTargetModelNew),
				            };
						
						
			            $.ajax({
			            	
			                url:getServer()+"/sword/monitor/collectionConfig/saveAlarm",
			                dataType:"json",
			                data:data,
			                success:function(data){
		                        if(data.status=="success"){
		                            //刷新表格
		                        	iniTable();
		                            alarmSidebar.close();
		                            Util.alert(data.message);
		                        }
			                }
			            })
					})
				}
			})
		}else{
			Util.alert("请先开启采集总开关","操作无效");
		}
	}




	/**
	 * 告警首页页面表格配置
	 */
	var collectionConfig={
			id:"monitor_collection_table",
			pageSize:10,
			pagination:false,
			layout:[{name:"采集指标",field:"desc",width:"40%",click:function(e){
				on_btn_collection_click(e.data.row);
			}},
			{name:"采集频率(单位秒)",field:"freq",width:"25%",format:function(obj){
				var rowData=obj.row;
				if(rowData.freq==0){
					return wholeFrequence+"(全局默认)";
				}else{
					return rowData.freq;
				}
			}},
			{name:"是否开启采集",field:"collectEnableText",width:"17%"},
			{name:"是否开启告警",field:"alarmEnableText",width:"17%",click:function(e){
				on_btn_alarm_click(e.data.row);
			}},
			],
			data:[],
			trEvent:[{type:"click",callback:function(e){
				on_btn_collection_click(e.data.row);
			}}]
	}

	/**
	 * 告警首页表格初始化
	 */
	function iniTable(){
		var rowData=[];
		$.ajax({
			url:getServer() + "/sword/monitor/collectionConfig/getAllCollectionConfig",
			success:function(data){
				if(data != null && data.data!=null){
					var gridData = data.data;
					for(var i = 0,dir;dir = gridData[i++];){
						var collectionEnableText = "关闭";
						var alarmEnableText = "关闭";
						if(dir.name=="LOG"||dir.name=="SERVICE"){
							collectionEnableText=null;
							dir.freq = null;

						}else if(dir.collectEnable){
							collectionEnableText ="开启";
						} 

						if(dir.alarmEnable){
							alarmEnableText="开启";
						}
						if(dir.freq==0){
//							dir.freq = wholeFrequence;
						}

						
						
						rowData.push({"alarmEnable":dir.alarmEnable,"alarmWayAndTargetMap":dir.alarmWayAndTargetMap,"collectEnable":dir.collectEnable,
							"desc":dir.desc,"enumKey":dir.enumKey,"freq":dir.freq,"name":dir.name,"operator":dir.operator,"threshold":dir.threshold,
							"scheduleId":dir.scheduleId,
							
							"collectEnableText":collectionEnableText,"alarmEnableText":alarmEnableText,
							"uuidOfEachAlarmWay":dir.uuidOfEachAlarmWay,
						})
					}
				}else{
					rowData=[];
				}		
				Grid($.extend(collectionConfig, {
					data:rowData
				}));
			}
		})
	}






	function initProcess(){
		/*
		 * 后台读取全局开关和频率
		 * 根据开关状况频率 锁定或刷新界面上的开关和数值
		 */
		loadGlobalSwitchAndFrequence();
		globalSwitchAndFreq();
		iniTable();
	}



	return {
		init : initProcess
	}
})