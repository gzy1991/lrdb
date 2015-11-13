
CKEDITOR.editorConfig = function( config )
{
	config.toolbar = 'Full';
	config.toolbar_Full = [
	                       ['Source','-','Save','NewPage','-','Templates'],
	                       ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
	                       ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	                       ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
	                       ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'], 
	                       '/',      
	                        ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
	                        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	                        ['Link','Unlink','Anchor'],
	                        ['Maximize', 'ShowBlocks'],
	                        '/', 
	                       ['Dz_InsTitileDir','Dz_GenerationDir','Ck_delDirInfo','Ck_DirTemplate','Dz_templateDesc','-'],
	                       ['Lar_upload','Ck_PhotoLeftText', 'Ck_PhotoText', 'Ck_PhotoRightText'],
	                       ['Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
	                       '/',
	                        ['Styles','Font','FontSize','Dz_Format'],
	                        ['Autoformat'],
	                        ['TextColor','BGColor','-'],
	                        
	                       
	                    ];
	config.extraPlugins = "dz_GenerationDir,ck_delDirInfo,dz_InsTitileDir,dz_Format,autoformat,dz_templateDesc,ck_DirTemplate,ck_PhotoLeftText,ck_PhotoText,ck_PhotoRightText,lar_upload";
	config.allowedContent = true; 
	// 字体列表
	config.toolbarCanCollapse=true;
	config.font_names = '宋体;楷体;黑体;Arial;Times New Roman;Verdana';
	// 默认字体
	config.font_defaultLabel = '宋体';
	config.filebrowserUploadUrl="/lrdb/sword/PicUploadController?SwordControllerName=PicUploadController";
	config.filebrowserImageUploadUrl = getServer+'/lrdb/sword/PicUploadController?SwordControllerName=PicUploadController';
};
