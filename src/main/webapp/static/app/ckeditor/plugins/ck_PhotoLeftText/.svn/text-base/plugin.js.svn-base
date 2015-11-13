
(function()
{	
	function execPhotoLeftText( editor ){

		var eleSelpic = editor.getSelection().getStartElement();
		if ( 'img' == eleSelpic.getName())
		{
			eleSelpic.setStyle('float', 'left');
		}
		
	}
	
	var PhotoLeftTextCommand = 
	{
		async : true,
		exec : function( editor ) {
			execPhotoLeftText( editor );
		}
	};
	
	var photoTextPluginN = 'ck_PhotoLeftText';
	
	CKEDITOR.plugins.add(photoTextPluginN,
	{
		
		init : function( editor )
		{
			editor.addCommand( photoTextPluginN, PhotoLeftTextCommand);
			editor.ui.addButton('Ck_PhotoLeftText',
				{
					label : "图片居左环绕",
					command : photoTextPluginN,
					icon : CKEDITOR.getUrl( this.path + 'images/photoLeftText.gif' )
				});
		}
	});
	
})();

