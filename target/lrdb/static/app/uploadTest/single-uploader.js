/**
 * author@sarah
 */
/**
 * 以下列举几个常用示例
 * 示例1(编辑、有预览、无文件格式限制)：
   html部分：
  		<div class="form-horizontal">
    		<div class="form-group">
        		<label for="picker" class="col-xs-3 control-label">展示图片:</label>
        		<div class="col-xs-9">
            		<div id="picker"><input class="form-control" ></div>
        		</div>
    		</div>
		</div>
   js部分：
  		singleUploader({
    		pick : {
        		id : '#picker'  //选择文件的DOM节点id，需要加#
    		},
    		type : {
        		preview : true
    		},
    		edit : true,
    		uploader : 'uploader'
		},$scope);
 * 示例2(不编辑、有预览、无文件格式限制)：
   html部分：
   <div class="form-horizontal">
    	<div class="form-group">
        	<label for="single-picker" class="col-xs-3 control-label">展示图片:</label>
        	<div class="col-xs-9">
            	<div id="single-picker"><input class="form-control" ></div>
        	</div>
    	</div>
    	<div class="form-group">
        	<div class="col-xs-3"></div>
        	<div class="col-xs-9">
            	<ul>
                	<li id="preview" class="upload-info-li"></li>
            	</ul>
        	</div>
    	</div>
	</div>
	js部分：
	singleUploader({
    	pick : {
        	id : '#single-picker'  
    	},
    	type : {
        	preview : true,
        	id : '#preview'
    	},
    	uploader : 'single-uploader'
	});
 * 
 * 自定义参数及方法：
   singleUploader.getData($scope,uploader)  获取编辑panel的值，会绑定到$scope[uploader].data上。如果编辑完后收起编辑panel，数据会自动绑定到$scope上，不再需要调用此方法;
   pick : {
   		id : '#id'  //选择文件DOM节点的ID选择器
   }
   type : {
   		file : '' //参数有'img' 'doc' 'audio' 'video'分别对应图片、文档、音频、视频，如果不限制上传文件，不需此参数。参数默认为''
   		button : boolean, //为true时使用button进行上传，为false时使用input进行上传。默认为false，button时不支持编辑操作。
   		preview : boolean, //为true时可预览，为false时不可预览。
   		id : '#id',  //预览节点li的DOM节点ID选择器
   		uploaderPicker : '#id'  //当使用button上传时，上传button的ID选择器
   }
   edit : boolean //是否可编辑，默认为false
   uploader : ''  //实例化webuploader对象的名称，同一页面下多个上传组件需使用不同名称，默认为'uploader'
 * 其他需要加入的参数可参考webuploader的option部分 *

*/
define(['jquery','static/modules/webuploader/webuploader','PDUtilDir/inputSelect','static/app/common/uploader/settings-uploader','css!' + getStaticPath() +'/modules/webuploader/css/webuploader.css','css!' + getStaticPath() + '/app/common/uploader/css/upload.css'],
		function($,Webuploader,InputSelect,Settings){
	
	var result = {};
	
	//Webuploader实例化对象的容器
	var uploader = {};
	
	var urls = Settings.urls;
	
	var key = Settings.key;
	
	var htmlAddr = Settings.htmlAddr;
	
	var uploadHtml = '<span class="single-upload"><i class="fa fa-cloud-upload"></i></span>';
	
	var imgRet = '';
	
	var array = [];  //放文件格式常量的数组
	
	var data = [];
	
	result.init = function(userCon,$scope){
		
		var defaultCon = {
				swf : getStaticPath() + '/modules/webuploader/Uploader.swf',
				server : Settings.remoteUrl,
				pick : {
					id : '#picker',
					innerHtml : '',
					multiple : false
				},
				resize : false,
				chunked : false,
				duplicate: true,
				compress : false,
				formData : {
					mode : 'Simple'
				},
				type : {
					file : '',
					button : false,
					preview : false,
					id : '#preview',
					uploaderPicker : '#uploadpicker'
				},
				template : {
					'detail-arttype' : true,
					'detail-belongOrg' : true,
					'detail-format' : true,
					'detail-standardTheme' : true,
					'detail-secretLevel' : true,
					'detail-status' : true,
					'detail-subtitles' : true,
					'detail-name' : true,
					'detail-userTheme' : true,
					'detail-language' : true,
					'detail-intro' : true,
					'detail-remark' : false,
					'detail-timing' : true,
					'detail-pixel' : true,
					'detail-resolution' : true,
					'detail-definition' : true
				},
				edit : false,
				data : false,
				thumb : {
					width: 220,
				    height: 220,

				    // 图片质量，只有type为`image/jpeg`的时候才有效。
				    quality: 200,

				    // 是否允许放大，如果想要生成小图的时候不失真，此选项应该设置为false.
				    allowMagnify: false,

				    // 是否允许裁剪。
				    crop: false
				},
				uploader : 'uploader'
			};
		
		
		var config = {};
		
		config = $.extend(true,defaultCon,userCon);
		
		if(!config.data){
			$scope[config.uploader] = {data:{}};
		}else{
			$scope[config.uploader] = {data:{}};
			for(var property in key){
				$scope[config.uploader].data[property] = config.data[key[property]];
				$scope[config.uploader].data[key[property]] = config.data[key[property]];
			}
			$scope[config.uploader].data.fileId = config.data.fileId;
			$scope[config.uploader].data.size = config.data.size;
			$scope[config.uploader].data.type = config.data.type;
			data[config.uploader] = config.data;
		}
		
		//input上传时的进度条DOM节点ID
		if(!config.type.button){
			config.type.progress = '#' + config.uploader + '-progress';
		}
		
		
		if(!config.type.button && !config.type.preview){
			initInputNoPreview(config,$scope);
		}else if((!config.type.button && config.type.preview)){
			initInputAndPreview(config,$scope);
		}else if(config.type.button && !config.type.preview){
			initButtonNoPreview(config);
		}else if(config.type.button && config.type.preview){
			initButtonAndPreview(config);
		}
		
	};
	
	var initInputNoPreview = function(config,$scope){

		uploader[config.uploader] = Webuploader.create(config);
		
		renderInput(config,uploadHtml);
		
		if(config.data){
			$(config.pick.id).find('input.form-control').val(config.data[key['detail-name']]);
			bindEvent($scope,config);
		}
		//添加进上传文件队列时
		uploader[config.uploader].on('fileQueued',function(file){
			var $li = $(config.pick.id);
			var input = $li.find('input.form-control');
			input.val(file.name);
			$(config.pick.id + '+' + '.single-upload').remove();
			if(config.edit){
				$li.after('<span class="single-upload"><a><i class="fa fa-pencil" title="编辑"></i></a><a><i class="fa fa-times" title="删除"></i></a><a><i class="fa fa-upload" title="上传"></i></a></span>');
			}else{
				$li.after('<span class="single-upload"><a><i class="fa fa-times" title="删除"></i></a><a><i class="fa fa-upload" title="上传"></i></a></span>');
			}
			
			bindEvent($scope,config,file);
		
			//获取md5值
			var md5File = uploader[config.uploader].md5File(file).progress(function(percentage){
				
			}).then(function(val){
				uploader[config.uploader].option('formData',{
					md5 : val
				});
				$(config.pick.id + '+' + '.single-upload i.fa').css('color','#337ab7');
			});
		});
	
		//文件进入队列之前(因为是单个文件上传，在多次选择文件后只上传最后选择的一个文件)
		uploader[config.uploader].on('beforeFileQueued',function(file){
			if(!config.type.file){
				var ext = file.ext;
				var docExts = 'doc docx ppt pptx xls xlsx pdf';
				var imgExts = 'png jpg bmp tiff gif';
				var audioExts = 'mp3 wma wav';
				var videoExts = 'mp4 flv avi wmv rmvb mov mpg';
				config.type.autoFile = docExts.indexOf(ext) >= 0 ? 'doc' : (imgExts.indexOf(ext) >= 0 ? 'img' : (audioExts.indexOf(ext) >= 0 ? 'audio' : (videoExts.indexOf(ext) >= 0 ? 'video' : ext)));
			}else{
				config.type.autoFile = config.type.file;
			}
			uploader[config.uploader].reset();
			$(config.type.progress).css('width',0);
			$(config.type.progress).css('background-color','#337ab7');
			$(config.pick.id + '+' + '.single-upload i.fa').css('color','black');
			if(!config.type.file){
				changeEditHtml(config,$scope,file);
			}else{
				renderEditPanel(config.uploader,$scope,file);
				emptyInputSelect(config.uploader);
			}
			uploader[config.uploader].option('formData',{
				md5 : ''
			});
			$scope[config.uploader].data = {};
			if(config.type.autoFile){
				var rate = (config.type.autoFile == 'img' || config.type.autoFile == 'doc') ? 1024 : (config.type.autoFile == 'audio' ? 1024*1024 : (config.type.autoFile == 'video' ? 1024*1024*1024 : 1));
				$scope[config.uploader].data.size = (file.size/rate).toFixed(2) + '';
			}else{
				$scope[config.uploader].data.size = (file.size).toFixed(2);
			}
			$scope[config.uploader].data['detail-name'] = file.name;
			$scope[config.uploader].data[key['detail-name']] = file.name;
			$scope[config.uploader].data.type = config.type.autoFile;
			$scope[config.uploader].data['detail-format'] = [findFormatIdByName(file.ext)];
		});
	
		//上传过程中触发
		uploader[config.uploader].on('uploadProgress',function(file,percentage){
			$(config.type.progress).css('width',percentage * 100 + '%');
		});
	
		//
		uploader[config.uploader].on('uploadAccept',function(object,ret){
			
		});
	
		//上传成功
		uploader[config.uploader].on('uploadSuccess',function(file,response){
			$(config.type.progress).css('background-color','green');
//			$scope[config.uploader].data.fileId = response.entity.fileId;
		});
	
		//上传出错
		uploader[config.uploader].on('uploadError',function(file){
			$(config.type.progress).css('background-color','red');
		});
	
		//上传完成
		uploader[config.uploader].on('uploadComplete',function(file){
		
		});
	};
	
	var initInputAndPreview = function(config,$scope){
		uploader[config.uploader] = Webuploader.create(config);
		renderInput(config,uploadHtml);
		if(config.data){
			$(config.pick.id).find('input.form-control').val(config.data[key['detail-name']]);
			bindEvent($scope,config);
		}
		
		//找到放置预览img标签的DOM节点，在不编辑时需要添加预览图片节点ID
		var $li = {};
		if(!config.edit){
			$li = $(config.type.id);
			$li.text('');
			if(config.data){
				$li.append('<img alt="' + config.data[key['detail-name']] + '" src="' + config.data.url + '" />');
			}
		}
		
		
		//添加进上传文件队列时
		uploader[config.uploader].on('fileQueued',function(file){
			var $pick = $(config.pick.id);
			var input = $pick.find('input.form-control');
			input.val(file.name);
			$(config.pick.id + '+' + '.single-upload').remove();
			if(config.edit){
				$pick.after('<span class="single-upload"><a><i class="fa fa-pencil" title="编辑"></i></a><a><i class="fa fa-times" title="删除"></i></a><a><i class="fa fa-upload" title="上传"></i></a></span>');
			}else{
				$pick.after('<span class="single-upload"><a><i class="fa fa-times" title="删除"></i></a><a><i class="fa fa-upload" title="上传"></i></a></span>');
			}
			
			//为图标绑定事件
			bindEvent($scope,config,file);
			
			//预览图片
			uploader[config.uploader].makeThumb( file, function( error, ret ) {
		        if ( error ) {
		        	if(!config.edit){
		        		$li.text('预览错误');
		        	}else{
		        		if($('#' + 'edit-' + config.uploader).find('.upload-info-li')[0]){
							$('#' + 'edit-' + config.uploader).find('.upload-info-li').text('预览错误');
						}
		        	}		            
		        } else {
		        	imgRet = ret;
		        	if(!config.edit){
		        		$li.append('<img alt="' + file.name + '" src="' + ret + '" />');
		        	}else if($('#' + 'edit-' + config.uploader).find('.upload-info-li')[0]){
		        		$('#' + 'edit-' + config.uploader).find('.upload-info-li').text('');
						$('#' + 'edit-' + config.uploader).find('.upload-info-li').append('<img alt="' + file.name + '" src="' + imgRet + '" />');
					}
		        }
		    });
			
			//获取md5值
			var md5File = uploader[config.uploader].md5File(file).progress(function(percentage){
				
			}).then(function(val){
				uploader[config.uploader].option('formData',{
					md5 : val
				});
				$(config.pick.id + '+' + '.single-upload i.fa').css('color','#337ab7');
			});
		});
	
		//文件进入队列之前(因为是单个文件上传，在多次选择文件后只上传最后选择的一个文件)
		uploader[config.uploader].on('beforeFileQueued',function(file){
			if(!config.type.file){
				var ext = file.ext;
				var docExts = 'doc docx ppt pptx xls xlsx pdf';
				var imgExts = 'png jpg bmp tiff gif';
				var audioExts = 'mp3 wma wav';
				var videoExts = 'mp4 flv avi wmv rmvb mov mpg';
				config.type.autoFile = docExts.indexOf(ext) >= 0 ? 'doc' : (imgExts.indexOf(ext) >= 0 ? 'img' : (audioExts.indexOf(ext) >= 0 ? 'audio' : (videoExts.indexOf(ext) >= 0 ? 'video' : ext)));
			}else{
				config.type.autoFile = config.type.file;
			}
			uploader[config.uploader].reset();
			$(config.type.progress).css('width',0);
			$(config.type.progress).css('background-color','#337ab7');
			$(config.pick.id + '+' + '.single-upload i.fa').css('color','black');
			if(!config.edit){
				$li.text('');
			}else if($('#' + 'edit-' + config.uploader).find('.upload-info-li')[0]){
				$('#' + 'edit-' + config.uploader).find('.upload-info-li').find('img').remove();
			}
			imgRet = '';
			if(!config.type.file){
				changeEditHtml(config,$scope,file);
			}else{
				renderEditPanel(config.uploader,$scope,file);
				emptyInputSelect(config.uploader);
			}
			uploader[config.uploader].option('formData',{
				md5 : ''
			});
			$scope[config.uploader].data = {};
			if(config.type.autoFile){
				var rate = (config.type.autoFile == 'img' || config.type.autoFile == 'doc') ? 1024 : (config.type.autoFile == 'audio' ? 1024*1024 : (config.type.autoFile == 'video' ? 1024*1024*1024 : 1));
				$scope[config.uploader].data.size = (file.size/rate).toFixed(2) + '';
			}else{
				$scope[config.uploader].data.size = (file.size).toFixed(2);
			}
			$scope[config.uploader].data['detail-name'] = file.name;
			$scope[config.uploader].data[key['detail-name']] = file.name;
			$scope[config.uploader].data.type = config.type.autoFile;
			$scope[config.uploader].data['detail-format'] = [findFormatIdByName(file.ext)];
		});
	
		//上传过程中触发
		uploader[config.uploader].on('uploadProgress',function(file,percentage){
			$(config.type.progress).css('width',percentage * 100 + '%');
		});
	
		//
		uploader[config.uploader].on('uploadAccept',function(object,ret){
			
		});
	
		//上传成功
		uploader[config.uploader].on('uploadSuccess',function(file,response){
			$(config.type.progress).css('background-color','green');
//			$scope[config.uploader].data.fileId = response.entity.fileId;
		});
	
		//上传出错
		uploader[config.uploader].on('uploadError',function(file){
			$(config.type.progress).css('background-color','red');
		});
	
		//上传完成
		uploader[config.uploader].on('uploadComplete',function(file){
		
		});
	};
	
	var initButtonNoPreview = function(config){
		
		uploader[config.uploader] = Webuploader.create(config);
		
		//绑定上传事件
		$(config.type.uploaderPicker).click(function(){
			uploader[config.uploader].upload();
		});
		
		//找到提示上传进度的节点
		var $li = $(config.type.id);
		$li.text('');
		
		//添加进上传文件队列时
		uploader[config.uploader].on('fileQueued',function(file){

			//获取md5值
			var md5File = uploader[config.uploader].md5File(file).progress(function(percentage){
				$li.text('md5计算中' + percentage*100 + '%');
			}).then(function(val){
				uploader[config.uploader].option('formData',{
					md5 : val
				});
				$li.text('md5计算完成，可上传');
			});
			
		});
	
		//文件进入队列之前(因为是单个文件上传，在多次选择文件后只上传最后选择的一个文件)
		uploader[config.uploader].on('beforeFileQueued',function(file){
			uploader[config.uploader].reset();
			$li.text('');
		});
	
		//上传过程中触发
		uploader[config.uploader].on('uploadProgress',function(file,percentage){
			$li.text('上传中' + percentage*100 + '%');
		});
	
		//
		uploader[config.uploader].on('uploadAccept',function(object,ret){
			
		});
	
		//上传成功
		uploader[config.uploader].on('uploadSuccess',function(file,response){
			$li.text('上传成功');
		});
	
		//上传出错
		uploader[config.uploader].on('uploadError',function(file){
			$li.text('上传失败');
		});
	};
	
	var initButtonAndPreview = function(config){
		
		uploader[config.uploader] = Webuploader.create(config);
		
		//绑定上传事件
		$(config.type.uploaderPicker).click(function(){
			uploader[config.uploader].upload();
		});
		
		//找到放置预览img标签的DOM节点
		var $li = $(config.type.id);
		$li.text('');
		$li.find('img').remove();
		$li.nextAll('li').remove();
		//添加进上传文件队列时
		uploader[config.uploader].on('fileQueued',function(file){

			//获取md5值
			var md5File = uploader[config.uploader].md5File(file).progress(function(percentage){
				if(!$('#' + config.uploader + 'upload-preview-li')[0]){
					$li.after('<li id="' + config.uploader +'upload-preview-li" class="upload-info-li">md5计算中' + percentage*100 + '%' + '</li>');
				}else{
					$('#' + config.uploader + 'upload-preview-li').text('md5计算中' + percentage*100 + '%');
				}
			}).then(function(val){
				uploader[config.uploader].option('formData',{
					md5 : val
				});
				$('#' + config.uploader + 'upload-preview-li').text('md5计算完成，可上传');
			});
			
			uploader[config.uploader].makeThumb( file, function( error, ret ) {
		        if ( error ) {
		            $li.text('预览错误');
		        } else {
		            $li.append('<img alt="' + file.name + '" src="' + ret + '" />');
		        }
		    });

			
		});
	
		//文件进入队列之前(因为是单个文件上传，在多次选择文件后只上传最后选择的一个文件)
		uploader[config.uploader].on('beforeFileQueued',function(file){
			uploader[config.uploader].reset();
			$li.text('');
			$(config.type.id).find('img').remove();
			$(config.type.id).nextAll('li').remove();
		});
	
		//上传过程中触发
		uploader[config.uploader].on('uploadProgress',function(file,percentage){
			$('#' + config.uploader + 'upload-preview-li').text('上传中' + percentage*100 + '%');
		});
	
		//
		uploader[config.uploader].on('uploadAccept',function(object,ret){
			
		});
	
		//上传成功
		uploader[config.uploader].on('uploadSuccess',function(file,response){
			$('#' + config.uploader + 'upload-preview-li').text('上传成功');
		});
	
		//上传出错
		uploader[config.uploader].on('uploadError',function(file){
			$('#' + config.uploader + 'upload-preview-li').text('上传失败');
		});
	};
	
	//渲染上传组件type=input
	var renderInput = function(config,uploadHtml){
		
		if(!config.data){
			//删除默认选择文件的样式
			if($('.outsideDiv')[0]){
				$('.outsideDiv').remove();
			}
			$(config.pick.id).find('.webuploader-pick').removeClass('webuploader-pick');
			$(config.pick.id + '+' + '.single-upload').remove();
			$(config.type.progress).remove();
			$(config.pick.id + '+' + '.single-upload i.fa').css('color','black');
			$(config.pick.id).after(uploadHtml);
			$(config.pick.id).before('<div id="' + config.uploader + '-progress" class="upload-progress"></div>');
			$(config.type.progress).css('width',0);
			$(config.type.progress).css('background-color','#337ab7');
		}else{
			//删除默认选择文件的样式
			if($('.outsideDiv')[0]){
				$('.outsideDiv').remove();
			}
			$(config.pick.id).find('.webuploader-pick').removeClass('webuploader-pick');
			$(config.pick.id + '+' + '.single-upload').remove();
			$(config.type.progress).remove();
			if(config.edit){
				$(config.pick.id).after('<span class="single-upload"><a><i class="fa fa-pencil" title="编辑"></i></a><a><i class="fa fa-times" title="删除"></i></a></span>');
			}else{
				$(config.pick.id).after('<span class="single-upload"><a><i class="fa fa-times" title="删除"></i></a></span>');
			}
			$(config.pick.id).before('<div id="' + config.uploader + '-progress" class="upload-progress"></div>');
			$(config.type.progress).css('width','100%');
			$(config.type.progress).css('background-color','green');
			$(config.pick.id + '+' + '.single-upload i.fa').css('color','#337ab7');
		}
		
	};
	
	//获取编辑内容的值
	result.getData = function($scope,uploader){
		if($('#' + 'edit-' + uploader)[0]){
			var fileId = $scope[uploader].data.fileId;
			var size = $scope[uploader].data.size;
			var fileName = $scope[uploader].data['detail-name'];
			var type = $scope[uploader].data.type;
			$scope[uploader].data = {fileId : fileId , size : size , 'detail-name' : fileName , type : type};
			var inputs = $('#' + 'edit-' + uploader).find('[name]');
			for(var i=0;i<inputs.length;i++){
				var name = $(inputs[i]).attr('name');
				var inputNames = 'detail-arttype detail-belongOrg detail-format detail-standardTheme detail-secretLevel detail-status detail-subtitles';
				if(inputNames.indexOf(name) >= 0){
					var obj = InputSelect.getInput(uploader + name);
					$scope[uploader].data[name] = obj.getCurrentData().idArr;
				}else{
					$scope[uploader].data[name] = inputs[i].value;
				}
			}
			
			//对照settings的key再赋值一遍
			for(var property in key){
				$scope[uploader].data[key[property]] = $scope[uploader].data[property];
			}
		}
	};
	
	//给编辑内容赋值
	var renderEditPanel = function(uploader,$scope,file){
		$('#' + 'edit-' + uploader).find('[name^="detail"]').val('');
		for(var property in $scope[uploader].data){
			$('#' + 'edit-' + uploader).find('[name="' + property + '"]').val($scope[uploader].data[property]);
		}
		if(!$scope[uploader].data['detail-name'] && !$scope[uploader].data['detail-belongOrg']){
			$('#' + 'edit-' + uploader).find('[name="detail-name"]').val(file.name);
		}
	};
	
	//转换ID
	var changeId = function(uploader){
		var inputs = $('#' + 'edit-' + uploader).find('[name^="detail-"]');
		for(var i=0;i<inputs.length;i++){
			$(inputs[i]).attr('id',uploader + $(inputs[i]).attr('name'));
		}
	};
	
	//初始化inputSelect
	var initInputSelect = function(uploadContainer,config){
		var inputNames = 'detail-arttype detail-belongOrg detail-format detail-standardTheme detail-secretLevel detail-status detail-subtitles';
		var multiNames = 'detail-arttype detail-standardTheme detail-subtitles';
		var inputs = $('#' + 'edit-' + config.uploader).find('[name]');
		for(var i=0;i<inputs.length;i++){
			var name = $(inputs[i]).attr('name');
			var nameForUrl = name;
			if(nameForUrl == 'detail-format'){
				nameForUrl = name + '-' + config.type.autoFile;
			}
			var url = urlByName(nameForUrl);
			if(inputNames.indexOf(name) >= 0){
				concreteInputSelect({
					url : url,
					uploader : config.uploader,
					name : name,
					container : uploadContainer,
					multi : multiNames.indexOf(name) >= 0 ? true : false
				});
			}
		}
	};
	
	var concreteInputSelect = function(obj){
		$.post(obj.url).done(function(data){
			InputSelect({
				id : obj.uploader + obj.name,
				multi : obj.multi,
				data : data.curPageData,
				key : {
					id : Settings.dataField.id,
					name : Settings.dataField.name,
					data : Settings.dataField.data
				},
				searchAble : obj.multi,
				initData : obj.container.data[obj.name]
			});
		});
	};
	
	var emptyInputSelect = function(uploader){
		var inputs = $('#' + 'edit-' + uploader).find('[name]');
		for(var i=0;i<inputs.length;i++){
			var id = $(inputs[i]).attr('id');
			var obj = InputSelect.getInput(id);
			if(obj){
				obj.dataInit([]);
			}
		}
	};
	
	var html = function(file){
		var html = '';
		switch(file){
		case 'img' : html = htmlAddr.img;break;
		case 'doc' : html = htmlAddr.doc;break;
		case 'audio' : html = htmlAddr.audio;break;
		case 'video' : html = htmlAddr.video;break;
		}
		return html;
	};
	
	/**
	 * 根据名称寻找对应url
	 */
	var urlByName = function(name){
		var url = '';
		switch(name){
		case 'detail-arttype' : url = urls.url_arttype;break;
		case 'detail-belongOrg' : url = urls.url_org;break;
		case 'detail-format-doc' : url = urls.url_format_doc;break;
		case 'detail-format-img' : url = urls.url_format_img;break;
		case 'detail-format-audio' : url = urls.url_format_audio;break;
		case 'detail-format-video' : url = urls.url_format_video;break;
		case 'detail-standardTheme' : url = urls.url_theme;break;
		case 'detail-secretLevel' : url = urls.url_secretLevel;break;
		case 'detail-status' : url = urls.url_status;break;
		case 'detail-subtitles' : url = urls.url_subtitle;break;
		}
		return url;
	};
	
	var changeEditHtml = function(config,$scope,file){
		if($('#' + 'edit-' + config.uploader)[0]){
			$('#' + 'edit-' + config.uploader).remove();
			var url = html(config.type.autoFile);
			var $docHtml = '';
			$.post(url).done(function(data){}).fail(function(response){
				$docHtml = '<div id="edit-' + config.uploader + '" class="outsideDiv">' + response.responseText + '</div>';
				$(config.pick.id + '+' + '.single-upload').after($docHtml);
				delEditItem(config);
				renderEditPanel(config.uploader,$scope,file);
				changeId(config.uploader);
				initInputSelect($scope[config.uploader],config);
			});
		}
	};
	
	//给图标绑定事件
	var bindEvent = function($scope,config,file){
		if(config.edit){
			$(config.pick.id + '+' + '.single-upload .fa-pencil').click(function(){
				if($('#' + 'edit-' + config.uploader)[0]){
					result.getData($scope,config.uploader);
					$('#' + 'edit-' + config.uploader).remove();
				}else{
					config.type.autoFile = config.type.autoFile ? config.type.autoFile : fileById(config.data[key['detail-format']]);
					var url = html(config.type.autoFile);
					var $docHtml = '';
					$.post(url).done(function(data){}).fail(function(response){
						$docHtml = '<div id="edit-' + config.uploader + '" class="outsideDiv">' + response.responseText + '</div>';
						$(config.pick.id + '+' + '.single-upload').after($docHtml);
						delEditItem(config);
						if(config.type.preview){
							if(file){
								if(imgRet){
									$('#' + 'edit-' + config.uploader).find('.upload-info-li').append('<img alt="' + file.name + '" src="' + imgRet + '" />');
								}else{
									$('#' + 'edit-' + config.uploader).find('.upload-info-li').text('预览错误');
								}
								
							}else{
								$('#' + 'edit-' + config.uploader).find('.upload-info-li').append('<img alt="' + config.data[key['detail-name']] +'" src="' + config.data.url + '" />');
							}
						}
						changeId(config.uploader);
						if(file){
							renderEditPanel(config.uploader,$scope,file);
						}else{
							renderEditPanel(config.uploader,$scope);
						}
						initInputSelect($scope[config.uploader],config);
					});
				}
				
			});
		}
		$(config.pick.id + '+' + '.single-upload .fa-upload').click(function(){
			if(uploader[config.uploader].option('formData').md5){
				uploader[config.uploader].upload();
			}else{
				alert('请等待MD5计算完成');
			}
		});
		$(config.pick.id + '+' + '.single-upload .fa-times').click(function(){
			var $li = {};
			if(!config.edit){
				$li = $(config.type.id);
				$li.text('');
			}
			var $pick = $(config.pick.id);
			var input = $(config.pick.id).find('input.form-control');
			input.val('');
			$(config.pick.id + '+' + '.single-upload').remove();
			$pick.after(uploadHtml);
			$(config.type.progress).css('width',0);
			$(config.type.progress).css('background-color','#337ab7');
			$(config.pick.id + '+' + '.single-upload i.fa').css('color','black');
			if(!config.edit){
				$li.text('');
			}
			if(file){
				uploader[config.uploader].reset();
				uploader[config.uploader].removeFile(file,true);//触发fileDequeued
			}
			if($('#' + 'edit-' + config.uploader)[0]){
				$('#' + 'edit-' + config.uploader).remove();
			}
			$scope[config.uploader].data = {};
			uploader[config.uploader].option('formData',{
				md5 : ''
			});
		});
	};
	
	var fileById = function(id){
		if(!array.length){
			$.ajax({
				url : urls.url_format_doc,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function(data){
					array.push(data.curPageData);
				}
			});
			$.ajax({
				url : urls.url_format_img,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function(data){
					array.push(data.curPageData);
				}
			});
			$.ajax({
				url : urls.url_format_audio,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function(data){
					array.push(data.curPageData);
				}
			});
			$.ajax({
				url : urls.url_format_video,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function(data){
					array.push(data.curPageData);
				}
			});
		}
		for(var i=0;i<array.length;i++){
			for(var j=0;j<array[i].length;j++){
				if(array[i][j].id == id){
					return i === 0 ? 'doc' : (i == 1 ? 'img' : (i==2 ? 'audio' : (i==3 ? 'video' : '')));
				} 
			}
		}
	};
	
	//处理不必要的编辑项
	var delEditItem = function(config){
		for(var prop in config.template){
			if(!config.template[prop]){
				var item = $('#' + 'edit-' + config.uploader).find('#' + prop).parent().parent();
				item.remove();
			}
		}
	};
	
	var findFormatIdByName = function(ext){
		if(!array.length){
			$.ajax({
				url : urls.url_format_doc,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function(data){
					array.push(data.curPageData);
				}
			});
			$.ajax({
				url : urls.url_format_img,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function(data){
					array.push(data.curPageData);
				}
			});
			$.ajax({
				url : urls.url_format_audio,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function(data){
					array.push(data.curPageData);
				}
			});
			$.ajax({
				url : urls.url_format_video,
				type : 'POST',
				dataType : 'json',
				async : false,
				success : function(data){
					array.push(data.curPageData);
				}
			});
		}
		for(var i=0;i<array.length;i++){
			for(var j=0;j<array[i].length;j++){
				if(array[i][j].name == ext){
					return array[i][j].id;
				} 
			}
		}
	};
	
	//判断新增、删除、修改
	result.operation = function($scope,uploader){
		result.getData($scope,uploader);
		var newData = $scope[uploader].data;
		var oldData = data[uploader];
		var index = 0;
		for(var prop in newData){
			index++;
		}
		if(oldData){
			if(index === 0){
				return 'del';
			}else{
				return newData.fileId == oldData.fileId ? 'modify' : 'replace';
			}
		}else{
			return index === 0 ? null : 'add';
		}
	};
	
	
	return result;
});