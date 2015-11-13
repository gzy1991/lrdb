
define(['jquery','PDUtilDir/grid','PDUtilDir/util','LrdbCommonDir/record/record','PDUtilDir/inputSelect','LrdbCommonDir/dict',
        'PDUtilDir/uploader/fileUploader',getServer()+'/static/app/ckeditor/ckeditor.js'],
	function($,Grid,Util,Record,inputSelect,dict,uploader){
	
		var result = {};
		
		var docGrid = '';
		
		var editor = ''; 
		
		var GPanelType = '';
		
		//var dialog;
		var gridInit = function($scope){
			
			var config = {
				
				id : 'encyclopediaGridId',
				placeAt : 'encyclopediaList',
				pageSize : 10,
				multi : true,
				pagination : true,
				cache : false,
				layout :[{name : '百科标题',field : 'encyclopediaTitle',click:function(e){
					
						  GPanelType='encyclopediaEditPanel';
						  geteditorData($scope,e.data.row.encyclopediaId);	
						  showSlidebar($scope, GPanelType,e.data.row.encyclopediaId);
				
						}
						/*{name : '采集人员',field : 'collection_user'},*/
				},{
					name : '艺术类别' , field : 'artTypeDict'
				},{
					name : '百科分类' , field : 'encyclopediaTypeDict'
				},{
					name : '来源' , field : 'encyclopediaSource'
				},{
					name : '操作人员' , field : 'createUser'
				},{
					name : '采集时间' , field : 'createTime'
				}],
				toolbar : [{
					name : '添加' , icon : 'fa fa-plus-circle' , callback : function(e){
							resetenclopdiadata($scope);
							var PanelType = 'encyclopediaAddEntityPanel';
							GPanelType = PanelType;
							showSlidebar($scope, PanelType,''); 
				    }},{
				    	  name : '删除',icon : 'fa fa-trash-o',callback : function(){
					    	   var selected = docGrid.getSelectedRow();
				        	   delDoc($scope,selected);
							   $scope.$digest();
					}},{
						name : '预览',icon : 'fa fa-search',callback : function(){
							   previewEditor($scope);
					}},{
						name : '跟踪',icon : 'fa fa-repeat',callback : function(){
							  /* Record.instance({
									$scope:$scope, 
									$compile:$compile,
									model:'s'
								});*/
					}},{
						name : '查询',icon : 'fa fa-search',callback : function(){
							  
							   gridInit($scope);
				        	   
				    }},{
				    	name : '重置',icon : 'fa fa-repeat',callback : function(){
				        	   $scope.encyclopedia.queryCondition.reset();
				        	   $scope.$digest();
				    }}],
				data : {
					type : 'URL',value : getServer()+'/sword/collection/encyclopedia/list'
				},
				queryParam : {
	            	'encyclopediaTitle' : $scope.encyclopedia.queryCondition.conditions.encyclopediaTitle,
	            	'encyclopediaSource' : $scope.encyclopedia.queryCondition.conditions.encyclopediaSource,
	            	'artTypeDict' : $scope.encyclopedia.queryCondition.conditions.artTypeDict,
	            	'encyclopediaTypeDict' : $scope.encyclopedia.queryCondition.conditions.encyclopediaTypeDict
	            }
			};
			
			docGrid = Grid.init(config);
		};
		
		
		//删除功能
		var delDoc = function($scope,selected){
			
			if (selected.length) {
				
				Util.confirm('确定删除选中选中记录吗？',function(){
					
					var arrID = [];
					$.each(selected, function(i, e){
						
						arrID.push(e.encyclopediaId);
					});

					$.ajax({
			            url: getServer()+'/sword/collection/encyclopedia/delete',
			            data:
			            {
			            	'encyclopediaId' : arrID.join(',')
			            	
			            },
			            type: 'POST',
			            async: false,
			            dataType: 'json',
			            success : function(data){
			            	
			            	Util.alert('删除成功');
			            	gridInit($scope);
			            	
			            }
			        });
				});
			} else {
				Util.alert('请选择需要删除的记录');
			}
		};
		
		var initEditor = function(){
			
			if (editor){
				editor.destroy();
			}
			editor = CKEDITOR.replace('content');
			CKEDITOR.config.height = 330;
			//bInit = true;
		};
		
		//弹出编辑侧边栏
		var showSlidebar = function($scope,PanelType,selRowID) {
			
			var selPanelID = ('encyclopediaTracePanel'== PanelType) ? 'encyclopediaTracePanel' : 'encyclopediaEditPanel';
			
			var config = {
					
				id : selPanelID,
				width: '700px',
				afterLoad: function () { 
					
	    			if ('encyclopediaAddEntityPanel' == GPanelType)
	    			{
	    				initEditor();
	    				$('#saveID').show();
	    				$('#updataID').hide();
		    			$.ajax({
		    				url : dict.URL_ENCYCLOPEDIA_INITEDITOR,
		    				method : 'GET',
		    				dataType : 'html',
		    				success : function(data){
		    					editor.setData(data);
		    				}
		    			});
	    			}else if ('encyclopediaEditPanel' == GPanelType){
	    				
	    				$('#saveID').hide();
	    				$('#updataID').show();   				
	    			}
	    			
	    			$scope.$digest();
				}
			};
			
			Util.slidebar(config);

		};

		var iniencyclopediaEntity = function($scope){
			
			$scope.encyclopedia.entity.encyclopediaContent = editor.getData();
		};
		
		var resetenclopdiadata = function($scope){
			$scope.encyclopedia.entity = {};	
		};
		
		result.saveEncyclopediaEntityInfo = function($scope){
			iniencyclopediaEntity($scope);
			ajaxEncyclopedialInfo($scope);
		};
		
		var geteditorData = function($scope,selectedRowID){
			
			initEditor();
			$.ajax({
	            url: getServer()+'/sword/collection/encyclopedia/queryById',
	            data:
	            {
	            	encyclopediaId : selectedRowID
	            },
	            type: 'POST',
	            async: false,
	            dataType: 'json',
	            success : function(data){	 
	            	
	            	$scope.encyclopedia.entity = data.entity;
	            	editor.setData($scope.encyclopedia.entity.encyclopediaContent);
        			$scope.$digest();
	                
	            }
	            
	        });
		};
		
		var ajaxEncyclopedialInfo = function($scope){
			
			$.ajax({
		            url: getServer()+'/sword/collection/encyclopedia/saveOrUpdate', 
		            data : {entityInfo : JSON.stringify($scope.encyclopedia.entity)},
		            type: 'POST',
		            async: false,
		            dataType: 'json',
		            success: function(data){
		            	Util.alert('保存操作成功');
		            	gridInit($scope);
		            	
		            }
		        });
		};
		
		result.updataEncyclopediaEntityInfo = function($scope){
			
			iniencyclopediaEntity($scope);
			if ( '' !== $scope.encyclopedia.entity.encyclopediaId ){
				ajaxEncyclopedialInfo($scope);
			}
			
		};
		
		var previewEditor = function($scope){
			
			var selected = docGrid.getSelectedRow();
			if ( selected.length>0 ){
				
				geteditorData($scope,selected[selected.length-1].encyclopediaId);
				
				var sHTML,
				config = editor.config,
				baseTag = config.baseHref ? '<base href="' + config.baseHref + '"/>' : '';

				var bodyHtml = '<body ',
						body = editor.document && editor.document.getBody();
	
				if ( body )
				{
					if ( body.getAttribute( 'id' ) ){
						bodyHtml += 'id="' + body.getAttribute( 'id' ) + '" ';
					}
						
					if ( body.getAttribute( 'class' ) ){
						bodyHtml += 'class="' + body.getAttribute( 'class' ) + '" ';
					}
						
				}
	
				bodyHtml += '>';
				
				sHTML =
					editor.config.docType +
					'<html dir="' + editor.config.contentsLangDirection + '">' +
					'<head>' +
					baseTag +
					'<title>' + '预览' + '</title>' +
					CKEDITOR.tools.buildStyleHtml( editor.config.contentsCss ) +
					'</head>' + bodyHtml +
					editor.getData() +
					'</body></html>';
	
				var iWidth	= 640,	// 800 * 0.8,
					iHeight	= 420,	// 600 * 0.7,
					iLeft	= 80;	// (800 - 0.8 * 800) /2 = 800 * 0.1.
				try
				{
					var screen = window.screen;
					iWidth = Math.round( screen.width * 0.8 );
					iHeight = Math.round( screen.height * 0.7 );
					iLeft = Math.round( screen.width * 0.1 );
				}
				catch ( e ){}
				
				var oWindow = window.open( '', null, 'toolbar=yes,location=no,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width=' +
					iWidth + ',height=' + iHeight + ',left=' + iLeft );
				oWindow.document.open();
				oWindow.document.write( sHTML );
				oWindow.document.close();
				
			  }else {
				  //bInit = false;
				  Util.alert('请先选择记录');
			  }
			
		};
		
		//检索条件区域初期化
		result.initQuery = function($scope){};
		
		//控制器初始化函数
		result.init = function($scope){
			gridInit($scope);
		};

		result.queryEncyclopediaTypes = function($scope){
			dict.queryDict(dict.URL_ENCYCLOPEDIA_TYPE).done(function(data){
				$scope.encyclopedia.encyclopediaType = data;
				$scope.$digest();
			});
		};
		
		result.queryArtTypes = function($scope){
			dict.queryDict(dict.URL_ENCYCLOPEDIA_TYPE).done(function(data){
				$scope.encyclopedia.artTypeCodes = data;
				$scope.$digest();
			});
		};
		return result;
	}
);