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
    	initGridAssign();
    };
    
    /**
     * 变量
     */
    /*************主页相关**********/
    //表格-指定工作日
    var gird_assign_id = "grid-assign";
    var form_assign_id = "form-assign";
    var btn_assign_id = "btn-assign-save";
    var gridAssign;
    /************添加日期页面相关******/
    //表格-日期列表
    var grid_assign_date_id = "grid-day-date";
    var gridAssignDate;
    var text_day_date_begin_id = "text-day-date-begin";
    var text_day_date_end_id = "text-day-date-end";
    var btn_day_date_save_id = "btn-day-date-save";
    /***********添加时间页面相关******/
    var grid_assign_time_id = "grid-day-time";
    var gridAssignTime;
    var text_day_time_begin_id = "text-day-time-begin";
    var text_day_time_end_id = "text-day-time-end";
    var btn_day_time_save_id = "btn-day-time-save";
    
    var gridConfig = {
    		id : "gridAssign",
	        placeAt : gird_assign_id,
	        multi:true,
	        pagination:true,
	        layout : [{
	            name:"说明", width:"20%", field:"assignName",click:function(e){
	            	updateAssign(e.data.row);;
	        	}
	        },{
	            name:"日期", width:"30%", field:"assignDate"
	        },{
	            name:"是否休息日", width:"10%", field:"assignWeekend",format:function(data) {
	            	var weekend = data.row.assignWeekend;
	        		if ("y" == weekend) {
	        			return "是";
	        		} else if ("n" == weekend) {
	        			return "否";
	        		} else {
	        			return weekend;
	        		}
	            }
	        },{
	            name:"工作时间", width:"30%", field:"assignTime"
	        }],
	        toolbar:[
	            {name:"添加",icon:"fa fa-plus-circle",callback:function(){ 
	            	addAssign();
	            }},
	            {name:"删除",icon:"fa fa-trash-o",callback:function(){
	            	delAssign();
	            }}
	        ],
	        data:[]
    }
    
    function initGridAssign() {
    	$.ajax({
			url : getServer() + "/sword/worktime/getAssign",
			success : function(data) {
				gridAssign = Grid($.extend(gridConfig, {
					data:data
				}));
			}
		});
    }
    
    function addAssign() {
    	editAssign({});
    }
    
    function updateAssign(row) {
    	editAssign(row);
    }
    
    function editAssign(row) {
    	var slidebar = Util.slidebar({
   		 	url : getServer() + "/static/core/system/worktime/views/assign.html",
   		 	width : "500px",
	        afterLoad : function() {
	        	//初始化日期列表
	        	initGridAssignDate();
	        	//初始化时间列表
	        	initGridAssignTime();
	        	//初始化数据
	        	setAssignData(row);
	        	//监听保存按钮
	        	$("#" + btn_assign_id).on("click", function(){
	        		var data = getAssignData();
	        		$.ajax({
	        			url : getServer() + "/sword/worktime/saveAssign",
	        			data : data,
	        			success : function(data) {
	        				Util.alert(data.message);
	        				if (data.success) {
	        					initGridAssign();
	        					slidebar.close();
	        				}
	        			}
	        		})
	        	});
	        }
    	});
    }
    
    function getAssignData() {
    	var data = Tool.serialize(form_assign_id);
		
		var dateData = gridAssignDate.getCurPageData();
		var timeData = gridAssignTime.getCurPageData();
		var dateDataArr = [];
		$.each(dateData, function(i, n) {
			dateDataArr.push(n.date);
		});
		var timeDataArr = [];
		$.each(timeData, function(i, n) {
			timeDataArr.push(n.beginTime + "-" + n.endTime);
		});
		
		data.assignDate = dateDataArr.join(",");
		data.assignTime = timeDataArr.join(",");
		
		return data;
    }
    
    function setAssignData(data) {
    	Tool.deserialize(form_assign_id, data);
    	
    	if (data.assignDate) {
    		var dateDataArr = data.assignDate.split(",");
    		var dateData = [];
    		$.each(dateDataArr, function(i, n) {
    			dateData.push({
    				date : n
    			})
    		})
    		for (var i=0; i<dateData.length; i++) {
    			gridAssignDate.appendRow(dateData[i]);
    		}
    	}
    	if (data.assignTime) {
    		var timeDataArr = data.assignTime.split(",");
    		var timeData = [];
    		$.each(timeDataArr, function(i, n) {
    			var bTime = n.split("-")[0],
    				eTime = n.split("-")[1];
    			timeData.push({
    				beginTime : bTime,
    				endTime : eTime
    			})
    		})
    		for (var i=0; i<timeData.length; i++) {
    			gridAssignTime.appendRow(timeData[i]);
    		}
    	}
    }
    
    function delAssign() {
    	var rows = Grid.getGrid("gridAssign").getSelectedRow();
		if (rows && rows.length > 0) {
			Util.confirm("确定要删除指定的记录吗？", function() {
				var ids = "";
				$.each(rows, function(i, row){
					ids = ids.concat(row.id).concat(",");
				})
				$.ajax({
					url : getServer() + "/sword/worktime/deleteAssign",
					data : {
						ids : ids
					},
					success : function(data) {
						Util.alert(data.message);
						if (data.success) {
							initGridAssign();
						}
					}
				})
			});
		} else {
			Util.alert("请选择要删除的行记录");
		}
    }
    
    function initGridAssignDate() {
    	gridAssignDate = Grid( {
			id : "gridAssignDate",
	        placeAt : grid_assign_date_id,
	        multi : true,
	        pagination : false,
	        layout : [{
	            name:"日期", field:"date"
	        }],
	        toolbar:[
	            {name:"添加",icon:"fa fa-plus-circle",callback:function(){ 
	            	addAssignDate();
	            }},
	            {name:"删除",icon:"fa fa-trash-o",callback:function(){
	            	delAssignDate();
	            }}
	        ],
	        data:[]
    	})
    }
    
    function addAssignDate() {
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
    					gridAssignDate.appendRow({
    						date : n
    					});
    				})
    				slidebar.close();
    			});
	        }
    	});
    }
    
    function delAssignDate() {
    	var grid = Grid.getGrid("gridAssignDate");
    	var rows = grid.getSelectedRowIndex();
    	if (rows && rows.length > 0) {
    		for (var i=0; i<rows.length; i++) {
    			grid.deleteRow(rows[i]);
    		}
    	}
    }
    
    function initGridAssignTime() {
    	gridAssignTime = Grid( {
			id : "gridAssignTime",
	        placeAt : grid_assign_time_id,
	        multi:true,
	        pagination : false,
	        layout : [{
	            name:"开始时间", field:"beginTime"
	        }, {
	            name:"结束时间", field:"endTime"
	        }],
	        toolbar:[
	            {name:"添加",icon:"fa fa-plus-circle",callback:function(){ 
	            	addAssignTime();
	            }},
	            {name:"删除",icon:"fa fa-trash-o",callback:function(){
	            	delAssignTime();
	            }}
	        ],
	        data:[]
    	})
    }
    
    function addAssignTime() {
    	var slidebar = Util.slidebar({
    		url : getServer() + "/static/core/system/worktime/views/assign_time.html",
   		 	width : "500px",
	        afterLoad : function() {
	        	//初始化时间
    			$(".dayTime").clockpicker();
    			//监听确定按钮
    			$("#" + btn_day_time_save_id).on("click", function(){
    				//开始时间
    				var start = $("#" + text_day_time_begin_id).val();
    				//结束时间
    				var end = $("#" + text_day_time_end_id).val();
					gridAssignTime.appendRow({
						beginTime : start,
						endTime : end
					});
    				slidebar.close();
    			})
	        }
    	});
    }
    
    function delAssignTime() {
    	var grid = Grid.getGrid("gridAssignTime");
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