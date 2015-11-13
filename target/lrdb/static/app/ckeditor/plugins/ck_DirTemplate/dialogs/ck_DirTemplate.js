
CKEDITOR.dialog.add( 'ck_DirTemplate', function ( editor ) {
    return {
        title: '编辑目录模板',
        contents: [
            {
                id: 'dirSettingInfo',
                label: '编辑词条模板',
               
                elements: [{
                	
                    type : 'hbox',
                    widths : [ '60%', '40%' ],
                    children : [
					{
						id : 'actorDirInfo',
                        type: 'html',
                        html: '<div id="actorDirInfoid" style="height:350px;border-right:1px solid #c5c6c4; display:none">' +
                        '<h1>早年经历</h1>' +
                    	'<h1>演艺经历</h1>' +
                    	'<h2>家庭</h2>' +
                    	'<h2>感情</h2>' +
                    	'<h2>参演电影</h2>' + 
                    	'<h2>参演电视剧</h2>' +
                    	'<h2>音乐作品</h2>' +
                    	'<h2>导演作品</h2>' +
                    	'<h2>演唱会</h2>' +
                    	'<h1>社会活动</h1>' +
                    	'<h1>荣誉</h1>' +
                    	'<h1>评价</h1></div>'
					},
						
                    {
                    	id : 'SelDirInfo',
                        type: 'html',
                        style : 'width:95%',
                        onLoad : function()
                        {
                        	var	actorBtn = CKEDITOR.document.getById( "actorid" ),
                        		directorBtn = CKEDITOR.document.getById( "directorid" ),
                        		dirinfo = CKEDITOR.document.getById( "actorDirInfoid" );
                        	
                        	var diretorInfostr = '<div id="directorDirInfoid" style="display:none">' +
                        	'<h1>人物生活</h1>' +
                        	'<h1>个人生活</h1>' +
                        	'<h1>作品</h1>' +
                        	'<h1>荣誉</h1>' +
                        	'<h1>评价</h1></div>';
                        	
                        	var actorDirInfostr = dirinfo.getOuterHtml();
                        	var jqdir = $(dirinfo.getOuterHtml());
                        	
                        	if (actorBtn){
                        		actorBtn.on( 'click', function(evt)
        						{
                        			dirinfo.removeStyle( 'display');
                        			jqdir = $(actorDirInfostr);
                        			
                        			jqdir.find('h1').css({
                                		'font-size'	 : '18px',
                            			'font-weight' : 'normal',
                            			'line-height' : '24px',
                            			'margin' : '0',
                            			'padding' : '0 0 0 15px'
                                	});
                                	jqdir.find('h2').css({
                                		'font-size'	 : '16px',
                            			'font-weight' : 'normal',
                            			'line-height' : '24px',
                            			'margin' : '0',
                            			'padding' : '0 0 0 30px'
                                	});
                        			dirinfo.setHtml(jqdir.html());
        						}, this.getDialog() );
                        		actorBtn.on( 'mouseover', function()
								{
									this.addClass( 'cke_btn_over' );
									
								}, actorBtn );
                        		actorBtn.on( 'mouseout', function()
								{
									this.removeClass( 'cke_btn_over' );
									
								}, actorBtn );
                        	}
                        	
                        	if ( directorBtn )
							{
                        		
                        		directorBtn.on( 'click', function(evt)
								{
									dirinfo.removeStyle( 'display');
									jqdir = $(diretorInfostr);
									
									jqdir.find('h1').css({
		                        		'font-size'	 : '18px',
		                    			'font-weight' : 'normal',
		                    			'line-height' : '24px',
		                    			'margin' : '0',
		                    			'padding' : '0 0 0 15px'
		                        	});
									dirinfo.setHtml(jqdir.html());
									
								}, this.getDialog() );
                        		directorBtn.on( 'mouseover', function()
								{
									this.addClass( 'cke_btn_over' );
								}, directorBtn );
                        		directorBtn.on( 'mouseout', function()
								{
									this.removeClass( 'cke_btn_over' );

								}, directorBtn );
							}
	                        dirinfo.setStyles({
	                    			'margin-left'	 : '18px',
	                    			'padding-top' : '10px',
	                    			'color' : '#333'
	                    			
	                    	});
                        },
                        
                        html : '<div id="carddivid" class="carddivclass" style="width:250px; float:right; border:1px solid #709cd2; text-align:center"><ul>' +
                    	'<li id="actoridli" role="button" style="border:1px solid #709cd2; text-align:center ; font-size:34px"><a href="javascript:void(0)" role="button" id="actorid" style="width:100px; font-size:24px">演员</a></li>' + 
                    	'<li id="directoridli" role="button" style="border:1px solid #709cd2; text-align:center; font-size:34px"><a href="javascript:void(0)" role="button" id="directorid" style="font-size:24px">导演</a></li>' +
                    	'</ul></div>'
                     }
                                
                   ]
                }]
            }
            
        ],

        onOk: function()
        {
        	var actorDirInfoHtml = CKEDITOR.document.getById( "actorDirInfoid" );
        	var jqDirInfo = $(actorDirInfoHtml.getOuterHtml());
        	
        	jqDirInfo.find('h1').removeAttr("style").css({
        		'font-size' : '16px',
        		'font-weight' : 'bold',
        		'font-family' : '宋体',
        		'line-height' : '24px',
        		'border-bottom' : '1px solid #dedfe1',
        		'padding-bottom' : '5px',
        		'margin' : '35px 0 5px'
        		
        	}).addClass('GenDirClass');
        	jqDirInfo.find('h2').removeAttr("style").css({
        		'font-size' : '15px',
        		'font-family' : 'Arial',
        		'line-height' : '22px',
        		'margin' : '22px 0 12px'
        		
        	}).addClass('GenDirClass');
        	
        	editor.setData(jqDirInfo.html());
        }
    };
});