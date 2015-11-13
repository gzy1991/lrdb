/**
 * 
 */

define(['jquery','static/app/uploadTest/single-uploader'],
        function($,singleUploader){
			
	var result= {};
	
	result.init =function($scope){
		singleUploader.init({
			pick : {
		        id : '#picker'      
		    },
		    type : {
		        preview : true  
		    },
		    data : {
		    	fileId : 'ABCDEFG',
		    	size : 22.22,
		    	detailFormat : ['76020'],
		    	detailName : 'name1'
		    },
		    edit : true,          
		    uploader : 'uploader' 
		},$scope);
		singleUploader.init({
			pick : {
		        id : '#picker2'      
		    },
		    type : {
		        preview : true,
		        id : '#preview'
		    },
		    edit : false,          
		    uploader : 'uploader2' 
		},$scope);
		
		$('#example1').click(function(){
			singleUploader.getData($scope,'uploader');
			console.info($scope.uploader);
		});
		
		$('#example2').click(function(){
			singleUploader.getData($scope,'uploader2');
			console.info($scope.uploader2);
		});
	};
	
	return result;
});