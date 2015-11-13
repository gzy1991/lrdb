/**
 * Sword基础框架 ： sword-monitor 
 * Copyright 中国软件与技术服务股份有限公司
 */
/**
 * @功能描述 
 *  
 * 系统监控下服务器监控的实现
 * @author YaoGuanhong
 * @创建时间 2015年7月10日 下午1:13:56
 * @History 修订历史<br>
 * 
 */

define(["PDUtilDir/grid",
        "PDUtilDir/util", 
        "ZTree","css!ZTreeCss"], 
        function(Grid, Util){
	function initProcess(){
		/**
		 * 请求tomcat中jvm的信息
		 */
		$.ajax({
			url:getServer() + "/sword/monitor/servermonitor/getFromStaticInfoFront",
//			data:{SwordControllerName:"DBmonitorSwordController"},
			success:function(data){
				if (data.status == "success"){
					var rowData = data.data;
					$("#server_serverVersion").val(rowData["Tomcat Version"]);
					$("#server_jvmVersion").val(rowData["JVM Version"]);
					$("#server_source").val(rowData["JVM Vendor"]);
					$("#server_systemType").val(rowData["OS Name"]);
					$("#server_osArchitecture").val(rowData["OS Architecture"]);
					$("#server_osVersion").val(rowData["OS Version"]);
				} else {
						//TODO 提示组件
				}
				
			}
		})
		
		/**
		 * 请求tomcat的中的server以及中间件信息
		 */	
		$.ajax({
			url:getServer() + "/sword/monitor/servermonitor/getFromTomcatFront",
//			data:{SwordControllerName:"DBmonitorSwordController"},
			success:function(data){
				if (data.status == "success"){
					var rowData = data.data;
					$("#server_currentThread").val(rowData.currentThreadCount.toString());
					$("#server_currentBusyThread").val(rowData.currentThreadsBusy.toString());
					$("#server_freeMemory").val(rowData.free.toString());
					$("#server_maxAvailable").val(rowData.max.toString());
					$("#server_totalMemory").val(rowData.total.toString());
					$("#server_threadLimits").val(rowData.maxThreads.toString());
					$("#server_longestProcessTime").val(rowData.maxTime.toString()+"毫秒");
					$("#server_processTime").val(rowData.processingTime.toString()+"毫秒");
					$("#server_requestCount").val(rowData.requestCount.toString());
					
					$("#server_errorCount").val(rowData.errorCount.toString());
					
					$("#server_receviedBytes").val(rowData.bytesReceived.toString());
					$("#server_sentBytes").val(rowData.bytesSent.toString());
					
				} else {
					//TODO
				}
				
			}
		})
		
		/**
		 * 请求系统中关于服务器中间件和OS的信息
		 * 将属性排序
		 */
		$.ajax({
			url:getServer() + "/sword/monitor/servermonitor/getInfoFromSwordPlatFormFront",
//			data:{SwordControllerName:"DBmonitorSwordController"},
			success:function(data){
				if (data.status == "success"){
					var rowData = data.data;
					$("#server_serverName").val(rowData.serverName);
					$("#server_frameWorkID").val(rowData.frameWorkID);
					$("#server_developMode").val(rowData.serverMode);
					$("#server_hostName").val(rowData.hostName);
					$("#server_codeOfJvmProcess").val(rowData.jvmPid);
					$("#server_whetherEpoll").val(rowData.server_whetherEpoll);
					
					$("#server_defaultCharacterEncode").val(rowData.defaultCharactEncode);
					
					$("#server_defaultDistrict").val(rowData.defaultDistrict);
					$("#server_zipAltEncoding").val(rowData.ZipAltEncode);
					$("#server_defaultLanguage").val(rowData.defaultLanguage);
					
					$("#server_defaultTimeZone").val(rowData.timeZone);
					
					$("#server_whetherEpoll").val(rowData.server_whetherEpoll);
							
					
					$("#server_serverIP").val(rowData.serverIP);
					
					$("#server_dynamicLibrarySerachPath").text(rowData.dynamicLibrary);
					
					$("#server_defaultTempFile").val(rowData.tempFileDir);
					
					$("#server_avaProcessNumber").val(rowData.processNumber.toString());
					
					$("#server_jvmCPUPercent").val(rowData.jvmCpuPercentage + "%");
					
					$("#server_serverPercentage").val(rowData.sysCpuPercentage + "%");
		
					$("#server_userName").val(rowData.serverUserName);
			
					
					$("#server_mainConfigureFile").html(rowData.swordConfigFile);
					$("#server_jvmPlacement").html(rowData.jvmHome);
					$("#server_vmStartParameter").html(rowData.vmParameter);
		
					$("#server_classPath").html(rowData.classPath);
				
					$("#server_dynamicLibrarySerachPath").html(rowData.dynamicLibrary);
					$("#server_defaultTempFile").html(rowData.tempFileDir);
					$("#server_userCurrentDir").html(rowData.currentDir);
					
				} else {
					//TODO
				}
				
				
			}
		})
		$(":input").prop("readonly",true);
	}




	return {
		init : initProcess

	}

})