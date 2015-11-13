
define(['jquery','PDUtilDir/grid','LrdbCommonDir/baseSupport',
        'PDUtilDir/inputSelect','PDUtilDir/util','LrdbCommonDir/utils','PDUtilDir/dialog'],
		function($,Grid,BaseSupport,InputSelect,Util,Utils,Dialog){ 	       
	var result = {};
	var opusGrid;	
    result.opusListInit = function(id,$scope){		 
    	  var config = {
	                id:'opusList',
	                placeAt:'opusListId',             
	                pageSize:10,                                                        
	                index:'checkbox',
					multi:'ture', 	                
	                layout:[                          
	                      {name:'作品名称',field:'opusName'},
	                      {name:'主题',field:'topic'},
	                      {name:'出处',field:'masterParticipants'},
	                      {name:'创作时间',format:function(data){
	               
	                      return Utils.handleDate(data.row.creationYear,data.row.creationMonth,data.row.creationDay);
	                       }},
	                      {name:'发表时间',format:function(data){
	                               	                	
	                      return Utils.handleDate(data.row.issuanceYear,data.row.issuanceMonth,data.row.issuanceDay);
	                      }}
	                ],	    	 
    	         data : {type : 'URL' , value : getServer() + '/static/app/collection/activityInfo/data/opusRecsList.json'} //指定获取列表数据的url         	
            };
	       opusGrid = Grid.init(config);//渲染grid
    };
    
    result.pushOpus = function($scope){
		var exist = 0;
		var selected ;
		selected = opusGrid.getSelectedRow();
		if (selected.length == 1) {	
			  $scope.activityInfo.tempOpusRel.actOpusName = selected[0].opusName;
			  $scope.activityInfo.tempOpusRel.actOpusTag = selected[0].opusName;
			  $scope.$digest();
			  Util.alert('添加关联成功');
		
		} else if(selected.length < 1) {
			Util.alert('未勾选资源');
		} else {
			Util.alert('只能勾选一个');
		}
	};		

	result.showDialog = function($compile,$scope){
		 var dialog = Dialog({	 
	    			id : 'opusListDialog',
	    			cache : false,
	    			title : '选择作品',
	    			width : '800px',
	    			$compile : $compile,
	    			$scope : $scope,
	    			url:$scope.activityInfo.template.opusChoose,
			  		buttons:[
			  		         {
			  		    	   name:'确定',
			  		    	   callback:function(dialog){
			  		    		 result.pushOpus($scope);
		 	  		    		 dialog.hide();
			  		    	   }
			   		         }
			  		       ],
			  		 afterLoad:function(dialog){				 		 	
			  			 result.opusListInit('',$scope);			  						  			 
	                 }   	
	            });

		    dialog.show();
	};   
	
	//弹出编辑作品
	result.editOpusRel=function($compile,$scope,oldOpusRelObj){
		$scope.oldObj.oldOpusRelObj=oldOpusRelObj;
        BaseSupport.contentDialog($compile,$scope,{
	    	setting :{
	    		    id : 'judgesRelEditDialog' ,
			  		title: '编辑作品信息',
			  		modal:{backdrop:'static'},//则点击空白不自动关闭
			  		buttons:[
			  		       {
			  		    	   name:'保存',			 		    	  
			  		    	   callback:function(dialog){			  		    		   
			  		    		  /* if($('#activityOpusRelFormId').validate()){*/
			  		    			   if($scope.oldObj.oldOpusRelObj){
					  		    		   var newObj = $scope.activityInfo.tempOpusRel ;
					  		    		   //查找对象在职位数组中的索引
					  		    		   var index=$scope.activityInfo.OpusRels.indexOf(oldOpusRelObj);
						  		    	   $scope.$apply(function (){
							  		    		//将修改的值重新放回数组中
						  		    			$scope.activityInfo.OpusRels.splice(index,1,newObj);
						  		    	   });
					  		    			//执行完后初始化该值
					  		    		   $scope.oldObj.oldOpusRelObj=null;
			  		    			   }else{//新增
						  		    	   $scope.$apply(function (){
						  		    		   //将新增页面接受到的值传递给作品关联数组
						  		    		   $scope.activityInfo.OpusRels.push($scope.activityInfo.tempOpusRel);
				  		    		       });
			  		    			   }
						  		       dialog.hide();//关闭对话框
			  		    		   }
			  		    	   }
			   		     /*  }*/
			  		 ]
	       },
	  	  template: 'static/app/collection/activityInfo/views/addRelOpus.html',
	      afterLoad:function(dialog){
	    	  //validate();//调用校验
	      }
        });
	};
    var validate = function(){
        $('#activityOpusRelFormId').validate({
            rules:{//要校验的字段及校验规则
            	opusName : {//作品名称
            		required:true,
            		chineseLength:32
                }              
            },
            messages: {
            }
        });

    };
	
     return result;
});