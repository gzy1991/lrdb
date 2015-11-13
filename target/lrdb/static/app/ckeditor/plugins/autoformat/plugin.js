(function()
{
	CKEDITOR.plugins.add('autoformat',{
		init:function(editor){
			editor.addCommand( 'autoformat', new CKEDITOR.autoformatCommand());
			editor.ui.addButton('Autoformat',{label:"一键排版",command:'autoformat',icon:CKEDITOR.getUrl( this.path + 'images/autoformat.png' )});
		}
	});
})();

CKEDITOR.autoformatCommand = function(){};
CKEDITOR.autoformatCommand.prototype =
{
	async:true,
	exec : function( editor )
	{
		FormatText(editor);
	}
};

function FormatText(editor){
	var blockMap = {
		'blockquote' : 'blockquote',
		'center' : 'center',
		'div' : 'div',
		'h1' : 'h1',
		'h2' : 'h2',
		'h3' : 'h3',
		'h4' : 'h4',
		'h5' : 'h5',
		'h6' : 'h6',
		'p' : 'p'
	};
	
	// 取出编辑器的内容
	var allDataElement = $(editor.getData());
	var e;
	var bodyHtml = $("<body></body>");
	for(var i=0;i<allDataElement.length;i++){
		e = allDataElement[i];
		if( e.tagName && blockMap[e.tagName.toLowerCase()]){
			$(e).html($(e).html().replace(/^(\s|&nbsp;|　)+/ig, ''));
			$(e).css('text-indent', '2em');
		}
		
		bodyHtml.append(e);
	}
	editor.setData(bodyHtml.html());
}