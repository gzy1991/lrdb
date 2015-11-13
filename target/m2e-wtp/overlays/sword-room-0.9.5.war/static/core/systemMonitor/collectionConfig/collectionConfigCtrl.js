/**
 * Sword基础框架 ： sword-monitor 
 * Copyright 中国软件与技术服务股份有限公司
 */

/**
 * @功能描述 
 *  
 * 系统监控下服务器监控 控制器
 * @author YaoGuanhong
 * @创建时间 2015年8月12日 上午9:21
 * @History 修订历史<br>
 * 
 */

define(["jquery"],function($){

    return function($compile,$scope,$route,$routeParams){
    		require(["static/core/systemMonitor/collectionConfig/collectionConfigHome"],function(site){
    			site.init();
            });
    	   		
    };
});