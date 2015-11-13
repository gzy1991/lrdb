(function()
{
	var templateDescCmd =
	{
		modes : { wysiwyg:1, source:1 },
		canUndo : false,
		exec : function( editor )
		{
			var sHTML,
				config = editor.config,
				baseTag = config.baseHref ? '<base href="' + config.baseHref + '"/>' : '';

			var bodyHtml = '<body ',
					body = editor.document && editor.document.getBody();

			if ( body )
			{
				if ( body.getAttribute( 'id' ) )
					bodyHtml += 'id="' + body.getAttribute( 'id' ) + '" ';
				if ( body.getAttribute( 'class' ) )
					bodyHtml += 'class="' + body.getAttribute( 'class' ) + '" ';
			}

			bodyHtml += '>';

			var bodyData = $('<div>'+editor.getData()+'</div>');
			var strhfontinfo = 
				'字体：' +
				bodyData.find('h1').eq(0).css('font-family') +
				'\r\n字体大小：' + bodyData.find('h1').eq(0).css('font-size') +
				'\r\n' + (bodyData.find('h1').eq(0).css('font-weight')?'加粗':'');
			var strpfontinfo = 
				'字体：' +
				bodyData.find('h2').eq(0).css('font-family') +
				'\r\n字体大小：' + bodyData.find('h2').eq(0).css('font-size');
			bodyData.find('h1').attr('title', function(){
				return strhfontinfo;//'黑体，14号字';
			});
			bodyData.find('h2').attr('title', function(){
				return strpfontinfo;//'字体：arial；字体大小：14';
			});
			
			sHTML =
				editor.config.docType +
				'<html dir="' + editor.config.contentsLangDirection + '">' +
				'<head>' +
				baseTag +
				'<title>' + '模板说明' + '</title>' +
				CKEDITOR.tools.buildStyleHtml( editor.config.contentsCss ) +
				'</head>' + bodyHtml +
				bodyData.html() +
				'</body></html>';

			var iWidth	= 640,	// 800 * 0.8,
				iHeight	= 420,	// 600 * 0.7,
				iLeft	= 80;	// (800 - 0.8 * 800) /2 = 800 * 0.1.
			try
			{
				var screen = window.screen;
				iWidth = Math.round( screen.width * 0.8 );
				iHeight = Math.round( screen.height * 0.7 );
				iLeft = Math.round( screen.width * 0.1 );
			}
			catch ( e ){}
			
			var oWindow = window.open( '', null, 'toolbar=yes,location=no,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width=' +
				iWidth + ',height=' + iHeight + ',left=' + iLeft );
			oWindow.document.open();
			oWindow.document.write( sHTML );
			oWindow.document.close();
		}
	};

	var pluginName = 'dz_templateDesc';

	CKEDITOR.plugins.add( pluginName,
	{
		init : function( editor )
		{
			editor.addCommand( pluginName, templateDescCmd );
			editor.ui.addButton( 'Dz_templateDesc',
				{
					label : '模板说明',
					command : pluginName,
					icon : CKEDITOR.getUrl( this.path + 'images/templateDesc.gif' )
				});
		}
	});
})();
