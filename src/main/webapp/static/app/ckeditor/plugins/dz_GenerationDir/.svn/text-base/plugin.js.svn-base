
(function()
{
	function DelDirInfo( editor )
	{
		var jqAllEle = $('<div>'+editor.getData()+'</div>');
		
		jqAllEle.find('#dirid').remove();
		jqAllEle.find('#divul').remove();
		jqAllEle.find('h1 a').remove();
		jqAllEle.find('h2 a').remove();
		
		return jqAllEle.html();
	}
	
	function GenerationDir( editor ){
		
		var	jqElement = $(editor.getData());
		
		if ( jqElement.hasClass('GenDirClass') )
		{

			if (jqElement.hasClass('DirTitle'))
			{
				jqElement = $(DelDirInfo(editor));
				
			}
			var bodyHtml = $('<body></body>');
			var jqheadbodystr = $('<div id="dirid" class="DirTitle"></div>');
			jqheadbodystr.css({
				'margin' : '0px',
				'padding' : '25px 0px 25px 8px',
				'line-height' : '30px',
				'width' : '20px',
				'background-color' : 'rgb(53, 151, 250)',
				'bord-right-color' : 'rgb(5, 89, 175)',
				'border-right-style' : 'solid',
				'border-right-width' : '3px',
				'position' : 'absolute',
				'left' : '18px',
				'top' : '15px'
			});
			var jqh3 = $('<h3 id="dirh3">目录</h3>');
			jqh3.css({
				'margin' : '0px',
				'padding' : '0px',
				'fone-size' : '14px',
				'color' : 'rgb(255, 255, 255)'
			});
			jqheadbodystr.append(jqh3);
			var jqul = $('<ul class="uli3"></ul>');
			jqul.css({
				'margin' : '0px 0px 0px -1px',
				'padding' : '0px',
				'width' : '218px',
				'float' : 'left',
				'border-left-width' : '1px',
				'border-left-style' : 'solid',
				'border-left-color' : 'rgb(245, 245, 245)',
				'min-height' : '120px'
			});
			var jqdivul = $('<div id="divul"></div>');
			jqdivul.css({
				'margin' : '0px 0px 0px 49px',
				'padding' : '8px 0px 0px',
				'border-left-color' : 'rgb(237, 237, 237)',
				'border-left-style' : 'solid',
				'border-left-width' : '1px',
				'zoom' : '1',
				'overflow' : 'hidden'
			});
			var selMap = {
					//'Dir' : 'Dir',
					'h1' : 'h1',
					'h2' : 'h2',
				};
			var iCatalog = 1;
			$.each(jqElement, function(i,e){
				
				if (e.tagName && 
						selMap[e.tagName.toLowerCase()] && 
						$(e).hasClass('GenDirClass') )
				{
					var strhref = "href=#"+e.tagName+i;
					var lifontsz = '15px';
					var spanleft = '5px';
					var aleft = '7px';
					var dirTil = '一级目录';
					var strCatalog = '*';
					if ('h1' == e.tagName.toLowerCase())
					{
						strCatalog = iCatalog++;
						
					}else{
						 lifontsz = '10px';
						 spanleft = '18px';
						 aleft = '10px';
						 dirTil = '二级目录';
					}
					var bodystr = '<div><li>'
						+'	<span>'+strCatalog+'</span><a '
						+ strhref+' catalogkey='+iCatalog+' class="bold" title='+dirTil+'>'
						+ e.innerText +'</a></li></div>';
					var jqbody = $(($(bodystr)).find('li')[0]);
					jqbody.css({
						'margin' : '3px 0px 0px',
						'padding' : '0px 5px 0px 30px',
						'list-style' : 'none',
						'line-height' : '21px',
						'position' : 'relative',
						'font-size' : lifontsz,
						'work-break' : 'break-all'
					});
					$(jqbody.find('span')[0]).css({
						'display' : 'block',
						'width' : '18px',
						'padding-right' : '8px',
						'text-align' : 'right',
						'color' : 'rgb(2, 103, 167)',
						'position' : 'absolute',
						'top' : '0px',
						'left' : spanleft
					});
					$(jqbody.find('a')[0]).css({
						'color' : 'rgb(2, 104, 205)',
						'font-weight' : 'bold',
						'text-decoration' : 'none',
						'margin-left' : aleft
					});
	
					jqul.append(jqbody[0].outerHTML);
					
				}
			});
			jqdivul.append(jqul);
			bodyHtml.html(jqheadbodystr[0].outerHTML+jqdivul[0].outerHTML);
			
			$.each(jqElement, function(i,e){
				
				if( e.tagName && 
						selMap[e.tagName.toLowerCase()]&& 
						$(e).hasClass('GenDirClass') )
				{
					
					var strname = "name="+e.tagName+i;
					var strid = " id="+e.tagName+i;
					var strhml = '<a ' + strname + strid +'></a>';				
					$(e).html(function(idx, val){
						return strhml+val;
					});
				}
				
				bodyHtml.append(e);
			});
			
		    editor.setData(bodyHtml.html());
		}
		else
		{
			alert('提示：请先选择要生成的目录信息或者先清空已有目录！');
		}
		
	}
	
	var GenDirCommand = 
	{
		async : true,
		exec : function( editor ) {
			GenerationDir( editor );
		}
	};
	
	var genPluginN = 'dz_GenerationDir';
	
	CKEDITOR.plugins.add(genPluginN,
	{
		
		init : function( editor )
		{
			editor.addCommand( genPluginN, GenDirCommand);
			editor.ui.addButton('Dz_GenerationDir',
				{
					label : "生成目录",
					command : genPluginN,
					icon : CKEDITOR.getUrl( this.path + 'images/GenDir.png' )
				});
		}
	});
	
})();

