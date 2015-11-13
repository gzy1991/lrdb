define([ "jquery" ], function($) {

	return function($compile, $scope) {
		require([ "PDUtilDir/util", "PDUtilDir/tool", "PDUtilDir/grid" ,"PDUtilDir/uploader/fileUploader","PDUtilDir/dialog"], function(Util,
				Tool, Grid,FileUpload,Dialog) {
			
			//上传的证书路径
			var filePath="";
			//上传的证书是否合法
			var legalLicense=false;
			//显示服务器的mac和ip列表
			var initIpv4NetInterfaceGrid = function() {
				var config = {
					id : "macAndIpList",
					realSort : true,
					placeAt : "ipv4NetInterfaceInfoGrid", //存放Grid的容器ID
					pagination : false,
					layout : [ {
						name : "网络接口名称",
						field : "name",
						sort : true
						,width:"40%"
					}, {
						name : "MAC 地址",
						field : "mac",
						sort : true
						,width:"20%"
					}, {
						name : "IP地址",
						field : "ip",
						sort : true
						,width:"20%"
					}, {
						name : "主机名",
						field : "hostName",
						sort : true
						,width:"20%"
					} ]
				};
				$.ajax({
					url : getServer() + "/sword/monitor/serverInfo/getIpv4NetInterfaceInfo",
					success : function(data) {
						Grid($.extend(config, {
							data : data
						}));
					}
				});
			}
			//显示License页面组件列表
			var initSwordInfoComponents = function(placeAt,data) {
				$("#"+placeAt).empty().append(data);
				
			}
			//显示当前服务器证书授权信息
       	 	var initServerInfo = function(){
       	 		$.ajax({
				url : getServer() + "/sword/monitor/serverInfo/getSwordInfo",
				dataType:"json",
				data :{
				},
				success : function(data) {
                   	Tool.deserialize("serverInfo",data);
                   	var componentsList="<ul>";
                   	for(var i=0;i<data.swordInfoComponents.length;i++)
                   	{
                   		componentsList+="<li>"+data.swordInfoComponents[i]+"</li>";
//                   		componentsList.push({"swordInfoComponentsName":data.swordInfoComponents[i]});
                   	}
                   	componentsList+="</ul>";
                   	initSwordInfoComponents("swordInfoComponentsGrid",componentsList);
                   	if(data.isLegalLicense==true){
                   		$("#serverInfoStatus").html("<font color=green>当前服务器授权成功</font>");

                   	}else{
                   		$("#serverInfoStatus").html("<font color=red>当前服务器未被授权</font>");
                   	}
				}
       	 		});
       	 }
       	 	
       	 	//新证书上传组件配置
       	 	var fileUploadOpt = {
					callback : function(data) {
						legalLicense=false;
						$.ajax({
							url : getServer() + "/sword/monitor/serverInfo/showNewFile",
							dataType:"json",
							data :{
								fid: data.result.fid
							},
							success : function(data) {
								var componentsList="<ul>";
			                   	for(var i=0;i<data.swordInfoComponents.length;i++)
			                   	{
			                   		componentsList+="<li>"+data.swordInfoComponents[i]+"</li>";
//		                   		componentsList.push({"swordInfoComponentsName":data.swordInfoComponents[i]});
			                   	}
			                   	componentsList+="</ul>";
			                   	initSwordInfoComponents("swordInfoComponentsGridNew",componentsList);
			                   	filePath=data.filePath;
			                   	legalLicense=data.isLegalLicense;
			                	if(legalLicense==true){
			                   		$("#serverInfoStatusNew").html("<font color=green>新证书合法</font>");

			                   	}else{
			                   		$("#serverInfoStatusNew").html("<font color=red>新证书不合法</font>");
			                   	}
			                	$("#swordInfoMacAddressNew").val(data.swordInfoMacAddress);
			                	$("#swordInfoOrgRootNameNew").val(data.swordInfoOrgRootName);
			                	$("#swordInfoMaxUserNew").val(data.swordInfoMaxUser);
			                	$("#runningModelNew").val(data.runningModel);
							}
			       	 	});
					}
				}
       	//新证书上传组件
       	 	FileUpload.createFileUploader("fileUpload","single","simple",fileUploadOpt);
       	 	
       	 	
       	 	
       	 
       	 
       	 	//生效按钮单击事件
       	 $("#upgradeLicense").click(function(){
       		if(legalLicense==false){
       		//弹出框
              	 var dialog = Dialog({
                    id:"BaseDialog",
                    cache:false,                 //是否缓存，默认为true
                    title:"生效失败",
                    width:"400px",
                    height:"100px",
                    dialogSize:"",               //modal-lg或modal-sm
                    body:"窗口中间内容",
                    //buttons:buttons
                });
                //可以通过返回的dialog对象调用相关方法
                dialog.setBody("请上传合法的证书");
                dialog.show();
       			return;
       		}
       		$.ajax({
				url : getServer() + "/sword/monitor/serverInfo/upgradeLicense",
				dataType:"json",
				data :{
					filePath: filePath
				},
				success : function(data) {
					if("success"==data.status){
						initServerInfo();
						//弹出框
				       	 var dialog = Dialog({
				             id:"BaseDialog",
				             cache:false,                 //是否缓存，默认为true
				             title:"生效成功",
				             width:"400px",
				             height:"100px",
				             dialogSize:"",               //modal-lg或modal-sm
				             body:"窗口中间内容",
				             //buttons:buttons
				         });
						dialog.setBody("证书生效成功");
		                dialog.show();
					}else{
						//弹出框
				       	 var dialog = Dialog({
				             id:"BaseDialog",
				             cache:false,                 //是否缓存，默认为true
				             title:"生效失败",
				             width:"400px",
				             height:"100px",
				             dialogSize:"",               //modal-lg或modal-sm
				             body:"窗口中间内容",
				             //buttons:buttons
				         });
						dialog.setBody("请上传合法的证书");
		                dialog.show();
					}
				}
       	 		});
    	 });
       //显示组件标签页
    	 	var initSwordComponents = function() {
				var config = {
						id : "swordComponents",
						realSort : true,
						placeAt : "swordComponentsGrid", //存放Grid的容器ID
						pageSize : 10, //一页多少条数据
						pagination : false,
						layout : [ 
						      {name : "组件名称",field : "swordComponentsName",sort : true},
						      {name : "跳转链接",field : "route",format:function(data){
						    	  	if(data.row.swordComponentsUrl!=null&&data.row.swordComponentsUrl!=""){
						    	  		return '点击跳转';
						    	  	}else{
						    	  		return "";
						    	  	}
						    	  },click:function(e){
						    		  $("#sidebar a[href=#"+e.data.row.swordComponentsUrl+"]").click()
						    	  }
						      }
						]
					};
				$.ajax({
					url : getServer() + "/sword/monitor/serverInfo/getComponets",
					success : function(data) {
						Grid($.extend(config, {
							data : data
						}));
					}
				});
			}
			//初始化
			var initCurrentServerMachine = function() {
				initIpv4NetInterfaceGrid();
				initServerInfo();
				initSwordComponents();
			}
			initCurrentServerMachine();
			
		});
	};
});