define(["PDUtilDir/grid",
        "PDUtilDir/util",
        "PDUtilDir/tool",
        "PDModuleDir/artTemplate/template",
        "PDWorktimeDir/holiday",
        "PDWorktimeDir/assign",
        "PDWorktimeDir/weekend",
        "PDWorktimeDir/workhour",
        "ClockPicker", "css!ClockPickerCss",
        "Date", "DateCN", "css!DateCss"
        ],
    function(Grid, Util, Tool, Template, Holiday, Assign, Weekend, Workhour){
    
    /**
     * 主页初始化
     */
    var init = function(){
    	Workhour.init();
    	Weekend.init();
    	Holiday.init();
    	Assign.init();
    };

    //变量
    //添加-工作时间段按钮
    var btn_add_worktime = "btn-add-worktime";
    //保存-工作时间段按钮
    var btn_save_worktime = "btn-save-worktime";
    //保存-非工作日按钮
    var btn_save_weekend = "btn-save-weekend";
    //保存-节假日按钮
    var btn_save_holiday = "btn-save-holiday";
    //表单-weekend
    var form_weekend = "form-weekend";
    //表格对象-holiday
    var gridHoliday;
    //表格数据-holiday
    var gridHolidayData = [];
    //工作时间数据
    var worktimeData = [];
    
    return {
        init:init
    }
});