/**
 * Sword基础框架 ： sword-monitor 
 * Copyright 中国软件与技术服务股份有限公司
 */
/**
 * @功能描述 
 *  
 * 系统监控下服务器监控 控制器
 * @author YaoGuanhong
 * @创建时间 2015年7月10日 下午1:13:56
 * @History 修订历史<br>
 * 
 */

define(["jquery"],function($){

    return function($compile,$scope,$route,$routeParams){
    		require(["static/core/systemMonitor/serverMonitor/serverMonitorSupport"],function(site){
    			site.init();
            });
    	   		
    };
});