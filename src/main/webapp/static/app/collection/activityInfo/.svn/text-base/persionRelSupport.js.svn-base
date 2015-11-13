
define(['jquery','PDUtilDir/grid','LrdbCommonDir/baseSupport','PDUtilDir/inputSelect',
        'PDUtilDir/util','PDUtilDir/dialog'],
		function($,Grid,BaseSupport,InputSelect,Util,Dialog){ 	       
	var result = {};
	var persionGrid;
    result.persionListInit = function(id,$scope){		   
    	  var config = {
	                id:'persionList',
	                placeAt:'persionListId',           
	                pageSize:10,                                                         
	                //index:'radio',
	                index:'checkbox',
					multi:'false', 	                
	                layout:[                         
	                    {name:'姓名',field:'persionName'},
	                    {name:'年龄',field:'birthdayYear',format:function(obj){//
	                    	//此处待优化
	                    	var curDate = new Date();
	                    	var curYear = curDate.getFullYear();
	                    	var year=obj.row.birthdayYear;
	                    	var age=curYear-year+1;
	                    	var result = year===null?'':age;
	                    	return result;
	                    }},
	                    {name:'性别',field:'sexName'},
	                    {name:'所在地',field:'birthPlaceName'},
	                    {name:'艺术类别',field:'artTypeNames'}
	                ],
	    	      	   
	    	        data : {type : 'URL' , value : getServer() + '/static/app/collection/activityInfo/data/persionRecsList.json'} //指定获取列表数据的url	    	        
	      
            };
	        persionGrid = Grid.init(config);//渲染grid
    };  
    
    result.pushPersion = function($scope,index){
		var exist = 0;
		var selected ;
		selected = persionGrid.getSelectedRow();
		if (selected.length == 1) {	
			if(index >= 0){
				$scope.activityInfo.actPersionOrgs[index].actPersionRe = selected[0].persionName;
				$scope.activityInfo.actPersionOrgs[index].activityPersionTag = selected[0].persionName;
				$scope.$digest();
				Util.alert('添加关联成功');		
			} else {
				$scope.activityInfo.tempPerionRel.activityPersion = selected[0].persionName;
				$scope.activityInfo.tempPerionRel.activityPersionTag = selected[0].persionName;
				$scope.$digest();
				Util.alert('添加关联成功');		
			}						
		} else if(selected.length < 1) {
			Util.alert('未勾选资源');
		} else {
			Util.alert('只能勾选一个');
		}
	};		

	result.showDialog = function($compile,$scope,index){
		 var dialog = Dialog({	 
	    			id : 'persionListDialog',
	    			cache : false,
	    			title : '选择参与人员',
	    			width : '800px',
	    			$compile : $compile,
	    			$scope : $scope,
	    			url:$scope.activityInfo.template.persionChoose,
			  		buttons:[
			  		         {
			  		    	   name:'确定',
			  		    	   callback:function(dialog){
			  		    		 result.pushPersion($scope,index);
		 	  		    		 dialog.hide();
			  		    	   }
			   		         }
			  		       ],
			  		 afterLoad:function(dialog){				 		 	
			  			 result.persionListInit('',$scope);			  						  			 
	                 }   	
	            });

		    dialog.show();
	};		 	
	//弹出编辑参与人员信息对话框
	result.editPerionRel=function($compile,$scope,oldPerionRelObj){
		$scope.oldObj.oldPerionRelObj=oldPerionRelObj;
		//弹出新增dialog   该弹出窗口中可以使用作用域的值 实现双向数据绑定
        BaseSupport.contentDialog($compile,$scope,{
	    	setting :{
	    		    id : 'persionRelEditDialog' ,
			  		title: '编辑参与人员信息',
			  		modal:{backdrop:'static'},//则点击空白不自动关闭
			  		buttons:[
			  		       {
			  		    	   name:'保存',			 		    	  
			  		    	   callback:function(dialog){
			  		    		   if($('#activityPersionRelFormId').valid()){
			  		    			   if($scope.oldObj.oldPerionRelObj){//编辑
					  		    		
					  		    		   //查找对象在职位数组中的索引
					  		    		   var index=$scope.activityInfo.persionRels.indexOf($scope.oldObj.oldPerionRelObj);		  		   		
					  		    		  
					  		    		   var tmpPersionRels ={};
						  		    	   tmpPersionRels = mergePersionRels($scope);						  		 			  		    		   
						  		    	   $scope.$apply(function (){
							  		    		//将修改的值重新放回数组中
						  		    			$scope.activityInfo.persionRels.splice(index,1,tmpPersionRels);
						  		    	   });						  		    	   						  		    	   
					  		    			//执行完后初始化该值
					  		    		   $scope.oldObj.oldPerionRelObj=null;
					  		    		   
			  		    			   }else{//新增
						  		    	   $scope.$apply(function (){
						  		    		   //将新增页面接受到的值传递给作品关联数组		
						  		    		   
						  		    		// 将填写完毕的参与人员姓名、标签页分别作拼接，以便在记录中一个子里显示  
						  		    	   var tmpPersionRels ={};
						  		    	   tmpPersionRels = mergePersionRels($scope);
						  		    	   $scope.activityInfo.persionRels.push(tmpPersionRels);
						  		    	   
						    		       });
						  		    	   
						  		    	   $scope.$digest();
			  		    			   }
						  		       dialog.hide();//关闭对话框
			  		    		   }
			  		    	   }
			   		       }
			  		 ]
	       },
	  	  template: 'static/app/collection/activityInfo/views/addRelPerson.html',
	      afterLoad:function(dialog){
	    	  //validate();//调用校验
	      }
        });
	};
	  //各参与人员的信息填写完毕后，拼接填写的多个姓名，同时 ，将拼接前后的姓名、标签的值写入参与活动人员信息数组persionRels中
	var mergePersionRels = function($scope){		  
		   var persions=$scope.activityInfo.tempPerionRel.activityPersion;	           
	    	   for(i =0; i < $scope.activityInfo.actPersionOrgs.length; i ++)
	    			 persions +=','+ $scope.activityInfo.actPersionOrgs[i].actPersionRe ;		    	   
 	       if(!$scope.activityInfo.tempPerionRel.activityPersionTag)
	    		  $scope.activityInfo.tempPerionRel.activityPersionTag = '';
	
 	       var persionTag=$scope.activityInfo.tempPerionRel.activityPersionTag;	           
 	      for(i =0; i < $scope.activityInfo.actPersionOrgs.length; i ++)
 	    	  persionTag +=','+ $scope.activityInfo.actPersionOrgs[i].activityPersionTag ;		    	   
      
 	      if(!$scope.activityInfo.tempPerionRel.activityPersion)
 		      $scope.activityInfo.tempPerionRel.activityPersion = '';
	    	   //将拼接后的姓名、标签，以及拼接前的姓名和标签的值写入参与活动人员信息数组persionRels中
	    	   var tmpPersionRels ={};
	    	   tmpPersionRels.activityTitle = $scope.activityInfo.tempPerionRel.activityTitle;
	    	   tmpPersionRels.activityPersion = persions;
	    	   tmpPersionRels.activityPersionTag = persionTag;
	    	   tmpPersionRels.tmpPerionRel = $scope.activityInfo.tempPerionRel;
	    	   tmpPersionRels.tmpactPersionOrgs = $scope.activityInfo.actPersionOrgs;		    	
	       return tmpPersionRels;	    	  		
	};		
    var validate = function(){
        $('#activityPersionRelFormId').validate({
            rules:{//要校验的字段及校验规则
            	
                persionName:{//参与时间
                	required:true
                }             
            },
            messages: {
            }       
        });       
    };
    
     return result ;
     
});
