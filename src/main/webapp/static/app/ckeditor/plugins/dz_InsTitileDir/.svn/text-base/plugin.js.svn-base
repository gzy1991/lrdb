
CKEDITOR.plugins.add( 'dz_InsTitileDir',
{
	requires : [ 'richcombo', 'styles' ],

	init : function( editor )
	{
		var config = editor.config,
			lang = editor.lang.format;
		var dirTil = '目录';
		var langDir = ["一级目录","二级目录"];
		var selDirObj = {
				'h1' : '一级目录',
				'h2' : '二级目录'
		};
		var tags = config.Dirs_tags.split( ';' );
		var styles = {};
		for ( var i = 0 ; i < tags.length ; i++ )
		{
			var tag = tags[ i ];
			styles[ tag ] = new CKEDITOR.style( config[ 'dirSetting_' + tag ] );
			styles[ tag ]._.enterMode = editor.config.enterMode;
		}
		editor.ui.addRichCombo( 'Dz_InsTitileDir',
			{
				label : dirTil,
				title : dirTil,
				panel :
				{
					css : editor.skin.editor.css.concat( config.contentsCss ),
					multiSelect : false,
					attributes : { 'aria-label' : dirTil }
				},

				init : function()
				{
					this.startGroup(dirTil);
					var i=0;
					for ( var tag in styles )
					{
						var label = langDir[i++];
						// Add the tag entry to the panel list.
						this.add( tag, '<' + tag + '>' + label + '</' + tag + '>', label );
					}
				},

				onClick : function( value )
				{
					editor.focus();
					editor.fire( 'saveSnapshot' );
					styles[ value ].apply( editor.document );
					editor.getSelection().getStartElement().addClass('GenDirClass');					
					setTimeout( function()
					{
						editor.fire( 'saveSnapshot' );
					}, 0 );
				},

				onRender : function()
				{
					editor.on( 'selectionChange', function( ev )
						{
							var currentTag = this.getValue();
							var elementPath = ev.data.path;
							for ( var tag in styles )
							{
								if ( styles[ tag ].checkActive( elementPath ) )
								{
									if ( ('h1' == tag || 'h2' == tag ) &&
											editor.getSelection().getStartElement().hasClass('GenDirClass'))
									{
										if ( tag != currentTag ){
											this.setValue( tag, selDirObj[tag] );
										}
									}else
									{
										this.setValue( tag, '目录' );
									}
									return;
								}
							}

							// If no styles match, just empty it.
							this.setValue( '' );
						},
						this);
				}
			});
	}
});

CKEDITOR.config.Dirs_tags = 'h1;h2';
CKEDITOR.config.dirSetting_Dir1 = { element : 'Dir1' };
CKEDITOR.config.dirSetting_h1 = { element : 'h1' };
CKEDITOR.config.dirSetting_Dir2 = { element : 'Dir2' };
CKEDITOR.config.dirSetting_h2 = { element : 'h2' };
