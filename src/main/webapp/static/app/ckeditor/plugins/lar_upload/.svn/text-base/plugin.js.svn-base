
(function()
{	
	function showUploadDialog( editor )
	{
		require(["PDUtilDir/dialog", "PDUtilDir/grid", "LrdbCommonDir/uploader/multi-uploader","LrdbUtilDir/searchBlock"],function(Dialog,Grid,multiUploader,SearchBlock)
		{
			var initGrid = function(){
				
				var config = {
						
		                id:'serchGridpicobjID',
		                placeAt:'encyclopedialPicFListId',            
		                pageSize:10,                                                       
		                index:'checkbox',//radio
						multi:'ture', 	                
		                layout:[                           
		                     {name:'文件名',field:'attachmentName'},
		                     {name:'文件大小',field:'attachmentSize'},
		                     {name:'文件类型',field:'attachmentType'},
		                     {name:'修改日期',field:'lastModifyTime'}
		                ],//end layout	
		                toolbar : [
						   {name : '查询',icon : 'fa fa-search',callback : function(){
							   
							   initGrid();
				        	   
				           }},
				           {name : '重置',icon : 'fa fa-repeat',callback : function(){
				        	   $('#picNameID').val('');
				           }}						   
						   ],
						   
						data : {type : 'URL',value : getServer()+'/sword/collection/encyclopedia/queryBypicName'},
			  			queryParam : {
			            	'attachmentName' : $('#picNameID').val()
			            }
		         	 
	            };
		        Grid.init(config);//渲染grid
			};
			
			var dialog = Dialog({
				
				id : 'uploadDialogInfoID',
				cache : false,
				title : '图片上传',
				width : '800px',
				url : getStaticPath() + '/app/common/ckeditor/views/uploadImg.html',
				
		  		buttons:[
		  		         {
		  		    	   name:'确定',
		  		    	   callback:function(dialog){
		  		    		   
		  		    		   	dialog.hide();
		 						var imageElement = editor.document.createElement( 'img' );
		 						var eleSelpic = editor.getSelection().getStartElement();
		 						imageElement.setAttribute( 'src', $("#queryPicLinksID").val() );
		 						eleSelpic.append(imageElement,true);
		 							
		  		    	   }
		   		         }
		  		       ],
		  		       
		  		 afterLoad:function(dialog){
		  			 
		  			SearchBlock.init("selPicFileId");
		  			initGrid();
			       	       
			        var noScopeObj = {};
				    multiUploader.init(noScopeObj,{
				    	edit : true,   //是否可编辑，默认为false
				    	uploader : 'multi-uploader2',  //实例化上传组件名称
				    	param : 
				    	{
				    	    placeAt : '#multi2'  //#id，多附件上传所在的DOM节点选择器
				    	},
				    	data : 
				    	{
			    	        ABCDEFG : {
			    	            fileId : 'ABCDEFG',
			    	            url : '',
			    	            'detailName' : 'multiTest1',
			    	            'detailFormat' : ['760004']
			    	        },
			    	        HIJKLMN : {
			    	            fileId : 'HIJKLMN',
			    	            url : '',
			    	            'detailName' : 'multiTest2',
			    	            'detailFormat' : ['760004888']
			    	        }
				    	 }
				    });
				        
		          }   	
		       });

			dialog.show();
			
		});
	}
	
	function execlrdbUpload( editor )
	{
		showUploadDialog(editor);
	}
	
	var lrdbUploadCommand = 
	{
		async : true,
		exec : function( editor ) {
			execlrdbUpload( editor );
		}
	};
	
	var uploadPluginN = 'lar_upload';
	
	CKEDITOR.plugins.add(uploadPluginN,
	{
		
		init : function( editor )
		{
			editor.addCommand( uploadPluginN, lrdbUploadCommand);
			editor.ui.addButton('Lar_upload',
			{
				label : "上传图片",
				command : uploadPluginN,
				icon : CKEDITOR.getUrl( this.path + 'images/lar_upload.gif' )
			});
		}
	});
	
})();

