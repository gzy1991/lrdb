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
    	initGridWorkhour();
    };
    
    /**
     * 变量
     */
    /*************主页相关**********/
    //表格-指定工作日
    var grid_workhour_id = "grid-workhour";
    /************添加时间页面相关******/
    var form_workhour_id = "form-workhour";
    var btn_day_time_save_id = "btn-day-time-save";
    
    var gridConfig = {
		id : "gridWorkhour",
        placeAt : grid_workhour_id,
        multi:true,
        pagination:false,
        layout : [{
            name:"开始时间", field:"beginTime",click:function(e){
            	updateWorkhour(e.data.row);
        	}
        },{
            name:"结束时间", field:"endTime"
        }],
        toolbar:[
            {name:"添加",icon:"fa fa-plus-circle",callback:function(){ 
            	addWorkhour();
            }},
            {name:"删除",icon:"fa fa-trash-o",callback:function(){
            	delWorkhour();
            }}
        ],
        data:[]
    } 
    
    function initGridWorkhour() {
    	$.ajax({
			url : getServer() + "/sword/worktime/getWorkhour",
			success : function(data) {
				Grid($.extend(gridConfig, {
					data:data
				}));
			}
		});
    }
    
    function addWorkhour() {
    	var slidebar = Util.slidebar({
   		 	url : getServer() + "/static/core/system/worktime/views/workhour.html",
   		 	width : "500px",
	        afterLoad : function() {
	        	//初始化时间
    			$(".dayTime").clockpicker();
    			//监听确定按钮
    			$("#" + btn_day_time_save_id).text("保存").on("click", function(){
    				var data = Tool.serialize(form_workhour_id);
    				$.ajax({
    	    			url : getServer() + "/sword/worktime/saveWorkhour",
    	    			data : data,
    	    			success : function(data) {
    	    				Util.alert(data.message);
    	    				if (data.success) {
    	    					slidebar.close();
    	    					initGridWorkhour();
    	    				}
    	    			}
    	    		})
					
    			})
	        }
    	});
    }
    
    function updateWorkhour() {
    	
    }
    
    function delWorkhour() {
		var rows = Grid.getGrid("gridWorkhour").getSelectedRow();
		if (rows && rows.length > 0) {
			Util.confirm("确定要删除指定的记录吗？", function() {
				var ids = "";
				$.each(rows, function(i, row){
					ids = ids.concat(row.id).concat(",");
				})
				$.ajax({
					url : getServer() + "/sword/worktime/deleteWorkhour",
					data : {
						ids : ids
					},
					success : function(data) {
						Util.alert(data.message);
						if (data.success) {
							initGridWorkhour();
						}
					}
				})
			});
		} else {
			Util.alert("请选择要删除的行记录");
		}
    }
    
    
    return {
        init:init
    }
});