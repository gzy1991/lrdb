define(['jquery'],function($){
	//期刊ServiceContainer
	var periodicalServiceUrl = getServer()+'/sword/collection/classics/periodicalInfoService/';
	var periodicalColumntreeServiceUrl = getServer()+'/sword/collection/classics/periodicalColumntreeService/';
	var periodicaUnitServiceUrl = getServer()+'/sword/collection/classics/periodicaUnitService/';
	//分期刊ServiceContainer
	var stagePeriodicalServiceUrl = getServer()+'/sword/collection/classics/stagePeriodicalInfoService/';
	var stagePeriodicalColumntreeServiceUrl = getServer()+'/sword/collection/classics/stagePeriodicalColumntreeService/';
	var stagePeriodicalArticleInfoServiceUrl = getServer()+'/sword/collection/classics/stagePeriodicalArticleInfoService/';
	
	return {
	
	/**
	 * 艺术类型 
	 */
	 URL_ART_TYPE : getServer() + '/static/app/common/data/artType.json',
	/**
	 * 活动艺术类型
	 */
	 URL_ACT_ART_TYPE : getServer() + '/static/app/common/data/artTypeList.json',
	/**
	 * 活动类型
	 */
	 URL_ACTIVITY_TYPES : getServer() + '/static/app/common/data/activityTypes.json',

	 /**
	* 活动级别
	*/
	URL_ACT_LEVEL_TYPES : getServer() + '/static/app/common/data/actLevelType.json',
	 /**
	* 省级别
	*/
	URL_PROVICE_TYPES :getServer() + '/static/app/common/data/proviceName.json',
	 /**
	* 市级别
	*/
	URL_CITY_TYPES :getServer() + '/static/app/common/data/cityName.json',
	 /**
	* 县级别
	*/
	URL_COUTRY_TYPES :getServer() + '/static/app/common/data/coutryName.json',
	 /**
	* 地点
	*/
	URL_SITE :getServer() + '/static/app/common/data/site.json',
    /**
	 * 活动性质
	*/
	URL_ACT_NATURE_TYPES : getServer() + '/static/app/common/data/actNatrueType.json',
	 /**
	 * 百科
	 */
	URL_ENCYCLOPEDIA_TYPE : getServer() + '/static/app/common/data/encyclopediaTypeList.json',
	URL_ENCYCLOPEDIA_INITEDITOR : getServer() + '/static/app/collection/encyclopedia/views/encyclopediaInitEditor.html',
	/**
	 * 期刊类型
	 */
	 URL_PERIODICAL_TYPE : getServer() + '/static/app/common/data/periodicalType.json',

	/**
	 * 语种类型
	 */
	 URL_LANGUAGE_TYPE : getServer() + '/static/app/common/data/languageType.json',
	 
	 /**
	  * 新闻类型
	  */
	 URL_NEWS_TYPE : getServer() +  '/static/app/common/data/newsType.json',
	
	 URL_BOOK_ARTTYPE : getServer() + '/static/app/common/data/bookArttypes.json',
	 /**
	  * 期刊类型 
	  */
	 URL_PERIODICAL_TYPE : getServer() + '/static/app/common/data/periodicalType.json',
	 /**
	  * 出版周期 
	  */
	 URL_PUBLISHCYCLE_TYPE : getServer() + '/static/app/common/data/publishCycleType.json',
	 /**
	  * 开本
	  */
	 URL_FOLIO_TYPE : getServer() + '/static/app/common/data/folioType.json',
	 /**
	  * 图书丛集
	  */
	 URL_BOOK_COLLECTION : getServer() + '/static/app/common/data/collection.json',
	 /**
	  * 图书语种
	  */
	 URL_BOOK_LANGUAGE : getServer() + '/static/app/common/data/bookLanguage.json',
	 
	 URL_EXIST : getServer() + '/static/app/common/data/exist.json',
	 /**
	  * 奖节级别
	  */
	 URL_AWARD_LEVEL : getServer() + '/static/app/common/data/awardLevels.json',
	 /**
	  * 奖节性质
	  */
	 URL_AWARD_NATURE : getServer() + '/static/app/common/data/awardNatures.json',
	 /**
	  * 奖项树形数据
	  */	 
	 URL_AWARD_TREEDATA : getServer() + '/static/app/common/data/awards.json',
	 /**
	  * 奖项检索页面模板
	  */
	 URL_AWARD_TEMPLATE : getServer() + '/static/app/common/data/templates.json',
	
//期刊增删该查地址--Start-------------------------------
	 
	 //获得期刊LIST
	 URL_QUERYPERIODICALINFOLIST_SERVICE :periodicalServiceUrl + 'queryPeriodicalInfoList',
	 //期刊保存或更新操作
	 URL_SAVEORUPDATEPERIODICAL_SERVICE :periodicalServiceUrl +'saveOrUpdatePeriodical',
	 //通过ID查询期刊
	 URL_QUERYPERIODICALINFOBYID_SERVICE :periodicalServiceUrl +'queryPeriodicalInfoById',
	 //期刊删除操作
	 URL_DELBATCHPERIODICALINFOBYID_SERVICE :periodicalServiceUrl +'delBatchPeriodicalInfoById',
	 //期刊栏目通过ID加载
	 URl_QUERYPERIODICALCOLUMNTREEBYID_SERVICE :periodicalColumntreeServiceUrl +'queryPeriodicalColumntreeById',
	 //期刊地址查询操作
	 URl_QUERYPERIODICAUNITBYID_SERVICE :periodicaUnitServiceUrl +'queryPeriodicaUnitById',
	 //获得分期刊LIST
	 URL_QUERYSTAGEPERIODICALINFOLIST_SERVICE : stagePeriodicalServiceUrl + 'queryStagePeriodicalInfoList',
	 //分期刊_保存更新操作
	 URL_SAVEORUPDATESTAGEPERIODICAL_SERVICE : stagePeriodicalServiceUrl + 'saveOrUpdateStagePeriodical',
	 //分期刊_新增时初始化页面信息
	 URL_QUERYSTAGEPERIODICALINFOBYID_SERVICE : stagePeriodicalServiceUrl + 'queryStagePeriodicalInfoById',
	 //分期期刊_删除操作
	 URL_DELBATCHSTAGEPERIODICALINFOBYID_SERVICE : stagePeriodicalServiceUrl + 'delBatchStagePeriodicalInfoById',
	 //分期期刊_编辑时初始化栏目
	 URL_QUERYSTAGEPERIODICALCOLUMNTREEBYID_SERVICE : stagePeriodicalColumntreeServiceUrl + 'queryStagePeriodicalColumntreeById',
	//分期期刊_根据栏目ID获得文章列表
	 URL_QUERYSTAGEPERIODICALARTICLEINFOLIST_SERVICE : stagePeriodicalArticleInfoServiceUrl + 'queryStagePeriodicalArticleInfobyColumnIdList',
	 //分期期刊_根据文章ID获得文章内容
	 URL_QUERYSTAGEPERIODICALARTICLEBYID_SERVICE : stagePeriodicalArticleInfoServiceUrl + 'queryStagePeriodicalArticleById',
	 //期刊增删改查--End--------------------------------
	 queryDict : function(url){return $.post(url);}
	};

	
});