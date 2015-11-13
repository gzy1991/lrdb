/**
 * 
 */

define(['jquery','LrdbCommonDir/uploader/multi-uploader'],
        function($,multiUploader){
			
	var result= {};
	
	result.init =function($scope){
		multiUploader.init($scope,{
		    edit : true,   //是否可编辑，默认为false
		    uploader : 'multi-uploader',  //实例化上传组件名称
		    param : {
		        placeAt : '#multi'  //#id，多附件上传所在的DOM节点选择器
		    },
		    data : {
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
		
		multiUploader.init($scope,{
		    uploader : 'multi-uploader2',  //实例化上传组件名称
		    param : {
		        placeAt : '#multi2'  //#id，多附件上传所在的DOM节点选择器
		    },
		    data : {
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
		
		$('#button1').click(function(){
			multiUploader.getAllData($scope,'multi-uploader');
			console.info($scope['multi-uploader']);
		});
		
		$('#button2').click(function(){
			multiUploader.getAllData($scope,'multi-uploader2');
			console.info($scope['multi-uploader2']);
		});
	};
	
	return result;
});