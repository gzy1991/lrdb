/**
 * Created by HY on 2015/07/24.
 */
define(function(){
    require.config({
        paths:{
        	//期刊
            'LrdbPeriodicalDir':'static/app/collection/classics/periodical',
            'LrdbStagePeriodicalDir':'static/app/collection/classics/stagePeriodical',    	
        	 //资源编审
        	'LrdbresDir':'static/app/resourcebs/mycaib',
        	'LrdbresdbrwDir':'static/app/resourcebs/daibanrenw',
        	'LrdbresybrwDir':'static/app/resourcebs/yibanrenw',
        	
        	//活动信息
        	'LrdbActDir':'static/app/collection/activityInfo',
        	//奖节信息
        	'LrdbAwardDir' : 'static/app/collection/award',
        	
        	//百科
        	'LrdbEncyclopediaDir' : 'static/app/collection/encyclopedia',
        	'LrdbencyclopediaEditorDir' : 'static/app/ckeditor',
        	
        	//文档管理
        	'LrdbDocumentDir' : 'static/app/document',
        	
        	//典籍信息-图书信息
        	'LrdbBookDir' : 'static/app/collection/classics/book',
        	
        	//公共路径
        	'LrdbCommonDir' : 'static/app/common',
        	'LrdbUtilDir' : 'static/common/util',
        	'LrdbTestDir' : 'static/app/collection/test',
        	'LrdbYaosiyuDir':'',
        	//CKEditor
        	'LrdbCkEditor':'static/app/ckeditor/ckeditor',
        	//示例路径
        	 'LrdbDemoDir' :'static/app/demo'
            }
    });
});

