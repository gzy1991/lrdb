/**
 * author@sarah
 */

/**
 * 示例1:
   html部分：
   		<div class="col-xs-12 form-horizontal">
	    	<div class="form-group">
	        	<div id="multi"></div>
	        </div>
	    </div>
   js部分：
   		multiuploader.init($scope);
 */
/**
 * 方法及自定义参数说明：
 * getAllData($scope,uploader)，可将编辑的数据绑定到$scope[uploader]上
 * init($scope,{
 		edit : boolean,   //是否可编辑，默认为false
 		uploader : '',  //实例化上传组件名称
 		param : {
 			placeAt : ''  //#id，多附件上传所在的DOM节点
 			file : ''  //是否限制上传文件类型，涉及到不同编辑内容，可以给值'img'、'doc'、'audio'、'video'。如果不限制，则会根据选择添加的文件后缀判断文件类型。
 		}
   })
   其他参数请参照webuploader的官方API。
 */
define(['jquery','static/modules/webuploader/webuploader','PDUtilDir/inputSelect','static/app/common/uploader/settings-uploader','css!' + getStaticPath() +'/modules/webuploader/css/webuploader.css','css!' + getStaticPath() + '/app/common/uploader/css/upload.css','css!' + getStaticPath() + '/modules/util/css/grid.css'],
		function($,Webuploader,InputSelect,Settings){
	
	var result = {};
	
	var urls = Settings.urls;
	
	var key = Settings.key;
	
	var htmlAddr = Settings.htmlAddr;
	
	//Webuploader实例化对象的容器
	var uploader = {};
	
	//预览路径存放容器
	var rets = {};
	
	//md5存放容器
	var md5 = {};
	
	//各文档格式数据存放容器
	var array = [];
	
	//传入初始化数据容器
	var data = {};
	
	var $toolbar = '';
	
	var $thead = '<div class="s_grid_table"><div class="table-head"><table class="table table-hover">' +
				 '<thead><tr><th class="multiUpload-table-th" width="30%">名称</th><th class="multiUpload-table-th" width="30%">状态</th><th class="multiUpload-table-th" width="10%">操作</th></tr></thead>' + 
				 '</table></div><div class="table-body"><table class="table table-hover">' + 
				 '<thead><tr><th class="multiUpload-table-th" width="30%"></th><th class="multiUpload-table-th" width="30%"></th><th class="multiUpload-table-th" width="10%"></th></tr></thead>' + 
				 '<tbody style="text-align:center;"></tbody>' + '</table></div></div>';
	
	result.init = function($scope,userCon){
		
		var commonToolbar = '<div class="s_grid_content"><div class="s_grid_toolbar"><ul>' + 
		   					'<li><div class="multi-picker"><a><i class="fa fa-plus-circle">选择文件</i></a></div></li>' + 
		   					'<li><a><i class="fa fa-cloud-upload">上传文件</i></a></li>' +
		   					'<li><a><i class="fa fa-repeat">重置</i></a></li>' +
		   					'</ul></div></div>';
		
		var defaultCon = {
				swf : getStaticPath() + '/modules/webuploader/Uploader.swf',
				server : Settings.remoteUrl,
				pick : {
					id : '',
					innerHtml : '',
					multiple : true
				},
				resize : false,
				chunked : false,
				compress : false,
				duplicate: false,
				formData : {
					mode : 'Simple'
				},
				param : {
					placeAt : '#multi',
					file : '',
					uploadPicker : '',
					clear : ''
				},
				edit : false,
				exts : {},
				data : false,
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
					'detail-remark' : false,
					'detail-intro' : true,
					'detail-timing' : true,
					'detail-pixel' : true,
					'detail-resolution' : true,
					'detail-definition' : true
				},
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
				uploader : 'multi-uploader'
		};
		
		var config = {};
		
		config = $.extend(true,defaultCon,userCon);
		
		config.pick.id = '#' + config.uploader + '-picker';
		
		config.param.uploadPicker = '#' + config.uploader + '-upload';
		
		config.param.clear = '#' + config.uploader + '-clear';
		
		$toolbar = '<div id="multi-upload-' + config.uploader + '">' + commonToolbar + '</div>';
		
		initTable(config);
		
		if(!config.data){
			$scope[config.uploader] = {data:{}};
		}else{
			$scope[config.uploader] = {data:{}};
			for(var property in config.data){
				$scope[config.uploader].data[property] = {};
				for(var prop in key){
					$scope[config.uploader].data[property][prop] = config.data[property][key[prop]];
					$scope[config.uploader].data[property][key[prop]] = config.data[property][key[prop]];
				}
				rets[property] = config.data[property].url;
				if(!config.param.file){
					config.exts[property] = fileById(config.data[property][key['detail-format']]);
				}else{
					config.exts[property] = config.param.file;
				}
				$scope[config.uploader].data[property].fileId = config.data[property].fileId;
				$scope[config.uploader].data[property].size = config.data[property].size;
				$scope[config.uploader].data[property].type = config.data[property].type;
			}
			data[config.uploader] = config.data;//作为获取增加、修改、删除数据用
		}
		
		md5[config.uploader] = {};
		
		initMultiUploader(config,$scope);
	};
	
	var initMultiUploader = function(config,$scope){
		
		uploader[config.uploader] = Webuploader.create(config);
		
		var content = '';
		
		//如果统一为一类文件上传并且可编辑，只向后台发起一次请求
		if(config.param.file && config.edit){
			var url = html(config,{source:{uid : 'url'}});
			$.post(url).done(function(data){}).fail(function(response){
				content = response.responseText;
			});
		}
		
		//绑定上传事件
		$(config.param.uploadPicker).click(function(){
			var prepare = true;
			var md5s = md5[config.uploader];
			for(var prop in md5s){
				if(!md5s[prop]){
					prepare = false;
					break;
				}
			}
			if(prepare){
				uploader[config.uploader].upload();
			}else{
				alert('请等待MD5计算完成');
			}
			
		});
		
		//绑定重置事件
		$(config.param.clear).click(function(){
			if(!config.data){
				$(config.param.placeAt).find('tbody tr').remove();
			}else{
				var trs = $(config.param.placeAt).find('tbody tr');
				var originIds = '';
				for(var prop in config.data){
					if($scope[config.uploader].data[prop]){
						originIds = originIds + config.data[prop].fileId + ' ';
						originIds = originIds + 'edit-' + config.data[prop].fileId + ' ';
					}
				}
				for(var i=0;i<trs.length;i++){
					var id = $(trs[i]).attr('id');
					if(originIds.indexOf(id) < 0){
						$(trs[i]).remove();
						delete $scope[config.uploader].data[id];
					}
				}
			}
			uploader[config.uploader].reset();
			md5[config.uploader] = {};
			uploader[config.uploader].option('formData',{
				md5s : md5[config.uploader]
			});
		});
		
		if(config.data){
			append($scope,config,content);
		}
		
		uploader[config.uploader].on('fileQueued',function(file){
			
			var ext = file.ext;
			
			//初始化formData.md5s，用来判断MD5是否计算完成
			md5[config.uploader][file.id] = false;
			
			//添加一行内容，并且绑定行事件
			addFile({
				config : config,
				file : file,
				uploader : uploader[config.uploader],
				ext : ext,
				content : content,
				$scope : $scope
			});
			
			var $td = $('#' + file.source.uid).find('[name="status"]');
			//计算MD5值
			uploader[config.uploader].md5File(file).progress(function(percentage){
				$td.text('MD5计算中' + (percentage*100).toFixed(2) + '%');
			}).then(function(val){
				md5[config.uploader][file.id] = val;
				uploader[config.uploader].option('formData',{
					md5s : md5[config.uploader]
				});
				$td.text('MD5计算完成');
			});
			
			//处理图片预览
			uploader[config.uploader].makeThumb(file,function(error,ret){
				if(error){
					
				}else{
					rets[file.source.uid] = ret;
				}
			});
			
		});
		
		uploader[config.uploader].on('beforeFileQueued',function(file){
			$scope[config.uploader].data[file.source.uid] = {};
			$scope[config.uploader].data[file.source.uid]['detail-name'] = file.name;
			$scope[config.uploader].data[file.source.uid][key['detail-name']] = file.name;
			var rate = 1;
			var type = config.param.file;
			if(config.param.file){
				rate = (config.param.file == 'img' || config.param.file == 'doc') ? 1024 : (config.param.file == 'audio' ? 1024*1024 : (config.param.file == 'video' ? 1024*1024*1024 : 1));
			}else{
				var ext = file.ext;
				var docExts = 'doc docx ppt pptx xls xlsx pdf';
				var imgExts = 'png jpg bmp tiff gif';
				var audioExts = 'mp3 wma wav';
				var videoExts = 'mp4 flv avi wmv rmvb mov mpg';
				rate = docExts.indexOf(ext) >= 0 ? 1024 : (imgExts.indexOf(ext) >= 0 ? 1024 : (audioExts.indexOf(ext) >= 0 ? 1024*1024 : (videoExts.indexOf(ext) >= 0 ? 1024*1024*1024 : 1)));
				type = docExts.indexOf(ext) >= 0 ? 'doc' : (imgExts.indexOf(ext) >= 0 ? 'img' : (audioExts.indexOf(ext) >= 0 ? 'audio' : (videoExts.indexOf(ext) >= 0 ? 'video' : ext)));
			}
			$scope[config.uploader].data[file.source.uid].size = (file.size/rate).toFixed(2) + '';
			$scope[config.uploader].data[file.source.uid].type = type;
		});
		
		//上传过程中触发
		uploader[config.uploader].on('uploadProgress',function(file,percentage){
			var $td = $('#' + file.source.uid).find('[name="status"]');
			$td.text('上传中' + (percentage*100).toFixed(2) + '%');
		});
	
		//
		uploader[config.uploader].on('uploadAccept',function(object,ret){
			
		});
	
		//上传成功
		uploader[config.uploader].on('uploadSuccess',function(file,response){
			var $td = $('#' + file.source.uid).find('[name="status"]');
			$td.text('上传成功');
			delete md5[config.uploader][file.id];
			uploader[config.uploader].option('formData',{
				md5s : md5[config.uploader]
			});
//			if($scope[config.uploader].data[file.source.uid]){
//				$scope[config.uploader].data[file.source.uid].fileId = response.entity.fileId;
//			}else{
//				$scope[config.uploader].data[file.source.uid] = {fileId : response.entity.fileId};
//			}
		});
	
		//上传出错
		uploader[config.uploader].on('uploadError',function(file){
			var $td = $('#' + file.source.uid).find('[name="status"]');
			$td.text('上传失败');
		});
		
	};
	
	var initTable = function(config){
		$(config.param.placeAt).find('.s_grid_content').remove();
		$(config.param.placeAt).append($toolbar);
		$(config.param.placeAt).addClass('s_grid s_grid_ellipsis');
		$(config.param.placeAt).find('.s_grid_content').append($thead);
		$(config.param.placeAt).find('.multi-picker').attr('id',config.uploader + '-picker');
		$(config.param.placeAt).find('.fa-cloud-upload').attr('id',config.uploader + '-upload');
		$(config.param.placeAt).find('.fa-repeat').attr('id',config.uploader + '-clear');
	};
	
	var addFile = function(obj){
		
		var $tr = '';
		
		//根据是否可编辑添加不同html
		if(obj.config.edit){
			$tr = '<tr class="multi-upload-info-tr" id="' + obj.file.source.uid + '"><td name="name" title="' + obj.file.name + '">' + obj.file.name + '</td>' + 
			  '<td name="status">等待MD5计算</td>' + 
			  '<td name="handle"><a><i class="fa fa-pencil" title="编辑"></i></a><a><i title="删除" class="fa fa-trash"></i></a></td>';
		}else{
			$tr = '<tr class="multi-upload-info-tr" id="' + obj.file.source.uid + '"><td name="name" title="' + obj.file.name + '">' + obj.file.name + '</td>' + 
			  '<td name="status">等待MD5计算</td>' + 
			  '<td name="handle"><a><i title="删除" class="fa fa-trash"></i></a></td>';
		}
		$(obj.config.param.placeAt).find('tbody').append($tr);
		
		var $uploader = $(obj.config.param.placeAt);
		//定义添加行的图标事件
		$uploader.find('#' + obj.file.source.uid).find('i.fa-trash').click(function(){
			$uploader.find('#' + obj.file.source.uid).remove();
			if($uploader.find('#' + 'edit-' + obj.file.source.uid)[0]){
				$uploader.find('#' + 'edit-' + obj.file.source.uid).remove();
			}
			delete obj.$scope[obj.config.uploader].data[obj.file.source.uid];
			delete md5[obj.config.uploader][obj.file.id];
			obj.uploader.option('formData',{
				md5s : md5[obj.config.uploader]
			});
			obj.uploader.removeFile(obj.file,true);
		});
		
		if(obj.config.edit){
			$uploader.find('#' + obj.file.source.uid).find('i.fa-pencil').click(function(){
				
				//编辑面板
				var $editPanel = $uploader.find('#' + 'edit-' + obj.file.source.uid);
				
				//当前td行
				var $td = $uploader.find('#' + obj.file.source.uid);
				
				if($editPanel[0]){
					
					//如果已打开则先获取数据再关闭
					getData(obj.$scope,obj.config,obj.file);
					$editPanel.remove();
					
				}else{
					var editPanel = '';
					if(obj.content){//如果content有值，则说明file类别已固定，不需要再向后台请求数据
						editPanel = '<tr style="text-align:left;" id="edit-' + obj.file.source.uid  + '"><td colspan="3"><div class="multi-edit-panel">' + obj.content + '</div></td></tr>';
						$td.after(editPanel);
						delEditItem(obj.config,obj.file.source.uid);
						changeId(obj.file);
						dataInit({
							id : obj.file.source.uid,
							uploader : obj.config.uploader,
							$scope : obj.$scope,
							name : obj.file.name,
							ext : obj.ext
						});
						initInputSelect(obj.$scope,obj.config,obj.file);
						$('#' + 'edit-' + obj.file.source.uid).find('.upload-info-li').append('<img alt="' + obj.file.name + '" src="' + rets[obj.file.source.uid] + '"/>');
					}else{
						var url = html(obj.config,obj.file,obj.ext);
						$.post(url).done(function(data){
							console.info(data);
						}).fail(function(response){
							editPanel = '<tr style="text-align:left;" id="edit-' + obj.file.source.uid  + '"><td colspan="3"><div class="multi-edit-panel">' + response.responseText + '</div></td></tr>';
							$td.after(editPanel);
							$td.find('.upload-info-li').append('<img alt="' + obj.file.name + '" src="' + rets[obj.file.source.uid] + '"/>');
							delEditItem(obj.config,obj.file.source.uid);
							changeId(obj.file);
							dataInit({
								id : obj.file.source.uid,
								uploader : obj.config.uploader,
								$scope : obj.$scope,
								name : obj.file.name,
								ext : obj.ext
							});
							initInputSelect(obj.$scope,obj.config,obj.file);
							$('#' + 'edit-' + obj.file.source.uid).find('.upload-info-li').append('<img alt="' + obj.file.name + '" src="' + rets[obj.file.source.uid] + '"/>');
						});
					}
					
					
				}
			});
		}
		
	};
	
	//根据文件后缀名获取html地址
	var html = function(config,file,ext){
		var url = '';
		var id = '';
		if(typeof(file) == 'object'){
			id = file.source.uid;
			if(!config.param.file){
				var docExts = 'doc docx ppt pptx xls xlsx pdf';
				var imgExts = 'png jpg bmp tiff gif';
				var audioExts = 'mp3 wma wav';
				var videoExts = 'mp4 flv avi wmv rmvb mov mpg';
				config.exts[id] = docExts.indexOf(ext) >= 0 ? 'doc' : (imgExts.indexOf(ext) >= 0 ? 'img' : (audioExts.indexOf(ext) >= 0 ? 'audio' : (videoExts.indexOf(ext) >= 0 ? 'video' : ext)));
			}else{
				config.exts[id] = config.param.file;
			}
		}else{
			id = file;
		}
		
		switch(config.exts[id]){
			case 'img' : url = htmlAddr.img;break;
			case 'doc' : url = htmlAddr.doc;break;
			case 'audio' : url = htmlAddr.audio;break;
			case 'video' : url = htmlAddr.video;break;
		}
		return url;
	};
	
	
	//转换编辑panel中input和textarea的id
	var changeId = function(file){
		var inputs = {};
		if(typeof(file) == 'object'){
			inputs = $('#' + 'edit-' + file.source.uid).find('[name^="detail-"]');
			for(var i=0;i<inputs.length;i++){
				$(inputs[i]).attr('id',file.source.uid + $(inputs[i]).attr('name'));
			}
		}else{
			inputs = $('#' + 'edit-' + file).find('[name^="detail-"]');
			for(var j=0;j<inputs.length;j++){
				$(inputs[j]).attr('id',file + $(inputs[j]).attr('name'));
			}
		}
	};
	
	//将每个附件的数据绑定到$scope上
	var getData = function($scope,config,file){
		var id = '';
		var inputNames = 'detail-arttype detail-belongOrg detail-format detail-standardTheme detail-secretLevel detail-status detail-subtitles';
		if(typeof(file) == 'object'){
			id = file.source.uid;
		}else{
			id = file;
		}
		var inputs = $('#' + 'edit-' + id).find('[name]');
		var fileId = $scope[config.uploader].data[id] ? $scope[config.uploader].data[id].fileId : '';
		var fileName = $scope[config.uploader].data[id] ? $scope[config.uploader].data[id]['detail-name'] : '';
		var size = $scope[config.uploader].data[id] ? $scope[config.uploader].data[id].size : '';
		var type = $scope[config.uploader].data[id] ? $scope[config.uploader].data[id].type : '';
		$scope[config.uploader].data[id] = {fileId : fileId , size : size , 'detail-name' : fileName , type : type};
		for(var i=0;i<inputs.length;i++){
			var name = $(inputs[i]).attr('name');
			if(inputNames.indexOf(name) >= 0){
				var obj = InputSelect.getInput(id + name);
				$scope[config.uploader].data[id][name] = obj.getCurrentData().idArr;
			}else{
				$scope[config.uploader].data[id][name] = inputs[i].value;
			}
		}
		
		//对照settings的key再赋值一遍
		for(var property in key){
			$scope[config.uploader].data[id][key[property]] = $scope[config.uploader].data[id][property];
		}
	};
	
	//获取所有附件的数据(暂无fileId等后台返回数据)
	result.getAllData = function($scope,uploader){
		var panels = $('#' + 'multi-upload-' + uploader).find('.multi-edit-panel');
		for(var i=0;i<panels.length;i++){
			var inputs = $(panels[i]).find('[name]');
			var index = $(inputs[0]).attr('id').indexOf('detail');
			var uid = $(inputs[0]).attr('id').substring(0,index);
			var fileId = $scope[uploader].data[uid] ? $scope[uploader].data[uid].fileId : '';
			var fileName = $scope[uploader].data[uid] ? $scope[uploader].data[uid]['detail-name'] : '';
			var size = $scope[uploader].data[uid] ? $scope[uploader].data[uid].size : '';
			var type = $scope[uploader].data[uid] ? $scope[uploader].data[uid].type : '';
			$scope[uploader].data[uid] = {fileId : fileId , size : size , 'detail-name' : fileName , type : type};
			for(var j=0;j<inputs.length;j++){
				var name = $(inputs[j]).attr('name');
				var inputNames = 'detail-arttype detail-belongOrg detail-format detail-standardTheme detail-secretLevel detail-status detail-subtitles';
				if(inputNames.indexOf(name) >= 0){
					var obj = InputSelect.getInput(uid + name);
					$scope[uploader].data[uid][name] = obj.getCurrentData().idArr;
				}else{
					$scope[uploader].data[uid][name] = inputs[j].value;
				}
			}
			
			//对照settings的key再赋值一遍
			for(var property in key){
				$scope[uploader].data[uid][key[property]] = $scope[uploader].data[uid][property];
			}
		}
	};
	
	//初始化编辑input框的值
	var dataInit = function(obj){
		var dataObj = obj.$scope[obj.uploader].data[obj.id];
		var formatId = '';
		if(obj.ext){
			formatId = findFormatIdByName(obj.ext);
		}
		if(formatId){
			obj.$scope[obj.uploader].data[obj.id]['detail-format'] = [formatId];
		}
		if(dataObj){
			for(var property in dataObj){
				$('#' + 'edit-' + obj.id).find('[name="' + property + '"]').val(obj.$scope[obj.uploader].data[obj.id][property]);
			}
		}else{
			$('#' + 'edit-' + obj.id).find('[name="detail-name"]').val(obj.name);
		}
	};
	
	//初始化inputSelect组件
	var initInputSelect = function($scope,config,file){
		var inputNames = 'detail-arttype detail-belongOrg detail-format detail-standardTheme detail-secretLevel detail-status detail-subtitles';
		var multiNames = 'detail-arttype detail-standardTheme detail-subtitles';
		var id = '';
		if(typeof(file) == 'object'){
			id = file.source.uid;
		}else{
			id = file;
		}
		var inputs = $('#' + 'edit-' + id).find('[name]');
		for(var i=0;i<inputs.length;i++){
			var name = $(inputs[i]).attr('name');
			var nameForUrl = name;
			if(nameForUrl == 'detail-format'){
				nameForUrl = config.param.file ? (name + '-' + config.param.file) : (name + '-' + config.exts[id]);
			}
			var url = urlByName(nameForUrl);
			if(inputNames.indexOf(name) >= 0){
				concreteInputSelect({
					url : url,
					uid : id,
					name : name,
					container : $scope[config.uploader],
					multi : multiNames.indexOf(name) >= 0 ? true : false
				});
			}
		}
	};
	
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
	
	var concreteInputSelect = function(obj){
		$.post(obj.url).done(function(data){
			InputSelect({
				id : obj.uid + obj.name,
				multi : obj.multi,
				data : data.curPageData,
				key : {
					id : Settings.dataField.id,
					name : Settings.dataField.name,
					data : Settings.dataField.data
				},
				searchAble : obj.multi,
				initData : obj.container.data[obj.uid] ? obj.container.data[obj.uid][obj.name] : []
			});
		});
	};
	
	var append = function($scope,config,content){
		
		var $tr = '';
		
		var data = $scope[config.uploader].data;
		
		for(var property in data){
			var obj = data[property];
			if(config.edit){
				$tr = '<tr class="multi-upload-info-tr" id="' + obj.fileId + '"><td name="name" title="' + obj['detail-name'] + '">' + obj['detail-name'] + '</td>' + 
				  '<td name="status">已上传</td>' + 
				  '<td name="handle"><a><i class="fa fa-pencil" title="编辑"></i></a><a><i title="删除" class="fa fa-trash"></i></a></td>';
			}else{
				$tr = '<tr class="multi-upload-info-tr" id="' + obj.fileId + '"><td name="name" title="' + obj['detail-name'] + '">' + obj['detail-name'] + '</td>' + 
				  '<td name="status">已上传</td>' + 
				  '<td name="handle"><a><i title="删除" class="fa fa-trash"></i></a></td>';
			}
			$(config.param.placeAt).find('tbody').append($tr);
			
			//定义添加行的图标事件
			bindEvents($scope,config,content,obj);
			
		}
		
		
		
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
					return i === 0 ? 'doc' : (i == 1 ? 'img' : (i==2 ? 'audio' : 'video'));
				} 
			}
		}
	};
	
	
	//绑定初始化data行的图标事件
	var bindEvents = function($scope,config,content,obj){
		
		var $uploader = $(config.param.placeAt);
		
		$uploader.find('#' + obj.fileId).find('i.fa-trash').click(function(){
			$uploader.find('#' + obj.fileId).remove();
			if($uploader.find('#' + 'edit-' + obj.fileId)[0]){
				$uploader.find('#' + 'edit-' + obj.fileId).remove();
			}
			delete $scope[config.uploader].data[obj.fileId];
		});
		
		if(config.edit){
			$uploader.find('#' + obj.fileId).find('i.fa-pencil').click(function(){
				
				//编辑面板
				var $editPanel = $uploader.find('#' + 'edit-' + obj.fileId);
				
				if($editPanel[0]){
					
					//如果已打开则先获取数据再关闭
					getData($scope,config,obj.fileId);
					$editPanel.remove();
					
				}else{
					var editPanel = '';
					if(content){//如果content有值，则说明file类别已固定，不需要再向后台请求数据
						addEditPanel($scope,config,obj,content);
					}else{
						var url = html(config,obj.fileId);
						$.post(url).done(function(data){
							console.info(data);
						}).fail(function(response){
							addEditPanel($scope,config,obj,response.responseText);
						});
					}
					
					
				}
			});
		}
	};
	
	var addEditPanel = function($scope,config,obj,content){
		var $uploader = $(config.param.placeAt);
		var $td = $uploader.find('#' + obj.fileId);
		var editPanel = '<tr style="text-align:left;" id="edit-' + obj.fileId  + '"><td colspan="3"><div class="multi-edit-panel">' + content + '</div></td></tr>';
		$td.after(editPanel);
		delEditItem(config,obj.fileId);
		changeId(obj.fileId);
		dataInit({
			id : obj.fileId,
			uploader : config.uploader,
			$scope : $scope,
			name : obj['detail-name']
		});
		initInputSelect($scope,config,obj.fileId);
		$('#' + 'edit-' + obj.fileId).find('.upload-info-li').append('<img alt="' + obj['detail-name'] + '" src="' + rets[obj.fileId] + '"/>');
	};
	
	//处理不必要的编辑项
	var delEditItem = function(config,id){
		for(var prop in config.template){
			if(!config.template[prop]){
				var item = $('#' + 'edit-' + id).find('#' + prop).parent().parent();
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
	
	//获取增加的数据
	result.addData = function($scope,uploader){
		result.getAllData($scope,uploader);
		var addData = {};
		var allData = $scope[uploader].data;
		var originData = data[uploader];
		var originIds = '';
		if(originData){
			for(var prop in originData){
				originIds = originIds + prop + ' ';
			}
			for(var property in allData){
				if(originIds.indexOf(property) < 0){
					addData[property] = allData[property];
				}
			}
		}else{
			addData = allData;
		}
		return addData;
	};
	
	//获取修改的数据
	result.modifyData = function($scope,uploader){
		result.getAllData($scope,uploader);
		var modifyData = {};
		var allData = $scope[uploader].data;
		var originData = data[uploader];
		var originIds = '';
		if(originData){
			for(var prop in originData){
				originIds = originIds + prop + ' ';
			}
			for(var property in allData){
				if(originIds.indexOf(property) >= 0){
					modifyData[property] = allData[property];
				}
			}
		}
		
		return modifyData;
	};
	
	//获取删除的数据
	result.delData = function($scope,uploader){
		result.getAllData($scope,uploader);
		var delData = {};
		var allData = $scope[uploader].data;
		var originData = data[uploader];
		var ids = '';
		if(originData){
			for(var prop in allData){
				ids = ids + prop + ' ';
			}
			for(var property in originData){
				if(ids.indexOf(property) < 0){
					delData[property] = originData[property];
				}
			}
		}
		
		return delData;
	};
	
	return result;
});