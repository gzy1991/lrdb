define([ "jquery" ], function($) {

	return function($compile, $scope) {
		require([ "PDUtilDir/util","PDUtilDir/dialog","ArtTemplateNative"], function(Util,Dialog,Template) {		
			//初始化缓存配置信息
			var initCacheConfig  = function() {
				var tabName=[];
				var tabListStrInit="";
				var tabContentStrInit="";
				$.ajax({
					url : getServer() + "/sword/monitor/cacheMonitor/getManagersConfig",
					async: false, 
					success : function(data) {
						var str=Template("T_cacheConfigInfo",{managers:data});
						$("#pdMonitorCacheInfo").empty().append(str);
						
						var name="",memo="";
						for(var i=0,manager;manager=data[i];i++){
							for (var j=0,item;item=manager[j];j++){
								if(item.property=="name"){
									name=item.value;
								}else if(item.property=="memo"){
									memo=item.value;
								}
							}
							if(memo!=""&&memo!=null){
								$("#pdMonitorSwordCacheConfigSpan_"+i).html(memo+"配置");
								tabName[i]=memo+'状态 &nbsp;<i id="pdMonitorBtnRefreshCacheStatus_'+i+'" class="fa fa-refresh" style="cursor:pointer">刷新</i>';
							} else if(name!=""&&name!=null){
								$("#pdMonitorSwordCacheConfigSpan_"+i).html(name+"配置");
								tabName[i]=name+'状态 &nbsp;<i id="pdMonitorBtnRefreshCacheStatus_'+i+'" class="fa fa-refresh" style="cursor:pointer">刷新</i>';
								
							}
						}
						tabListStrInit=$("#pdMonitorSwordCacheTabList").html();
						tabContentStrInit=$("#pdMonitorCacheTabContent").html();
					}
				});
				var tabInfo={tabName:tabName,tabListStrInit:tabListStrInit,tabContentStrInit:tabContentStrInit};
				return tabInfo;
			}

			//初始化缓存状态信息
			var initCacheStatus  = function(tabInfo) {
				var tabName=tabInfo.tabName;
				var tabListStrInit=tabInfo.tabListStrInit;
				var tabContentStrInit=tabInfo.tabContentStrInit;
				$.ajax({
					url : getServer() + "/sword/monitor/cacheMonitor/getManagersStatus",
					async: false, 
					success : function(data) {
						var tabStr=Template("T_cacheStatusTabInfo",{managers:data});
						$("#pdMonitorSwordCacheTabList").empty().append(tabListStrInit).append(tabStr);
						var contentStr=Template("T_cacheStatusContentInfo",{managers:data});
						$("#pdMonitorCacheTabContent").empty().append(tabContentStrInit).append(contentStr);
						
						for(var i=0,manager;manager=data[i];i++){
							
							$("#pdMonitorSwordCacheTab_"+i).html(tabName[i]);
							var refreshCacheStatusBtn="#pdMonitorBtnRefreshCacheStatus_"+i;
							$(refreshCacheStatusBtn).click(function(e){
								var btnId=e.target.id;
								initCacheStatus(tabInfo);
								var temp=btnId.split("_"); 
								var index=temp[1];
								$("#pdMonitorSwordCacheTab_"+index).click();
				        	 });
							var k=-1;
							for(var key in manager){
								k++;
								var serverStr="#pdMonitorServer_"+i+"_"+k;
								$(serverStr).html(key);
							}
						}
						
					}
				});
			}
			var tabInfo=initCacheConfig();
			initCacheStatus(tabInfo);
			
		});
	};
});