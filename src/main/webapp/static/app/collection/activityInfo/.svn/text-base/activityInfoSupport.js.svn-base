define(['jquery','PDUtilDir/util','PDUtilDir/grid','LrdbActDir/processTrackSupport',
        'LrdbCommonDir/dict','PDUtilDir/inputSelect','PDUtilDir/typeahead','LrdbCommonDir/uploader/multi-uploader'],
		function($,Util,Grid,ProcessTrackSupport,Dict,InputSelect,Typeahead,Multiuploader){	
	var result = {};
	var gridInstance;
	result.activityInfoListInit = function($scope){
		var config = {
				id:'activityInfoList',
				placeAt:'activityInfoList',
				pageSize:10,
				index:'checkbox', 
			    multi:true,      
				layout:[{name:'活动名称',field:'activityName',click:function(e){
					plusDataInit($scope);
					getActivityById($scope,e);
					showViewActRecsSlidebar($scope);
					$scope.$digest();				       
					}},
				        {name:'艺术类型',field:'arttypeDict'},
				        {name:'活动类型',field:'acttypeDict'},				     
				        {name:'开始时间',field:'activityBeginDate',callback:function(obj){
				       
				        }},
				        {name:'结束时间',field:'activityEndDate',callback:function(obj){
				        
				        }},
				        {name:'采集人员',field:'createUser'},
				        {name:'操作人员',field:'lastmodifyUser'},
				        {name:'操作时间',field:'lastmodifyTime',callback:function(obj){
				        }}				   
				      ],
				toolbar:[{name:'添加',icon:'fa fa-plus-circle',callback:function(){		
					 plusDataInit($scope);
					 showPlusActRecsSlidebar($scope);
					 $scope.$digest();							 					 
				    }},						    
					{name:'删除',icon:'fa fa-trash-o',callback:function(){
						delActivityReconds();					
					}},					
					{name:'跟踪',icon:'fa fa-bar-chart',callback:function(){
						showProcessTrackSlidebar($scope);									
					}},
					{name:'查询',icon:'fa fa-search',callback:$scope.activityInfo.query.query},	
					
					{name:'重置',icon:'fa fa-repeat',callback:$scope.activityInfo.query.reset}
					],
				  data : {type : 'URL' ,
					      value : getServer() + '/sword/activityInfoService/getActivityInfoList'},				    								
				  queryParam : {//向后台传参
					  activityName : $scope.activityInfo.query.dto.activityName,
					  actArtType : $scope.activityInfo.query.dto.actArtType,
					  activityType : $scope.activityInfo.query.dto.activityType,					
					  beginData : $scope.activityInfo.query.dto.beginData,
					  endData : $scope.activityInfo.query.dto.endData					
		          }		
		};
		 gridInstance = Grid.init(config);
	};
	  var disposeSite = function($scope){
          var arrUnit = [];           
         	 var tempActSite=[];	    	  
	    	  if(String($scope.activityInfo.entity.activitySite).search(/,/) != -1) {
	    		  tempActSite =  $scope.activityInfo.entity.activitySite.split(',');
	    		  for(var i = 0; i < tempActSite.length; i++)
	    			  	arrUnit.push({'activitySite':tempActSite[i]});  
	    	  }else {
	    		  arrUnit.push({'activitySite':$scope.activityInfo.entity.activitySite});  		  
	    	  }	    		
          return arrUnit;
      };      
      var disposeSponsor = function($scope){
          var arrUnit = [];   
          if(!isNaN($scope.activityInfo.entity.actSponsor)){
    		  arrUnit.push({'sponsorMix':$scope.activityInfo.entity.actSponsor});
    	  } else{
    		  arrUnit.push({'sponsorId':$scope.activityInfo.entity.actSponsor});
    	  }	  
          for(var i = 0 ; i < ($scope.activityInfo.actSponsorOrgs).length;  i++){  	  
        	  if(!isNaN($scope.activityInfo.actSponsorOrgs[i].actSponsorRe)){
        		  arrUnit.push({'sponsorMix':$scope.activityInfo.actSponsorOrgs[i].actSponsorRe});
        	  } else{
        		  arrUnit.push({'sponsorId':$scope.activityInfo.actSponsorOrgs[i].actSponsorRe});
        	  }	  
          }
    	  return arrUnit;
      };
      var disposeOrganizer = function($scope){
          var arrUnit = [];   
          if(!isNaN($scope.activityInfo.entity.actOrganizer)){
    		  arrUnit.push({'sponsorMix':$scope.activityInfo.entity.actOrganizer});
    	  } else{
    		  arrUnit.push({'sponsorId':$scope.activityInfo.entity.actOrganizer});
    	  }	  
          for(var i = 0 ; i < ($scope.activityInfo.actOrganizerOrgs).length;  i++){  	  
        	  if(!isNaN($scope.activityInfo.actOrganizerOrgs[i].actOrganizerRe)){
        		  arrUnit.push({'sponsorMix':$scope.activityInfo.actOrganizerOrgs[i].actOrganizerRe});
        	  } else{
        		  arrUnit.push({'sponsorId':$scope.activityInfo.actOrganizerOrgs[i].actOrganizerRe});
        	  }	  
          }
    	  return arrUnit;
      };
      var disposeCoOrganizer = function($scope){
          var arrUnit = [];   
          if(!isNaN($scope.activityInfo.entity.actCoOrganizer)){
    		  arrUnit.push({'sponsorMix':$scope.activityInfo.entity.actCoOrganizer});
    	  } else{
    		  arrUnit.push({'sponsorId':$scope.activityInfo.entity.actCoOrganizer});
    	  }	  
          for(var i = 0 ; i < ($scope.activityInfo.actCoOrganizerOrgs).length;  i++){  	  
        	  if(!isNaN($scope.activityInfo.actCoOrganizerOrgs[i].actOrganizerRe)){
        		  arrUnit.push({'sponsorMix':$scope.activityInfo.actCoOrganizerOrgs[i].actCoOrganizerRe});
        	  } else{
        		  arrUnit.push({'sponsorId':$scope.activityInfo.actCoOrganizerOrgs[i].actCoOrganizerRe});
        	  }	  
          }
    	  return arrUnit;
      };
      
     var disposePerson = function($scope){    	  

          var arrPerson = {};  
          var tmpPerson = [];
          for(var i = 0 ; i < ($scope.activityInfo.persionRels).length;  i++){  	  
        	  if(!isNaN($scope.activityInfo.persionRels[i].activityPersion)){
        		  arrPerson.personNameMix = $scope.activityInfo.persionRels[i].activityPersion;
        		  arrPerson.activityPersonTag = $scope.activityInfo.persionRels[i].activityPersionTag;
        		  arrPerson.activityPosition = $scope.activityInfo.persionRels[i].activityPosition;   
        	  } else{
        		  arrPerson.personId = $scope.activityInfo.persionRels[i].activityPersion;
        		  arrPerson.activityPersonTag = $scope.activityInfo.persionRels[i].activityPersionTag;
        		  arrPerson.activityPosition = $scope.activityInfo.persionRels[i].activityPosition;
        	  }	 
        	  tmpPerson.push(arrPerson);
          } 
          return tmpPerson;
      };
      
      var disposeOpusName = function($scope){    	  
          var arrOpus = {};  
          var tmpOpus = [];
          for(var i = 0 ; i < ($scope.activityInfo.OpusRels).length;  i++){  	  
        	  if(!isNaN($scope.activityInfo.OpusRels[i].activityPersion)){
        		  arrOpus.opusNameMix = $scope.activityInfo.OpusRels[i].actOpusName;
        		  arrOpus.activityOpusTag = $scope.activityInfo.OpusRels[i].actOpusTag;
        		  arrOpus.activityCategory = $scope.activityInfo.OpusRels[i].actOpusClassif;   
        	  } else{
        		  arrOpus.opusId = $scope.activityInfo.OpusRels[i].actOpusName;
        		  arrOpus.activityOpusTag = $scope.activityInfo.OpusRels[i].actOpusTag;
        		  arrOpus.activityCategory = $scope.activityInfo.OpusRels[i].actOpusClassif;
        	  }	 
        	  tmpOpus.push(arrOpus);
          } 
          return tmpOpus;
      };
      var disposeNew = function($scope){    	 
          var tmpNew = [];
          for(var i = 0 ; i < ($scope.activityInfo.NewsRels).length;  i++){  	  
        	  tmpNew.push({'newId':$scope.activityInfo.NewsRels[i].newsTitle});
        	  }	  
          return tmpNew;
      };
      
      var disposeJudge = function($scope){    	  
          var arrJudge = {};  
          var tmpJudge = [];
          for(var i = 0 ; i < ($scope.activityInfo.JudgesRels).length;  i++){  	  
        	  if(!isNaN($scope.activityInfo.JudgesRels[i].activityPersion)){
        		  arrJudge.judgesNameMix = $scope.activityInfo.JudgesRels[i].actJudgesName;
        		  arrJudge.judgeIntro = $scope.activityInfo.JudgesRels[i].actJudgesName;
        		  arrJudge.judgePosition = $scope.activityInfo.JudgesRels[i].actJudgesPostion; 
        		  arrJudge.judgeTag = $scope.activityInfo.JudgesRels[i].actJudgesTag;   
        		  
        	  } else{
        		  arrJudge.judgesNameMix = $scope.activityInfo.JudgesRels[i].actJudgesName;
        		  arrJudge.judgeIntro = $scope.activityInfo.JudgesRels[i].actJudgesName;
        		  arrJudge.judgePosition = $scope.activityInfo.JudgesRels[i].actJudgesPostion; 
        		  arrJudge.judgeTag = $scope.activityInfo.JudgesRels[i].actJudgesTag;   
        	  }	 
        	  tmpJudge.push(arrJudge);
          } 
          return tmpJudge;
      };
      var disposeFestival = function($scope){    	 
          var tmpFestival = [];
          for(var i = 0 ; i < ($scope.activityInfo.FestivalAwardRels).length;  i++){  	  
        	  tmpFestival.push({'festivalId':$scope.activityInfo.FestivalAwardRels[i].festivalAwardTitle});
        	  }	  
          return tmpFestival;
      };
      
      var disAwardTeamList = function($scope){
    	  activityInfo.AwardTeamRels;
    	  activityInfo.AwardTeamRels[$index].WinnerRels;
    	  
    	  
      }
	result.saveEntity = function($scope){
		
		$scope.activityInfo.entity.sitelist = disposeSite($scope);
		$scope.activityInfo.entity.sponsorList = disposeSponsor($scope);
		$scope.activityInfo.entity.organizerList = disposeOrganizer($scope);
		$scope.activityInfo.entity.coOrganizerList = disposeCoOrganizer($scope);
		$scope.activityInfo.entity.persionList = disposePerson($scope);
		$scope.activityInfo.entity.opusNameList = disposeOpusName($scope);		
		$scope.activityInfo.entity.newsList = disposeNew($scope);		
        $scope.activityInfo.entity.judgeList = disposeJudge($scope);
        $scope.activityInfo.entity.festivalawardList = disposeFestival($scope);
        //$scope.activityInfo.entity.awardTeamList = ;
        
    /*   	
		$scope.activityInfo.entity.awardTeamList = disposeOpusName($scope);
		awardList
		awardListOpus
		awardListOrgan
		awardListPerson*/
		
		$.ajax({
			url : getServer() + '/sword/activityInfoService/saveActivityInfo',
			type : 'POST',
			data : {		       
						activityInfo : JSON.stringify($scope.activityInfo.entity),	
			 
						
				},
			dataType : 'json',
			success : function(data){
				Util.alert('保存成功');
				result.activityInfoListInit($scope);
			}
		});		
	};		
	

	var getActivityById = function($scope,e) {
		  $.ajax({
	            url: getServer()+ '/sword/activityInfoService/queryActivityInfoById',
	            type:'POST',
	            async:false,
	            dataType:'json',
	            data:{
	            	activityId :  e.data.row.activityId	            	
	            },
	            success:function(d,e){
	            	  $scope.activityInfo.entity = d.curPageData[0];	            	   
	            	
	            }
	        });//end ajax
	};
	
	var plusDataInit = function($scope) {
		$scope.activityInfo.entity = {};
		
		$scope.activityInfo.persionRels = [] ,
		$scope.activityInfo.OpusRels = [],
		$scope.activityInfo.NewsRels = [],
		$scope.activityInfo.JudgesRels = [],
		$scope.activityInfo.FestivalAwardRels = [],
		$scope.activityInfo.AwardTeamRels = [],
		$scope.activityInfo.WinnerRels = [],
		$scope.activityInfo.actArtTypeCodes = [],	
		$scope.activityInfo.actTypeCodes = [],
		$scope.activityInfo.actLevelCodes = [],
		$scope.activityInfo.actNatureCodes = [],
		$scope.activityInfo.actProviceCodes = [],
		$scope.activityInfo.actCityCodes = [],
		$scope.activityInfo.actCoutryCodes = [],
		result.queryactArtTypeInit($scope);
		result.queryactTypeInit($scope);
		result.queryactLevelInit($scope);
		result.queryactNatureInit($scope);
		result.queryProviceInit($scope);
		result.queryCityInit($scope);
		result.queryCoutryInit($scope);
		result.queryProviceInit($scope);
		result.queryCityInit($scope);
		result.queryCoutryInit($scope);		
	};
////艺术类别初始化
	result.queryactArtTypeInit = function($scope){
		if(!$scope.activityInfo.actArtTypeCodes.length){
			Dict.queryDict(Dict.URL_ACT_ART_TYPE).done(function(data){
				$scope.activityInfo.actArtTypeCodes = data;
				$scope.$digest();
			});	
		}
	};
	
////活动类别初始化
	result.queryactTypeInit  = function($scope){
		if(!$scope.activityInfo.actTypeCodes.length){
			Dict.queryDict(Dict.URL_ACTIVITY_TYPES).done(function(data){
				$scope.activityInfo.actTypeCodes = data;
				$scope.$digest();
			});
		}	
	};
	////活动级别初始化
	result.queryactLevelInit  = function($scope){
		if(!$scope.activityInfo.actLevelCodes.length){
			Dict.queryDict(Dict.URL_ACT_LEVEL_TYPES).done(function(data){
				$scope.activityInfo.actLevelCodes = data;
				$scope.$digest();
			});
		}	
	};
////活动性质初始化
	result.queryactNatureInit  = function($scope){
		if(!$scope.activityInfo.actNatureCodes.length){
			Dict.queryDict(Dict.URL_ACT_NATURE_TYPES).done(function(data){
				$scope.activityInfo.actNatureCodes = data;
				$scope.$digest();
			});
		}	
	};
////省名称初始化
	result.queryProviceInit  = function($scope){
		if(!$scope.activityInfo.actProviceCodes.length){
			Dict.queryDict(Dict.URL_PROVICE_TYPES).done(function(data){
				$scope.activityInfo.actProviceCodes = data;
				$scope.$digest();
			});
		}	
	};
////市名称初始化
	result.queryCityInit  = function($scope){
		if(!$scope.activityInfo.actCityCodes.length){
			Dict.queryDict(Dict.URL_CITY_TYPES).done(function(data){
				$scope.activityInfo.actCityCodes = data;
				$scope.$digest();
			});
		}	
	};
////县名称初始化
	result.queryCoutryInit  = function($scope){
		if(!$scope.activityInfo.actCoutryCodes.length){
			Dict.queryDict(Dict.URL_COUTRY_TYPES).done(function(data){
				$scope.activityInfo.actCoutryCodes = data;
				$scope.$digest();
			});
		}	
	};
	
	result.editAttachmentInit = function($scope){
		Multiuploader.init($scope,{
			edit : true,
			uploader : 'attachments',
			param : {
				placeAt : '#attachments',
				file : 'img'
			},
			template : {
				'detail-remark' : true
			},
			data : {
				123 : {
					fileId : 123,
					detailName : '插图1',
					detailFormat : ['76020000']
				}
			}
		});
	},
////////////////////
	//初始化基本信息页面--地点（数据项）提示列表
	/*result.initCreateSite = function($scope,index){
		var elment = 'createSiteIndex';
		if(!$scope.activityInfo.sites.length){
			Dict.queryDict(Dict.URL_SITE).done(function(data){
				$scope.activityInfo.sites = data;
				$scope.$digest();
			});
			$.ajax({
				url : Dict.URL_SITE,
				method : 'POST',
				dataType : 'json',
				async : false,
				success : function(data){
					$scope.activityInfo.sites = data;
				}
			});
		}
		if(index === '-1'){
			Typeahead({
				id : 'createSite',
				data : $scope.activityInfo.sites,
				filter : true,
				key : {
					id : 'id',
					data : 'data'
				},
				callback : function(data){
					$('#createSite').text(data.data);
				}
			});
			
		}else {
			Typeahead({
				id : 'createSiteIndex',
				data : $scope.activityInfo.sites,
				filter : true,
				key : {
					id : 'id',
					data : 'data'
				},
				callback : function(data){
					$('#createSiteIndex').text(data.data);
				}
			});
			Typeahead({
				id : elment,
				data : $scope.activityInfo.sites,
				filter : true,
				key : {
					id : 'id',
					data : 'data'
				},
				callback : function(data){
					$('#elment').text(data.data);
				}
			});
			
		}

	};*/
	
	result.initSiteTypehead = function($scope){
		$.ajax({
			url : Dict.URL_SITE,
	        type:'POST',
	        dataType:'json',
	        success:function(data){
				//设置资源数据
    		       $scope.typeaHeadSite.initConfig.data = data;
    		       $scope.$digest();
	        }
	    });  
		
	};
	
	
	result.mainQueryInitInput = function($scope){	
		result.queryactArtTypeInit($scope);
		result.queryactTypeInit($scope);
		result.queryactLevelInit($scope);
		result.queryactNatureInit($scope);
		result.queryProviceInit($scope);
		result.queryCityInit($scope);
		result.queryCoutryInit($scope);
		result.queryProviceInit($scope);
		result.queryCityInit($scope);
		result.queryCoutryInit($scope);		
	};
	//参与人员列表ng-repeat使用
	var getPersionRelsDataByActivityId = function(activityId,$scope){
		
        $.ajax({
            url:getServer()+ '/static/app/collection/activityInfo/data/persionSearch.json',
            type:'POST',
            async:false,
            dataType:'json',
            success:function(d){                  
                    $scope.activityInfo.persionRels[0] = d.curPageData[0];
                    $scope.$digest();
   
            }
        });
	};
	
   var getOpusRelsDataByActivityId = function(activityId,$scope){
		
        $.ajax({
            url:getServer()+'/static/app/collection/activityInfo/data/awardRecsList.json',
            type:'POST',
            async:false,
            dataType:'json',
            success:function(d){
                            
                    $scope.activityInfo.OpusRels[0]  = d.curPageData[0];
                    
        
            }
        });
	};
	
  var getNewsRelsDataByActivityId = function(activityId,$scope){
		
        $.ajax({
            url:getServer()+'/static/app/collection/activityInfo/data/awardRecsList.json',
            type:'POST',
            async:false,
            dataType:'json',
            success:function(d){                   
                    $scope.activityInfo.NewsRels[0]  = d.curPageData[0];
            }
        });
	};
	
	var getJudgesRelsDataByActivityId = function(activityId,$scope){
		
        $.ajax({
            url:getServer()+'/static/app/collection/activityInfo/data/awardRecsList.json',
            type:'POST',
            async:false,
            dataType:'json',
            success:function(d){
                    
                    $scope.activityInfo.JudgesRels[0]  = d.curPageData[0];

            }
        });
	};
	
	var getFestivalAwardRelsDataByActivityId = function(activityId,$scope){
		
        $.ajax({
            url:getServer()+'/static/app/collection/activityInfo/data/awardRecsList.json',
            type:'POST',
            async:false,
            dataType:'json',
            success:function(d){
              
                    $scope.activityInfo.FestivalAwardRels[0]  = d.curPageData[0];

            }
        });
	};
	
	var getAwardTeamRelsDataByActivityId = function(activityId,$scope){
		
        $.ajax({
            url:getServer()+'/static/app/collection/activityInfo/data/awardRecsList.json',
            type:'POST',
            async:false,
            dataType:'json',
            success:function(d){
                
                    $scope.activityInfo.OpusRels[0]  = d.curPageData[0];

            }
        });
	};

	
	var getWinnerRelsDataByActivityId = function(activityId,$scope){
		
        $.ajax({
            url:getServer()+'/static/app/collection/activityInfo/data/awardRecsList.json',
            type:'POST',
            async:false,
            dataType:'json',
            success:function(d){
                
                    $scope.activityInfo.WinnerRels[0] = d.curPageData[0];

            }
        });
	};
	 
	var showPlusActRecsSlidebar = function($scope){
		Util.slidebar({
			id:'activityInfoEditPanel',
			width:'800px'
			/*afterLoad:function(){
				validate();
			}*/
			
		});
		//result.initCreateSite($scope,'-1');
		result.initSiteTypehead($scope);
		result.editAttachmentInit($scope);
		
	};
	
	var showViewActRecsSlidebar = function($scope){
		Util.slidebar({
			id:'activityInfoEditPanel',
			/*url : getServer() + '/static/app/collection/activityInfo/views/activityView.html',*/
			width:'800px',
			close: true		
		});
		result.editAttachmentInit($scope);
	};
	
	var delActivityReconds = function(){
		var selected = gridInstance.getSelectedRow();
		if(selected.length){
			Util.confirm('确定删除记录？',function(){
				var activityIds = [];
				for(var i=0;i<selected.length;i++){
					activityIds.push(selected[i].activityId);
				}	
				 activityIds = activityIds.join(',');
				$.ajax({
					url : getServer() +  '/sword/activityInfoService/delActivityInfoByIds',
					type : 'POST',
					data : {activityIds : activityIds},
					dataType : 'json',
					success : function($scope){
						Util.alert('删除成功');
						result.activityInfoListInit($scope);
						$scope.$digest();
					}
				});
			});
		}else{
			Util.alert('请选择要删除的记录！');
		}
	};

	//流程追踪侧边栏
	var showProcessTrackSlidebar = function($scope){
		Util.slidebar({
			id:'activityProcessTrackId',
			width:'800px'
		});
		ProcessTrackSupport.ActivityListInit($scope);
	};	
	return result;
});