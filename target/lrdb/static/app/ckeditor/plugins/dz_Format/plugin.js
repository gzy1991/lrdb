
CKEDITOR.plugins.add( 'dz_Format',
{
	requires : [ 'richcombo', 'styles' ],

	init : function( editor )
	{
		var config = editor.config,
			lang = editor.lang.format;

		// Gets the list of tags from the settings.
		var tags = config.format_tags.split( ';' );

		// Create style objects for all defined styles.
		var styles = {};
		for ( var i = 0 ; i < tags.length ; i++ )
		{
			var tag = tags[ i ];
			styles[ tag ] = new CKEDITOR.style( config[ 'format_' + tag ] );
			styles[ tag ]._.enterMode = editor.config.enterMode;
		}

		editor.ui.addRichCombo( 'Dz_Format',
			{
				label : lang.label,
				title : lang.panelTitle,
				className : 'cke_format',
				panel :
				{
					css : editor.skin.editor.css.concat( config.contentsCss ),
					multiSelect : false,
					attributes : { 'aria-label' : lang.panelTitle }
				},

				init : function()
				{
					this.startGroup( lang.panelTitle );

					for ( var tag in styles )
					{
						var label = lang[ 'tag_' + tag ];

						// Add the tag entry to the panel list.
						this.add( tag, '<' + tag + '>' + label + '</' + tag + '>', label );
					}
				},

				onClick : function( value )
				{
					editor.focus();
					editor.fire( 'saveSnapshot' );

					styles[ value ].apply( editor.document );

					// Save the undo snapshot after all changes are affected. (#4899)
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
											editor.getSelection().getStartElement().hasClass('GenDirClass')){
										
										this.setValue( '格式' );
										
									}else{
																				
										if ( tag != currentTag )
											this.setValue( tag, editor.lang.format[ 'tag_' + tag ] );
										
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

/**
 * A list of semi colon separated style names (by default tags) representing
 * the style definition for each entry to be displayed in the Format combo in
 * the toolbar. Each entry must have its relative definition configuration in a
 * setting named "format_(tagName)". For example, the "p" entry has its
 * definition taken from config.format_p.
 * @type String
 * @default 'p;h1;h2;h3;h4;h5;h6;pre;address;div'
 * @example
 * config.format_tags = 'p;h2;h3;pre'
 */
CKEDITOR.config.format_tags = 'p;h1;h2;h3;h4;h5;h6;pre;address;div';
CKEDITOR.config.format_p = { element : 'p' };
CKEDITOR.config.format_div = { element : 'div' };
CKEDITOR.config.format_pre = { element : 'pre' };
CKEDITOR.config.format_address = { element : 'address' };
CKEDITOR.config.format_h1 = { element : 'h1' };
CKEDITOR.config.format_h2 = { element : 'h2' };
CKEDITOR.config.format_h3 = { element : 'h3' };
CKEDITOR.config.format_h4 = { element : 'h4' };
CKEDITOR.config.format_h4 = { element : 'h5' };
CKEDITOR.config.format_h4 = { element : 'h6' };
