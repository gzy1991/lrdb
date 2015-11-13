
(function()
{	
	function execPhotoRightText( editor ){

		var eleSelpic = editor.getSelection().getStartElement();
		if ( 'img' == eleSelpic.getName())
		{
			eleSelpic.setStyle('float', 'right');
		}
		
	}
	
	var PhotoRightTextCommand = 
	{
		async : true,
		exec : function( editor ) {
			execPhotoRightText( editor );
		}
	};
	
	var photoTextPluginN = 'ck_PhotoRightText';
	
	CKEDITOR.plugins.add(photoTextPluginN,
	{
		
		init : function( editor )
		{
			editor.addCommand( photoTextPluginN, PhotoRightTextCommand);
			editor.ui.addButton('Ck_PhotoRightText',
				{
					label : "图片居右环绕",
					command : photoTextPluginN,
					icon : CKEDITOR.getUrl( this.path + 'images/photoRightText.gif' )
				});
		}
	});
	
})();

