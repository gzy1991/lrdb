
(function()
{	
	function AutoFormat( editor )
	{
		var jqhtml = $('<div></div>');
		jqhtml.append($(editor.getData()));
		
		$.ajax({
            url: getServer()+'/sword/ckeditor/formatTypeSetting/query',
            data:
            {
            	formatsettingId : 'eij128g8eb25432f812t65g4bfc94ca2'
            		
            },
            type: 'POST',
            async: false,
            dataType: 'json',
            success : function(data){	 
            	
            	var entity = data.entity;
            	jqhtml.find('p').css(
        			{
        				'margin-top' : entity.paraPreNum,
        				'margin-bottom' : entity.paraAfterNum,
        			});
            	
            	jqhtml.find('p,p span').css({
						'font-family' :  entity.selFont,
						'font-size' : entity.selFontSize+'px',
						'line-height' : entity.rowSpanNum
					});
            	
            	if ( document.getElementById("firLineIndentId").checked ){
						
            		jqhtml.find('p').css('text-indent', '2em');
				}
				if ( document.getElementById("justifyId").checked ){
					
					jqhtml.find('p,p span').css('text-align', 'justify');
				}
				if ( document.getElementById("phoCenterId").checked ){
					
					$.each (jqhtml.find('p'), function(i,e){
						if ( $(e).has('img').length ){
										
							$('<p style="text-align : center"></p>').insertBefore($(e)).append($(e).find('img').css('float',''));

						}
					});
				}
                
            }
            
        });
	}
	
	function execlrdb( editor )
	{
		AutoFormat( editor );
	}
	
	var lrdbCommand = 
	{
		async : true,
		exec : function( editor ) {
			execlrdb( editor );
		}
	};
	
	var pluginName = 'ck_Format';
	
	CKEDITOR.plugins.add(pluginName,
	{
		
		init : function( editor )
		{
			editor.addCommand( pluginName, lrdbCommand);
			editor.ui.addButton('Ck_Format',
			{
				label : "一键排版",
				command : pluginName,
				icon : CKEDITOR.getUrl( this.path + 'images/ck_Format.png' )
			});
		}
	});
	
})();
