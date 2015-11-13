define(["PDUtilDir/grid",
        "PDUtilDir/util",
        "PDUtilDir/tool",
        "LocalZTree"],function(Grid,Util,Tool,LocalZTree){
	//  该文件需要做成一个类，根据tree和simple生成两个不同的实例~~注意边界问题
	var Type_SimpleDict="simple",Type_TreeDict="tree";
	function Dict(config){
		this.dictType=config.dictType;
		this.treeSetting=config.treeSetting;
		this.queryUrl=config.queryUrl;
		this.dictGrid;
		this.dictTree;
	}
	var dictGrid,dictTree;
	var  DefaultRoot="ROOT";		//  默认root值
	
	function initDict(config){
		var _config=$.extend({
			dictType:Type_SimpleDict,
			treeSetting:{},
			queryUrl:getServer()+"/sword/sys/dict/queryDictTreeByRootCode"
		},config);
		var dict=new Dict(_config);
//		dict.dictGrid=dict.createGrid("dictMgrGrid");
		dict.initDictData();
		return dict;
	}
    
	Dict.prototype={
			initDict:initDict,
			initDictData:function(callback){
				var me=this;
				dictGrid=me.dictGrid;
		    	if(!dictGrid){
		    		dictGrid=me.createGrid("dictMgrGrid");
		    		me.dictGrid=dictGrid;
		    	}
		    	var queryUrl="";
		    	var paramData={dictType:me.dictType};
		    	if(me.queryUrl){
		    		queryUrl=me.queryUrl;
		    	}else{
		    		queryUrl=getServer()+"/sword/sys/dict/queryDictTreeByRootCode";
		    	}
				$.ajax({
					url:queryUrl,
					data:paramData,
					type:"post",
					success:function(result){
						dictTree=LocalZTree.init($("#dictMgrTree"),me.treeSetting,result.data);
						me.dictTree=dictTree;
//						renderTreeToobar();
						var rootArr=dictTree.getNodesByParam("parentId",DefaultRoot);
						me.reflushDataGrid(rootArr);
						if(callback){
							callback();
						}
					}
				});
				
			},
			loadDictItems:function(currentNode){
				var me=this;
//		    	console.log("展开下一级~");
		    	var currentSubItems=dictTree.getNodesByParam("parentId",currentNode.id);
		    	me.reflushDataGrid(currentSubItems);
		    },
		//   创建表格
		    createGrid:function(parentId){
		    	var me=this;
			    var dictList=new Grid({
					id:"sys_dict_List_"+new Date().getTime(),                       //用于缓存的ID
			        placeAt:parentId,            //存放Grid的容器ID
			        pageSize:10,                         //一页多少条数据
			        hidden:false,                       //表格是否可隐藏，只显示标题
//				    index:true,                   
				    multi:true,     
			        pagination : true,                  //默认分页,
			        cache:false,
			        layout:[
//			            {name:"id",field:"id",hidden:true},
			            {name:"名称",field:"name",click:function(e){
			            		var item=e.data.row;
			            		me.callSliderBar(item.id,null,null,null);
					        }
			            },
			            {name:"代码",field:"code"},
//			            {name:"parentId",field:"parentId",hidden:true},
			            {name:"别名",field:"shortName"},
			            {name:"排序",field:"codeSequence"},
			            {name:"使用状态",field:"isAlive",width:"100px",
			            	format:function(e){
			            		if(e.row.isAlive==0){ 
			            			return "已禁用";
			            		}else{ 
			            			return "使用中";
			            		}
			            	}
			            }
//			            {name:"rootCode",field:"rootCode",hidden:true}
			        ],
			        toolbar:[
			            {
			            	name:"添加",
			            	icon:"fa fa-plus-circle",
			            	callback:function(event){
			//	            		console.log('添加')
			            		var selected=me.getTreeSelectedNode();
			            		var parentId,rootCode,classification;
			            		if(selected){
			            			parentId=selected.id;
			            			rootCode=selected.rootCode;
			            			classification=selected.dictClassification;
			            			//  非根节点的rootCode都是根节点Id
			            			if(rootCode==DefaultRoot){
			            				rootCode=parentId;
			            			}
			            		}
			            		me.callSliderBar(null,parentId,rootCode,classification);
			            	}
			            },
			            {
			            	name:"修改",
			            	icon:"fa fa-edit",
			            	callback:function(event){
			//	            		console.log('修改')
			            		var rows=event.data.getSelectedRow();
			            		if(rows){
			            			if(rows.length==1){
			            				var item=rows[0];
			            				// 调用侧边栏
			            				me.callSliderBar(item.id,null,null,null);
			            			}else{
			            				Util.alert("每次仅能修改一个字典项！");
			            			}
			            		}else{
			            			Util.alert("请选择要修改的字典项！");
			            		}
			            	}
			            },
			            {
			            	name:"删除",
			            	icon:"fa fa-trash-o",
			            	callback:function(event){
//			            		console.log('删除');
			            		var rows=event.data.getSelectedRow();
			            		if(rows&&rows.length>0){
			            			Util.confirm("请确认是否删除?（<span class=\"text-danger\">存在子节点的字典项无法批量删除</span>）",function(){
				            			// yes
				            			
					            		var ids="",parentId;
					            		$(rows).each(function(i,row){
					            			if(!row.children||row.children.length==0){
					            				ids+=","+row.id;
					            			}else{
//					            				console.log("未删除项"+row.id+" | "+row.name+" | "+row.code);
					            			}
					            		});
					            		ids=ids.substring(1);
					            		var selected=me.getTreeSelectedNode();
					            		parentId=selected  ? selected.id : (rows[0]?rows[0].parentId:DefaultRoot);
					            		$.ajax({
					            			url:window.getServer()+"/sword/sys/dict/deleteDictItems",
					            			data:{"ids":ids,"parentId":parentId},
					            			type:"post",
					            			success:function(data){
//					            				console.log("delete dictitems over");
					            				me.initDictData(function(){
					            					me.expendParent(parentId);
					            				});
					            			}
					            		});
				            		});
			            		}else{
			            			Util.alert("请选择要删除的字典项！");
			            		}
			            		
			            		
			            	}
			            },
			            {
			            	name:"刷新",
			            	icon:"fa fa-refresh",
			            	callback:function(event){
//			            		console.log('刷新');
			            		LocalZTree.destroy("dictMgrTree",function(){
			            			me.initDictData();
			            		});
			            	}
			            }
			        ],
			        data:[]
			    });
			    return dictList;
		    },/**
			 * 调用侧边栏
			 * 1、添加根节点:什么都不传
			 * 2、添加子节点：传入parentid，rootCode
			 * 3、修改：传入id
			 */
		    callSliderBar:function(id,parentid,rootCode,classification){
		    	var me=this;
				var siderBar = null;
				slideconfig.afterLoad=function(){
					$("#name").bind("change",function(){
						var text=$("#name").val();
						$("#name").val(toTxt(text));
					});
					//  保存
					$("#dictItemSaveBtn").bind("click",function(){
						//  校验通过
						var $dictItemForm=$("#dictItemForm");
						if($dictItemForm.valid()){
							$("#dictItemSaveBtn").attr("readonly","readonly");
							var data=Tool.serialize($dictItemForm);
							data.dictType=me.dictType;
							$.ajax({
								url:window.getServer()+"/sword/sys/dict/saveOrUpdateDictItem",
								type:"post",
								data:data,
								success:function(data){
//									console.log("save dict success");
									var pid=$("#parentId").val();
									me.initDictData(function(){
										me.expendParent(pid);
		            				});
									
									//  重置
									siderBar.close();
//									Util.slidebar(slideconfig);
									Util.alert("操作成功！");
								}
							});
						}
					});
					if(id){
						//  查询数据
						$.ajax({
							url:window.getServer()+"/sword/sys/dict/queryDictItemById",
							type:"post",
							data:{"id":id},
							success:function(result){
//								console.log(data);
								var item=result.data;
								Tool.deserialize($("#dictItemForm"),item);
								checkDictClassificationStatus();
							}
						});
					}else if(parentid&&rootCode&&classification){
						$("#parentId").val(parentid);
						$("#rootCode").val(rootCode);
						$("#dictClassification").val(classification);
					}else{
						var node=me.getTreeSelectedNode();
						//  没有选中节点时
						if(!node){
							$("#parentId").val(DefaultRoot);
							$("#rootCode").val(DefaultRoot);
							$("#dictClassification").val("");
						}
					}
					checkDictClassificationStatus();
					me.validateDictItem();
				};
				
				siderBar = Util.slidebar(slideconfig);
			},/**
		     * 展开指定父节点
		     */
			expendParent:function (pid){
				var me=this;
		    	// 展开当前节点
		    	dictTree=LocalZTree.getZTreeObj("dictMgrTree");
				var curParentNode=dictTree.getNodesByParam("id",pid)[0];
				dictTree.expandNode(curParentNode);
				//  表格联动
				if(pid!=DefaultRoot){
					me.loadDictItems(curParentNode);
				}
		    },/**
		     * 重设dictGrid的数据
		     */
		    reflushDataGrid:function (dataArr){
		    	var me=this;
		    	me.dictGrid.reload({
					data:dataArr
				});
		    },/**
		     * 获取选择的单个节点
		     */
		    getTreeSelectedNode:function (){
		    	var me=this;
		    	var dictTree=LocalZTree.getZTreeObj("dictMgrTree");
		    	var nodes=dictTree.getSelectedNodes();
				var curNode=nodes.length>0?nodes[0]:undefined;
				return curNode;
		    },
		    validateDictItem:function(){
		    	var me=this;
		        //数据验证
		        $("#dictItemForm").validate({
		            rules:{
		            	dictClassification:{
		            		required:true,
		            		maxlength:20,
		            		PD_regex: "^\\w+$",
		            		remote:{
		            			type:"POST",
		            			url:getServer()+"/sword/sys/dict/validateDictClassification", //请求的服务
		            			data:{
		            				parentId:function(){return $("#parentId").val();},
		            				dictClassification:function(){ return $("#dictClassification").val(); }
		            			}
		            		}
		            	},
		            	name:{
		            		required:true,
		            		maxlength:40,
		            		remote:{
		                        type:"POST",  //请求方式
		                        url: getServer()+"/sword/sys/dict/validateDictItem", //请求的服务
		                        data:{  //要传递的参数
		                        	id:function(){
		                        		return $("#id").val();
		                        	},
		                            dictName:function(){return toTxt($("#name").val());},
		                            parentId:function(){return $("#parentId").val();}
		                        }
		                    }
		            	},
		        		code:{
		        			required:true,
		        			maxlength:200,
		        			PD_regex: "^\\w+$",
		        			remote:{
		                        type:"POST",  //请求方式
		                        url: getServer()+"/sword/sys/dict/validateDictItem", //请求的服务
		                        data:{  //要传递的参数
		                        	id:function(){return $("#id").val();},
		                            dictCode:function(){return $("#code").val();},
		                            parentId:function(){return $("#parentId").val();}
		                        }
		                    }
		            	},
		            	shortName:{
		            		maxlength:40,
		            		PD_regex: "^\\w*$"
		            	},
		            	description:{
		            		maxlength:256
		            	},
		            	codeSequence:{
		            		maxlength:9,
		            		PD_regex:"^[0-9]*$"
		            	},
		            	remarks:{
		            		maxlength:200
		            	}
		            },
		            messages: {
		            	dictClassification:{
		            		PD_regex: "请填写数字、字母或下划线",
		            		remote:"该分类已存在，请修改！"
		            	},
		            	name:{
		                    remote:"同一级下不允许相同名称，请修改！"
		                },
		            	code:{
		            		PD_regex: "请填写数字、字母或下划线",
		                    remote:"同一级下不允许相同代码，请修改！"
		                }
		            }
		        });
		    }
	}
    
	function checkDictClassificationStatus(){
	//  设置分类的状态
		if($("#parentId").val()!=DefaultRoot){
			$("#dictClassification").attr("readonly",true);
		}else{
			$("#dictClassification").attr("readonly",false);
		}
	}
    
    
	var slideconfig = {
		url : window.getServer()+"/static/core/system/dict/views/saveOrUpdate.html",
		width : "600px",
		cache : false,
		close : true
	};
	
	
	
    /*正则表达式 替换括号,尖括号等*/
    function toTxt(str) {
    	var RexStr = /\<|\>|\"|\'|\&/g;
    	str = str.replace(RexStr, function(MatchStr) {
    		switch (MatchStr) {
    		case "<":
    			return "&lt;";
    			break;
    		case ">":
    			return "&gt;";
    			break;
    		case "\"":
    			return "&quot;";
    			break;
    		case "'":
    			return "&#39;";
    			break;
    		case "&":
    			return "&amp;";
    			break;
    		default:
    			break;
    		}
    	});
    	return str;
    }
    
    
    /**
     * 初始化函数
     */
    
	return initDict;
});