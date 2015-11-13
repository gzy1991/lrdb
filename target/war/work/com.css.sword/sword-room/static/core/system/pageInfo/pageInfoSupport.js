/**
 * Created by weijy on 2015/6/2.
 */
define(["PDUtilDir/grid",
        "PDUtilDir/util",
        "PDUtilDir/tool",
        "ZTree","css!ZTreeCss","JQuery.validate","JQuery.validate.extra","JQuery.validate.message"], 
        function(Grid, Util, Tool) {
	
	/**
	 * 程序入口
	 */
    function init() {
    	//初始化数据
    	refresh();
    	//监听保存事件
        $("#" + btn_pageinfo_save_id).on("click", function(){
        	$.ajax({
        		url : getServer() + "/sword/pageinfo/save",
        		data : Tool.serialize("form_pageinfo"),
        		success : function(data) {
        			data.message && Util.alert(data.message);
        		}
        	});
        })
        //监听刷新事件
        $("#" + btn_pageinfo_refresh_id).on("click", function(){
        	refresh();
        })
        //监听下拉框改变事件
        
        $("#" + select_pageinfo_theme).on("change", function() {
        	var theme = $(this).val();
        	//换肤
        	var $link = $("link[data-theme]");
        	if ($link[0]) {
        		var href = $("link[data-theme]").attr("href");
        		var index = href.lastIndexOf("/");
        		var href_front = href.substring(0, index);
        		var href_end = href.substr(index);
        		index = href_front.lastIndexOf("/");
        		href_front = href_front.substring(0, index);
        		href = href_front + "/" + theme + href_end;
        		console.log(href);
        		$link.attr("href", href);
        	}
        })
        
    }

    //刷新
    function refresh() {
    	$.ajax({
    		url : getServer() + "/sword/pageinfo/getPageInfo",
    		success : function(data) {
    			if (data) {
    				Tool.deserialize("form_pageinfo", data);
    			}
    		}
    	});
    }
    
    //初始化变量
    //路径
    var path = "";
    //保存按钮id
    var btn_pageinfo_save_id = "btn_pageinfo_save";
    //刷新按钮
    var btn_pageinfo_refresh_id = "btn_pageinfo_refresh";
    //表单id
    var form_pageinfo_id = "form_pageinfo";
    //主题样式select的id
    var select_pageinfo_theme = "systemTheme";
    
    return {
        init : init
    }
})