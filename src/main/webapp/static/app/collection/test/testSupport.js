/**
 * 
 */

define([ 'jquery',
            'PDUtilDir/grid',
            'PDUtilDir/util',
            'PDUtilDir/dialog',
            "PDUtilDir/slidebar"],
            function($,Grid,Util,Dialog,Slidebar){
	
	var result = {};
	
	var testGrid = {};
	
	result.init = function($compile,$scope){
		var config = {
				id : 'testGrid',
				placeAt : 'testGrid',
				index:true,
		        multi:true,
		        pagination : true,
		        cache:false,
				layout : [{
					name : '测试ID', field:'testId',click:function(e){
						showSlidebar($scope);
					}
				},{
					name : '测试Name',field:'testName'
				}],
				toolbar:[
				            {name:"添加",icon:"fa fa-plus-circle",callback:function(event){addGrid($compile,$scope);}},
				            {name:"删除",icon:"fa fa-trash-o",callback:function(event){delGrid($compile,$scope,grid);}},
				            {name:"编辑",icon:"fa fa-edit",callback:function(event){editGrid($compile,$scope,grid);}}   
				         ],
				data : 
			              {
			            	   type: 'URL',
			                    value: getServer() + '/sword/test/getTestAll'
			               }
		       };
		grid = Grid(config);
		testGrid = Grid(config);
/*		      $.ajax({
		    	  
			        url : getServer() + "/sword/test/getTestAll",
			        data : {
			                  },
		         	success : function(data) {
				
				    Grid($.extend(config, {
					data:data
				}));

			}
		})*/
	};
	
	var showSlidebar = function($scope){
		var config = {
				id : 'testEditPanel',
				width : '900px',
				afterLoad : function(){
					
				}
		};
		Util.slidebar(config);
	};
	
	var showDialog = function($compile,$scope){
		var dialog = Dialog({
			id : 'editWinnerGroup',
			cache : false,
			title : '编辑奖项分组信息',
			width : '800px',
			$compile : $compile,
			$scope : $scope,
			url : $scope.test.template.testEdit,
            buttons:[{name:'确定',callback:function(){
            			dialog.hide();
	                }}
            ],
            afterLoad:function(){
            }
        });
        dialog.show();
	};
	
	/*显示添加dialog*/
    function addGrid($compile,$scope){
    	var config = {
    			$scope : $scope,
    			$compile:$compile,
				title : "添加",
				template : $scope.test.template.addEdit,//"/sword-web-core/static/app/yaosiyu/views/addAPerson.html",
				
				afterLoad : function(dialog) {
					$("#saveButton").on("click",function(){
						var testId = $("#testId").val();
						var testName = $("#testName").val();
						var obj = {
								testId : testId,
								testName : testName
						};
						$.ajax({
							url : getServer() + '/sword/test/addTest',
							data : obj,
							success : function(data){
								
								if(data.status =='200'){
			                        Util.alert('添加成功!');
			                    }else{
			                        Util.alert('添加失败!');
			                    }
							}
						});
					});
				}
			};
		Util.contentDialog(config);
    };
    
    /*编辑表格数据*/
    function editGrid($compile,$scope,grid){
    	var row=grid.getSelectedRow();
    	console.log("grid:"+grid);
    	console.log("row:"+row);
    	if(row==null || row.length!=1){
    		Util.alert("请选择并且只能选中一行数据");
    		return;
    	}
    	var slidebar = Slidebar({
    		url : $scope.test.template.editAPerson,
    		width: 500,
    		close:true,
    		afterLoad: function($Panel){    
				$("#newId").val(row[0].testId);
				$("#newName").val(row[0].testName);

    			$("#saveButton").on("click",function(){
    				var oldId=row[0].testId;
    				var newId=$("#newId").val();
    				var newName=$("#newName").val();
    				var obj = {
    						oldId : oldId,
    						newId  : newId,
    						newName : newName
    				};
    				$.ajax({
    					url: getServer()+'/sword/test/editTest',
    					data: obj,
    					success: function(data){
    						if(data.status =='200'){
		                        Util.alert('修改成功!');
		                    }else{
		                        Util.alert('修改失败!');
		                    }
    					}
    				});
    			})
    		}
    	})
    }
    
    /*删除*/
    function delGrid($compile,$scope,grid){
        var selected = testGrid.getSelectedRow();
        var num=selected.length;

        if (selected.length) {
            Util.confirm('确定要删除选择的数据吗?', function () {
                var periodicalIds = [];
                for (var i = 0, item; item = selected[i++];) {
                    periodicalIds.push(item.testId);
                }
                var ids = periodicalIds.join(',');
                $.post(getServer()+"/sword/test/delTest", "periodicalIds=" + ids).done(function (data) {
                    if(data.status ==='200'){
                        Util.alert('删除成功!');
                    }else{
                        Util.alert('删除失败!');
                    }
                    //刷新grid
                    gridInit($compile,$scope);
                });
            })
        }else{
            Util.alert('请选择要删除的数据!');
        }
    };
    
	result.save = function($scope){
		var obj = {
				testId : 'testId',
				testName : 'testName',
				list : [{testId:'gzy1',testName:'gzy2'},{testId:'gzy3',testName:'gzy4'}]
		};
		$.ajax({
			url : getServer() + '/sword/test/getTestAll',
			data : {ysy : JSON.stringify(obj)},
			success : function(data){
				console.info(data);
				var res = data.entity.list[0];
			}
		});
	};
	
	return result;
});