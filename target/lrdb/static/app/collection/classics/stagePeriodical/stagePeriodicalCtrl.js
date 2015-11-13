/**
 * 期刊管理
 * @author zhanglei@css.com.cn
 */
define(['jquery','LrdbStagePeriodicalDir/stagePeriodicalSupport'],
	function($,Support){
		return function($compile,$scope){
			Support.initCtrl($compile,$scope);
		};
	}
);