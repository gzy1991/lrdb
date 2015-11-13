define(["jquery","JQuery.pubsub","PDUtilDir/tool"],function($,PubSubJS,Tool){
	var validateModuleInfo=function(){
		$("#sys_qd_addModule form").validate({
				rules:{
					moduleName:{
						required:true,
						maxlength:40,
						remote:{
	                        type:"POST",  //请求方式
	                        url: getServer()+"/sword/sys/dict/validateDictItem", //请求的服务
	                        data:{  //要传递的参数
	                        	id:function(){
	                        		return $("#id").val();
	                        	},
	                            dictName:function(){return toTxt($("#name").val());},
	                            parentId:function(){return $("#parentId").val();}
	                        }
	                    }
					},
					enIdentify:{
	        			required:true,
	        			maxlength:40,
	        			PD_regex: "^\\w+$",
	        			remote:{
	                        type:"POST",  //请求方式
	                        url: getServer()+"/sword/sys/dict/validateDictItem", //请求的服务
	                        data:{  //要传递的参数
	                        	id:function(){return $("#id").val();},
	                            dictCode:function(){return $("#code").val();},
	                            parentId:function(){return $("#parentId").val();}
	                        }
	                    }
	            	},
	            	moduleDescription:{
	            		maxlength:200
	            	}
					
				}
		});
	};
	var addFormOpera=function(msg,data){
		console.log(msg+" "+ data);
		if(data){
			if(data=="submit"){
				var $formDom=$("#sys_qd_addModule form");
				if($formDom.valid()){
					var data=Tool.serialize($formDom);
					//  获取uuid
					data.uuid="uuid";
					PubSubJS.publish("sys_qd_moduleBuilder_init",data);
				}
			}else if(data=="reset"){
				$("#sys_qd_addModule form :reset").trigger("click");
			}
		}
	};
	
	(function(){
		var registFormOpera= PubSubJS.subscribe("sys_qd_addModule_opera",addFormOpera);
		var registCancel=PubSubJS.subscribe("sys_qd_addModule_cancelRegist",function(msg,data){
			PubSubJS.unsubscribe(registSubmit);
			PubSubJS.unsubscribe(registReset);
			PubSubJS.unsubscribe(registCancel);
		});
		validateModuleInfo();
	})();
});