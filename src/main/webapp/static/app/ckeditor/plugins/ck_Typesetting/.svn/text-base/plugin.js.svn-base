
(function()
{	
	function showSettingDialog( editor )
	{
		
		var entity = {};
		entity.firLineIndent = entity.justify = entity.phoCenter = 'N';
		var jqhtml = $('<div></div>');
		jqhtml.append($(editor.getData()));
		
		function ExecParaPre(num){
			jqhtml.find('p').css('margin-top',num);
		}
		function ExecParaAfter(num){
			jqhtml.find('p').css('margin-bottom',num);
		}
		function ExecRowSpan(num){
			jqhtml.find('p,p span').css('line-height', num);
		}
		
		function firLineIndent(){
			jqhtml.find('p').css('text-indent', '2em');
		}
		function justify(){
			jqhtml.find('p,p span').css('text-align', 'justify');
		}
		function phoCenter(){
			
			$.each (jqhtml.find('p'), function(i,e){
				if ( $(e).has('img').length ){
					
					$('<p style="text-align : center"></p>').insertBefore($(e)).append($(e).find('img').css('float',''));
					
				}
			});
			
		}
		
		function remembarSelId(){
			$.ajax({
	            url: getServer()+'/sword/ckeditor/formatTypeSetting/Update',
	            data : {formatEntity : JSON.stringify(entity)},
	            type: 'POST',
	            async: false,
	            dataType: 'json',
	            success : function(data){
	            	
	            }
	            
	        });
		}
		require(["PDUtilDir/dialog"],function(Dialog)
		{
			
			var dialog = Dialog({
				
				//id : 'DialogInfoID',
				cache : false,
				title : '一键排版设置',
				width : '650px',
				modal : true,
				drag  : true,
				url : getStaticPath() + '/app/common/ckeditor/views/typeSetting.html',
				
		  		buttons:[
		  		         {
		  		    	   name:'确定',
		  		    	   callback:function(dialog){
		  		    		   
		  		    		   	dialog.hide();
		  		    		   	
		  		    		   	ExecParaPre($('#paraPreId').val()+'px');
		  		    		   	entity.paraPreNum = $('#paraPreId').val();
		  		    		   	ExecParaAfter($('#paraAfterId').val()+'px');
		  		    		   	entity.paraAfterNum = $('#paraAfterId').val();
		  		    		   	ExecRowSpan($('#rowSpanId').val()+'px');
		  		    		   	entity.rowSpanNum = $('#rowSpanId').val();

		 						if ( document.getElementById("firLineIndentId").checked ){
		 							
		 							firLineIndent();
		 							entity.firLineIndent = 'Y';
		 						}
		 						if ( document.getElementById("justifyId").checked ){
		 							
		 							justify();
		 							entity.justify = 'Y';
		 						}
		 						if ( document.getElementById("phoCenterId").checked ){
		 							
		 							phoCenter();
		 							entity.phoCenter = 'Y';
		 						}
		 						if ( document.getElementById("remembarSelId").checked ){
		 							
		 							remembarSelId();
		 						}

		 						jqhtml.find('p,p span').css({
		 							'font-family' :  $('#selFont').val(),
		 							'font-size' : $('#selFontSize').val()+'px'
		 						});
		 						
		 						editor.setData(jqhtml.html());
		  		    	   }
		   		         }
		  		       ],
		  		       
		  		 afterLoad:function(dialog){
		  			 
		  		 }   	
		       });

			dialog.show();
			
		});
	}
	
	function execlrdbTypesetting( editor )
	{
		showSettingDialog(editor);
	}
	
	var lrdbTypesettingCommand = 
	{
		async : true,
		exec : function( editor ) {
			execlrdbTypesetting( editor );
		}
	};
	
	var pluginName = 'ck_Typesetting';
	
	CKEDITOR.plugins.add(pluginName,
	{
		
		init : function( editor )
		{
			editor.addCommand( pluginName, lrdbTypesettingCommand);
			editor.ui.addButton('Ck_Typesetting',
			{
				label : "一键排版设置",
				command : pluginName,
				icon : CKEDITOR.getUrl( this.path + 'images/ck_Typesetting.png' )
			});
		}
	});
	
})();
