
(function()
{
	CKEDITOR.plugins.add('ck_delDirInfo',{
		init:function(editor){
			editor.addCommand( 'ck_delDirInfo', new CKEDITOR.delDirInforCommand());
			editor.ui.addButton('Ck_delDirInfo',{label:"删除目录信息",command:'ck_delDirInfo',icon:CKEDITOR.getUrl( this.path + 'images/delDirInfo.png' )});
		}
	});
})();

CKEDITOR.delDirInforCommand = function(){};
CKEDITOR.delDirInforCommand.prototype =
{
	async:true,
	exec : function( editor )
	{
		delDirInfor(editor);
	}
};

function delDirInfor(editor){
	
	var jqAllEle = $('<div>'+editor.getData()+'</div>');
	
	jqAllEle.find('#dirid').remove();
	jqAllEle.find('#divul').remove();
	jqAllEle.find('h1').removeClass('GenDirClass');
	jqAllEle.find('h2').removeClass('GenDirClass');
	jqAllEle.find('h1 a').remove();
	jqAllEle.find('h2 a').remove();
	
	editor.setData(jqAllEle.html());
}