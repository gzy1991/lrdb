
(function()
{	
	function execPhotoText( editor ){

		var eleSelpic = editor.getSelection().getStartElement();
		if ( 'img' == eleSelpic.getName())
		{
			eleSelpic.removeStyle('float');
		}
		
	}
	
	var PhotoTextCommand = 
	{
		async : true,
		exec : function( editor ) {
			execPhotoText( editor );
		}
	};
	
	var photoTextPluginN = 'ck_PhotoText';
	
	CKEDITOR.plugins.add(photoTextPluginN,
	{
		
		init : function( editor )
		{
			editor.addCommand( photoTextPluginN, PhotoTextCommand);
			editor.ui.addButton('Ck_PhotoText',
				{
					label : "图片嵌入",
					command : photoTextPluginN,
					icon : CKEDITOR.getUrl( this.path + 'images/photoText.gif' )
				});
		}
	});
	
})();

