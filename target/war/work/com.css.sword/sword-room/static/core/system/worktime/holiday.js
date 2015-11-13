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
    	//初始化年份下拉菜单
    	initYearSelect();
    	//初始化表格
    	initGridHoliday();
    };
    
    /**
     * 变量
     */
    /*************主页相关**********/
    //表格-指定工作日
    var select_holiday_year = "select-holiday-year";
    var text_holiday_year = "holidayYear";
    var grid_holiday_id = "grid-holiday";
    var btn_day_save_id = "btn-holiday-save";
    var gridHoliday;
    /************添加日期页面相关******/
    var form_holiday_id = "form-holiday";
    var grid_holiday_date_id = "grid-holiday-date";
    var gridHolidayDate;
    var text_day_date_begin_id = "text-day-date-begin";
    var text_day_date_end_id = "text-day-date-end";
    var btn_day_date_save_id = "btn-day-date-save";
    
    function initYearSelect() {
    	//获得最早日期
    	var pastDate = new Date();
    	pastDate.setTime(0);
    	var pastYear = pastDate.getFullYear();
    	//获得当前日期
    	var currentDate = new Date();
    	var currentYear = currentDate.getFullYear();
    	//获得未来10年日期
    	var laterDate = new Date();
    	laterDate.setFullYear(laterDate.getFullYear() + 10);
    	var laterYear = laterDate.getFullYear();
    	
    	//初始化年份下拉列表
    	var minus = laterYear - pastYear;
    	for (var i=minus; i>=0; i--) {
    		var year = pastYear + i;
    		var selected = (year == currentYear) ? "selected='selected'" : "";
    		$("<option value='" + year + "' " + selected + ">" + year + "</option>").appendTo($("#" + select_holiday_year));
    	}
    	
    	//绑定切换事件
    	$("#" + select_holiday_year).on("change", function() {
    		initGridHoliday();
    	})
    }
    
    var gridConfig = {
    		id : "gridHoliday",
	        placeAt : grid_holiday_id,
	        multi:true,
	        pagination:true,
	        layout : [{
	            name:"节假日名称", width:"30%", field:"holidayName",click:function(e){
	            	updateHoliday(e.data.row);
	        	}
	        },{
	            name:"日期", width:"70%", field:"holidayDate"
	        }],
	        toolbar:[
	            {name:"添加",icon:"fa fa-plus-circle",callback:function(){ 
	            	addHoliday();
	            }},
	            {name:"删除",icon:"fa fa-trash-o",callback:function(){
	            	delHoliday();
	            }}
	        ],
	        data:[]
    }
    
    function initGridHoliday() {
    	$.ajax({
			url : getServer() + "/sword/worktime/getHolidayByYear",
			data : {
				year : $("#" + select_holiday_year).val()
			},
			success : function(data) {
				gridHoliday = Grid($.extend(gridConfig, {
					data:data
				}));
			}
		});
    }
    
    //添加节假日
    function addHoliday() {
    	var row = {
    		holidayYear : $("#" + select_holiday_year).val()
    	}
    	editHoliday(row);
    }
    
    function updateHoliday(row) {
    	editHoliday(row);
    }
    
    function editHoliday(row) {
    	var slidebar = Util.slidebar({
   		 	url : getServer() + "/static/core/system/worktime/views/holiday.html",
   		 	width : "500px",
	        afterLoad : function() {
	        	//初始化日期列表
	        	initGridHolidayDate();
	        	//初始化数据
	        	setHolidayData(row);
	        	//监听保存按钮
	        	$("#" + btn_day_save_id).on("click", function(){
	        		var data = getHolidayData();
	        		$.ajax({
	        			url : getServer() + "/sword/worktime/saveHoliday",
	        			data : data,
	        			success : function(data) {
	        				Util.alert(data.message);
	        				if (data.success) {
	        					initGridHoliday();
	        					slidebar.close();
	        				}
	        			}
	        		})
	        	});
	        }
    	});
    }
    
    function getHolidayData() {
    	var data = Tool.serialize(form_holiday_id);
		
		var dateData = gridHolidayDate.getCurPageData();
		var dateDataArr = [];
		$.each(dateData, function(i, n) {
			dateDataArr.push(n.date);
		});
		data.holidayDate = dateDataArr.join(",");
		
		return data;
    }
    
    function setHolidayData(data) {
    	Tool.deserialize(form_holiday_id, data);
    	
    	if (data.holidayDate) {
    		var dateDataArr = data.holidayDate.split(",");
    		var dateData = [];
    		$.each(dateDataArr, function(i, n) {
    			dateData.push({
    				date : n
    			})
    		})
    		for (var i=0; i<dateData.length; i++) {
    			gridHolidayDate.appendRow(dateData[i]);
    		}
    	}
    }
    
    //删除节假日
    function delHoliday() {
		var rows = Grid.getGrid("gridHoliday").getSelectedRow();
		if (rows && rows.length > 0) {
			Util.confirm("确定要删除指定的记录吗？", function() {
				var ids = "";
				$.each(rows, function(i, row){
					ids = ids.concat(row.id).concat(",");
				})
				$.ajax({
					url : getServer() + "/sword/worktime/deleteHoliday",
					data : {
						ids : ids
					},
					success : function(data) {
						Util.alert(data.message);
						if (data.success) {
							initGridHoliday();
						}
					}
				})
			});
		} else {
			Util.alert("请选择要删除的行记录");
		}
    }
    
    function initGridHolidayDate() {
    	gridHolidayDate = Grid( {
			id : "gridHolidayDate",
	        placeAt : grid_holiday_date_id,
	        multi : true,
	        pagination : false,
	        layout : [{
	            name:"日期", field:"date"
	        }],
	        toolbar:[
	            {name:"添加",icon:"fa fa-plus-circle",callback:function(){ 
	            	addHolidayDate();
	            }},
	            {name:"删除",icon:"fa fa-trash-o",callback:function(){
	            	delHolidayDate();
	            }}
	        ],
	        data:[]
    	})
    }
    
    function addHolidayDate() {
    	var slidebar = Util.slidebar({
    		url : getServer() + "/static/core/system/worktime/views/assign_date.html",
   		 	width : "500px",
	        afterLoad : function() {
	        	//初始化日期
    			$("#" + text_day_date_begin_id).datetimepicker({
    				//设置使用语言：cn是自定义的中文版本，还可以扩展其他语言版本
    	            language : "cn",
    	            //输出格式化
    	            format : 'yyyy-mm-dd',
    	            //直接选择‘今天’
    	            todayBtn : true,
    	            //设置最精确的时间选择视图
    	            minView : 'month',
    	            //高亮当天日期
    	            todayHighlight : true,
    	            //选择完毕后自动关闭
    	            autoclose : true
    			});
    			$("#" + text_day_date_end_id).datetimepicker({
    				language : "cn",
    				format : 'yyyy-mm-dd',
    				todayBtn : true,
    				minView : 'month',
    				todayHighlight : true,
    				autoclose : true
    			});
    			//监听确定按钮
    			$("#" + btn_day_date_save_id).on("click", function(){
    				//开始日期
    				var start = $("#" + text_day_date_begin_id).val();
    				//结束日期
    				var end = $("#" + text_day_date_end_id).val();
    				var dateArr = DateUtil.minus(start, end);
    				$.each(dateArr, function(i, n) {
    					gridHolidayDate.appendRow({
    						date : n
    					});
    				})
    				slidebar.close();
    			});
	        }
    	});
    }
    
    function delHolidayDate() {
    	var grid = Grid.getGrid("gridHolidayDate");
    	var rows = grid.getSelectedRowIndex();
    	if (rows && rows.length > 0) {
    		for (var i=0; i<rows.length; i++) {
    			grid.deleteRow(rows[i]);
    		}
    	}
    }
    
    return {
        init:init
    }
});