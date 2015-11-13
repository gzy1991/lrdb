
(function()
{

	var pluginName = 'ck_DirTemplate';

	CKEDITOR.plugins.add( pluginName,
	{
		requires: [pluginName],
		init : function( editor )
		{
			editor.addCommand( pluginName,  new CKEDITOR.dialogCommand( pluginName));
			editor.ui.addButton( 'Ck_DirTemplate',
				{
					label : '目录模板',
					command : pluginName,
					icon : CKEDITOR.getUrl( this.path + 'images/ck_DirTemplate.png' )
				});
			CKEDITOR.dialog.add( pluginName, this.path + 'dialogs/ck_DirTemplate.js' );
		}
	
	});
})();
