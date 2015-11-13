/**
 * author@sarah
 */

define(['jquery','static/modules/webuploader/webuploader','css!' + getStaticPath() +'/modules/webuploader/css/webuploader.css'],function($,webuploader){
	
	var result = {};
	var uploader = {};//webuploader实例化对象的容器
	result.init = function(userCon){
		
		var defaultCon = {
			swf : getStaticPath() + '/modules/webuploader/Uploader.swf',
			server : getServer() + '/sword/fileUpload',
			pick : {
				id : '#picker',
				label : '',
				multiple : false
			},
			resize : false,
			chunked : true,
			duplicate: true,
			formData : {
				mode : 'Simple'
			},
			type : {
				
			},
			uploader : 'uploader'
		};
		
		var defaultImgCon = {
			swf : getStaticPath() + '/modules/webuploader/Uploader.swf',
			server : getServer() + '/sword/fileUpload',
			pick : {
				id : '#picker',
				label : '',
				multiple : false
			},
			resize : false,
			chunked : true,
			duplicate: true,
			formData : {
				mode : 'Simple'
			},
			type : {
				button : false,
				preview : true
			},
			accept : {
			    title: 'Images',
			    extensions: 'gif,jpg,jpeg,bmp,png',
			    mimeTypes: 'image/*'
			},
			thumb : {
				width: 220,
			    height: 220,

			    // 图片质量，只有type为`image/jpeg`的时候才有效。
			    quality: 200,

			    // 是否允许放大，如果想要生成小图的时候不失真，此选项应该设置为false.
			    allowMagnify: false,

			    // 是否允许裁剪。
			    crop: false,
			},
			uploader : 'uploader',
			uploadPicker : '#uploadpicker'
		};
		
		//初始化参数
		var config = {};
		if(userCon.type){
			config = userCon.type.preview ? $.extend(true,defaultImgCon,userCon) : $.extend(true,defaultCon,userCon);
		}else{
			config = $.extend(true,defaultCon,userCon)
		}
		//初始化上传组件
		uploader[config.uploader] = webuploader.create(config);
		//渲染组件
		var uploadHtml = '<span class="single-upload"><i class="fa fa-cloud-upload"></i></span>';
		
		if(config.type.button  && config.type.preview){
			//绑定上传事件
			$(config.uploadPicker).click(function(){
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
					if(!$('#upload-preview-li')[0]){
						$li.after('<li id="upload-preview-li" class="upload-info-li">md5计算中' + percentage*100 + '%' + '</li>');
					}
				}).then(function(val){
					uploader[config.uploader].option('formData',{
						md5 : val
					});
					$('#upload-preview-li').text('md5计算完成，可上传');
				});
				
				uploader[config.uploader].makeThumb( file, function( error, ret ) {
			        if ( error ) {
			            $li.text('预览错误');
			        } else {
			            $li.append('<img alt="" src="' + ret + '" />');
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
				$('#upload-preview-li').text('上传中' + percentage*100 + '%');
			});
		
			//
			uploader[config.uploader].on('uploadAccept',function(object,ret){
				
			});
		
			//上传成功
			uploader[config.uploader].on('uploadSuccess',function(file,response){
				$('#upload-preview-li').text('上传成功');
			});
		
			//上传出错
			uploader[config.uploader].on('uploadError',function(file){
				$('#upload-preview-li').text('上传失败');
			});
		}else{
			renderInput(config,uploadHtml);
		
			//添加进上传文件队列时
			uploader[config.uploader].on('fileQueued',function(file){
				var $li = $(config.pick.id);
				var input = $li.find('input.form-control');
				input.val(file.name);
				$(config.pick.id + '+' + '.single-upload').remove();
				$li.after('<span class="single-upload"><a><i class="fa fa-times" title="删除"></i></a><a><i class="fa fa-upload" title="上传"></i></a></span>');
				//为图标绑定事件
				$('.single-upload .fa-upload').click(function(){
					uploader[config.uploader].upload();
				});
				$('.single-upload .fa-times').click(function(){
					input.val('');
					$(config.pick.id + '+' + '.single-upload').remove();
					$li.after(uploadHtml);
					$('#progress').css('width',0);
					$('#progress').css('background-color','#337ab7');
					$('.single-upload i.fa').css('color','black');
					uploader[config.uploader].reset();
					uploader[config.uploader].removeFile(file,true);//触发fileDequeued
				});
			
				//获取md5值
				var md5File = uploader[config.uploader].md5File(file).progress(function(percentage){
					console.log('Percentage:', percentage);
				}).then(function(val){
					uploader[config.uploader].option('formData',{
						md5 : val
					});
					$('.single-upload i.fa').css('color','#337ab7');
				});
			});
		
			//文件进入队列之前(因为是单个文件上传，在多次选择文件后只上传最后选择的一个文件)
			uploader[config.uploader].on('beforeFileQueued',function(file){
				uploader[config.uploader].reset();
				$('#progress').css('width',0);
				$('#progress').css('background-color','#337ab7');
				$('.single-upload i.fa').css('color','black');
			});
		
			//上传过程中触发
			uploader[config.uploader].on('uploadProgress',function(file,percentage){
				$('#progress').css('width',percentage * 100 + '%');
			});
		
			//
			uploader[config.uploader].on('uploadAccept',function(object,ret){
				
			});
		
			//上传成功
			uploader[config.uploader].on('uploadSuccess',function(file,response){
				$('#progress').css('background-color','green');
			});
		
			//上传出错
			uploader[config.uploader].on('uploadError',function(file){
				$('#progress').css('background-color','red');
			});
		
			//上传完成
			uploader[config.uploader].on('uploadComplete',function(file){
			
			});
		}
		
	};
	
	//渲染上传组件type=input
	renderInput = function(config,uploadHtml){
		//删除默认选择文件的样式
		$(config.pick.id).find('.webuploader-pick').removeClass('webuploader-pick');
		$(config.pick.id + '+' + '.single-upload').remove();
		$('.single-upload i.fa').css('color','black');
		$(config.pick.id).after(uploadHtml);
	};
	
	return result;
});