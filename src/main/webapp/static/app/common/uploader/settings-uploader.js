/**
 * @author sarah
 */

define([],function(){
	
	//需要获取的字典数据url
	var urls = {
			url_arttype : getServer() + '/static/app/common/data/artType.json',
			url_org : getServer() + '/static/app/common/data/orgTree.json',
			url_format_doc : getServer() + '/static/app/common/data/docFormat.json',
			url_format_img : getServer() + '/static/app/common/data/imgFormat.json',
			url_format_audio : getServer() + '/static/app/common/data/audioType.json',
			url_format_video : getServer() + '/static/app/common/data/videoType.json',
			url_theme : getServer() + '/static/app/common/data/standardLabels.json',
			url_secretLevel : getServer() + '/static/app/common/data/secretLevel.json',
			url_status : getServer() + '/static/app/common/data/resStatus.json',
			url_subtitle : getServer() + '/static/app/common/data/subtitles.json'
	};
	
	
	//文件编辑内容属性字段转换
	var key = {
			'detail-arttype' : 'detailArttype',
			'detail-belongOrg' : 'detailBelongOrg',
			'detail-format' : 'detailFormat',
			'detail-standardTheme' : 'detailStandardTheme',
			'detail-secretLevel' : 'detailSecretLevel',
			'detail-status' : 'detailStatus',
			'detail-subtitles' : 'detailSubtitles',
			'detail-name' : 'detailName',
			'detail-userTheme' : 'detailUserTheme',
			'detail-language' : 'detailLanguage',
			'detail-remark' : 'detailRemark',
			'detail-intro' : 'detailIntro',
			'detail-timing' : 'detailTiming',
			'detail-pixel' : 'detailPixel',
			'detail-resolution' : 'detailResolution',
			'detail-definition' : 'detailDefinition'
	};
	
	//上传文件路径
	var remoteUrl = getServer() + '/sword/fileUploadController?SwordControllerName=fileUploadController';
	//字典数据字段转换
	var dataField = {
		id : 'id',
		name : 'name',
		data : 'data'
	};
	
	//编辑模板html存放地址
	var htmlAddr = {
		img : getStaticPath() + '/app/common/uploader/detailHtml/imgHtml.html',
		doc : getStaticPath() + '/app/common/uploader/detailHtml/docHtml.html',
		audio : getStaticPath() + '/app/common/uploader/detailHtml/audioHtml.html',
		video : getStaticPath() + '/app/common/uploader/detailHtml/videoHtml.html'
	};
	
	return {
		urls : urls,
		key : key,
		remoteUrl : remoteUrl,
		dataField : dataField,
		htmlAddr : htmlAddr
	};
	
});
