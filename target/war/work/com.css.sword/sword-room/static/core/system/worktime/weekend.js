define(["PDUtilDir/grid",
        "PDUtilDir/util",
        "PDUtilDir/tool",
        "PDUtilDir/dialog",
        "PDWorktimeDir/dateUtil"
        //"ClockPicker", "css!ClockPickerCss",
        //"Date", "DateCN", "css!DateCss"
        ],
    function(Grid, Util, Tool, Dialog, DateUtil){
    
    /**
     * 初始化
     */
    var init = function(){
    	initWeekend();
    };
    
    /**
     * 变量
     */
    /*************主页相关**********/
    //表格-指定工作日
    var btn_weekend_save_id = "btn-weekend-save";
    var form_weekend_id = "form-weekend";
    
    function initWeekend() {
    	$.ajax({
    		url : getServer() + "/sword/worktime/getWeekend",
    		success : function(data) {
    			if (data) {
    				data.weekend = data.weekend.split(",");
    				Tool.deserialize(form_weekend_id, data);
    			}
    		}
    	})
    	$("#" + btn_weekend_save_id).on("click", function(){
    		var data = Tool.serialize(form_weekend_id);
    		if (data.weekend)
    			data.weekend = data.weekend.join(",");
    		$.ajax({
    			url : getServer() + "/sword/worktime/saveWeekend",
    			data : data,
    			success : function(data) {
    				Util.alert(data.message);
    			}
    		})
    	})
    }
    
    return {
        init:init
    }
});