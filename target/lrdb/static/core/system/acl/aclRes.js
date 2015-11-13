/**
 * 资源管理JS
 */
define(["PDUtilDir/grid",
        "PDUtilDir/util",
        "PDUtilDir/tool",
        "PDUtilDir/dialog",
        "LocalZTree",
        "PDUtilDir/menu",
        "ZTree","css!ZTreeCss","JQuery.validate","JQuery.validate.extra","JQuery.validate.message"], 
    function(Grid, Util, Tool, Dialog, LocalZTree, Menu){
	
    //初始化入口
    function initAuthRes() {
    	//初始化资源目录树
    	createResTree();
    	//初始右键菜单
    	createContextMenu();
    	//初始化资源实体表格
    	createResGrid();
    }
    
    //定义一个路径变量
    var path = getStaticPath() + "/core/system/acl";
    //资源目录树id
    var treeResDirId = "tree_resDir";
    //当前选中节点
    var currentNode = null;
    //资源表格Id
    var gridResId = "grid_res";
    
    //创建资源目录树
    var createResTree = function() {
    	currentNode = null;
        $.ajax({
            url : getServer() + "/sword/auth/res/getSort",
            success : function(data) {
            	//展开根目录
            	if (data && data.length) {
            		$.each(data, function(i, n){
            			if (!n.resPid) {
            				n.open = true;
            			}
            		})
            	}
        		//配置ztree的属性
                var setting = {
                    data: {
                    	key : {
                    		name:"resName"
                    	},
                        simpleData: {
                            enable: true,
                            idKey:"resId",
                            pIdKey:"resPid",
                            rootPId:null
                        }
                    },
                    view : {
                    	selectedMulti : false //单选
                    },
                    callback : {
                        onClick : function(event, treeId, treeNode, clickFlag) {
                        	currentNode = treeNode;
                        	loadResGrid();
                        },
                        onRightClick : function(event, treeId, treeNode) {
                        	if (treeNode) {
                        		var treeObj = $.fn.zTree.getZTreeObj(treeId);
                        		//选中该节点
                        		treeObj.selectNode(treeNode);
                        		currentNode = treeNode;
                        		//执行查询
                        		loadResGrid();
                        		contextMenu.show({
                        			top: event.clientY,
                        			left: event.clientX + 15
                        		})
                        	}
                        }
                    },
                    extraSets : {
                    	scroll : true,
                    	toolbar : {
                    		custom : [{
                    			name : "添加目录",
                    			icon : "fa fa-plus-circle",
                    			callback : function() {
                    				on_BtnAuthResAddSort_click();
                    			}
                    		}, {
                    			name : "编辑目录",
                    			icon : "fa fa-edit",
                    			callback : function(){
                    				on_BtnAuthResEditSort_click();
                    			}
                    		},{
                    			name : "删除目录",
                    			icon : "fa fa-trash-o",
                    			callback : function() {
                    				on_BtnAuthResDeleteSort_click();
                    			}
                    		}, {
                    			name : "刷新",
                    			icon : "fa fa-refresh",
                    			callback : function() {
                    				on_BtnAuthResRefreshSort_click();
                    			}
                    		}/*,{
                    			name : "排序",
                    			icon : "fa fa-list",
                    			callback : function() {
                    				on_BtnAuthResOrderSort_click();
                    			}
                    		}*/]
                    	}
                    }
                }
                LocalZTree.destroy(treeResDirId);
                //初始化
                LocalZTree.init($("#" + treeResDirId), setting, data);
                //展开所有
                //LocalZTree.getZTreeObj(treeResDirId).expandAll(true);
            }
        });
    }
    
    //右键菜单
    var contextMenu;
    var createContextMenu = function() {
    	contextMenu = Menu({
    		items : [{
    			id : "plus",
    			name: "添加",
    			icon: "fa fa-plus",
    			callback : function() {
    				on_BtnAuthResAddSort_click();
    			}
    		}, {
    			id : "edit",
    			name : "编辑",
    			icon : "fa fa-edit",
    			callback : function() {
    				on_BtnAuthResEditSort_click();
    			}
    		}, {
    			id : "minus",
    			name : "删除",
    			icon : "fa fa-minus",
    			callback : function() {
    				on_BtnAuthResDeleteSort_click();
    			}
    		}]
    	})
    }
    
    //菜单表格配置
    var gridBaseConfig = {
		id : "gridRes",
        placeAt : "grid_res",
        hidden:false,
        multi:true,
        pagination:true,
        layout : [{
            name:"资源名称",field:"resName",click:function(e){
            	on_BtnAuthResEdit_click(e.data.row);
        	}
        },{
            name:"资源地址",field:"resUrl"
        },{
            name:"是否启用",field:"isEnable",format:function(data) {
        		if ("0" == data.row.isEnable) {
        			return "未启用";
        		} else if ("1" == data.row.isEnable) {
        			return "启用";
        		}
        	}
        }],
        toolbar:[
            {name:"添加",icon:"fa fa-plus-circle",callback:function(){ on_BtnAuthResAdd_click(); }},
            {name:"查找添加", icon:"fa fa-search",callback:function(){ on_BtnAuthResAddSearch_click(); }},
            {name:"删除",icon:"fa fa-trash-o",callback:function(event){ on_BtnAuthResDelete_click(); }},
            {name:"刷新",icon:"fa fa-refresh",callback:function(event){ on_BtnAuthResRefresh_click(); }}
        ],
        data:[]
    }
    
    //初始化资源表格
    function createResGrid() {
    	Grid($.extend(gridBaseConfig, {data:[]}));
    }
    
    //加载资源表格
    var loadResGrid = function() {
    	if (currentNode) {
    		$.ajax({
    			url : getServer() + "/sword/auth/res/getBySort",
    			data : {
    				resPid : currentNode.resId
    			},
    			success : function(data) {
    				Grid($.extend(gridBaseConfig, {
    					data:data
    				}));
    			}
    		});
    	}
    }

    /* 校验是否选择目录节点 */
    function validate_opr_resSort() {
    	//var nodes = LocalZTree.getZTreeObj("tree_resDir").getSelectedNodes();
    	if (!currentNode) {
    		Util.alert("请选择资源目录");
    		return false;
    	} else {
    		return currentNode;
    	}
    }

    //刷新资源分类按钮事件
    function on_BtnAuthResRefreshSort_click() {
    	createResTree();
    }
    
    //添加资源分类按钮事件
    function on_BtnAuthResAddSort_click() {
    	var treeObj = LocalZTree.getZTreeObj("tree_resDir");
    	if (treeObj) {
    		var editParam = {};
    		var nodes = LocalZTree.getZTreeObj("tree_resDir").getSelectedNodes();
    		if (nodes && nodes.length > 0) {
    			editParam.resPid = nodes[0].resId;
    			editParam.resParent = nodes[0].resName;
    		}
    		editResSort(false, editParam);
    	}
    }
    
    //编辑资源分类按钮事件
    function on_BtnAuthResEditSort_click() {
    	var node = validate_opr_resSort();
    	if (node) {
    		editResSort(true, node);
    	}
    }
    
    //删除资源分类按钮事件
    function on_BtnAuthResDeleteSort_click() {
		deleteResSort();
    }
    
    //排序资源分类按钮事件
	function on_BtnAuthResOrderSort_click() {
		require(["text!PDAclDir/views/res_tree_order.html"], function(html) {
			var dialog = Dialog({
				id:"DialogAclResTreeOrder",
				cache:false,                 //是否缓存，默认为true
				title:"资源目录树排序",
				width:"700px",
				height:"500px",
				buttons:[{
					name : "确定",
					callback : function() {
					}
				}]
			});
			//设置html
			dialog.setBody(html);
			dialog.show();
			
			//初始化树节点
			var treeObj = LocalZTree.getZTreeObj(treeResDirId); 
			var nodes = treeObj.transformToArray(treeObj.getNodes());
			var set = {
				data: {
                	key : {
                		name:"resName"
                	},
                    simpleData: {
                        enable: true,
                        idKey:"resId",
                        pIdKey:"resPid",
                        rootPId:null
                    }
                },
                edit : {
                	drag: {
    					autoExpandTrigger: true/*,
    					prev: dropPrev,
    					inner: dropInner,
    					next: dropNext
    					*/
    				},
    				enable: true,
    				showRemoveBtn: false,
    				showRenameBtn: false
                }
			}
			//手动将node的children属性置空，否则会出现多个相同节点
			$.each(nodes, function(i, n){
				n.children = null;
			})
			$.fn.zTree.init($("#tree_resDir_order"), set, nodes);
		})
	}
    
    /** 添加/编辑 资源分类 */
    function editResSort(edit, row) {
    	 var slidebar = Util.slidebar({
	         url:path + "/views/res_sort.html",
	         width:"500px",
	         cache:false,
	         close:true,
	         afterLoad : function() {
	        	//如果是编辑，需要重新从后台获取最新的数据
	        	if (edit) {
	        		$.ajax({
	        			url : getServer() + "/sword/auth/res/getById",
	        			data : {
	        				resId : row.resId
	        			},
	        			success : function(data) {
	        				Tool.deserialize("form_resSort", data);
	        			}
	        		});
	        	} else {
	        		//添加时初始化表单
	        		Tool.deserialize("form_resSort", row);
	        	}
	        	//初始化表单校验
	    	 	$("#form_resSort").validate({
	     			rules : {
	     				resName : {
	     					required : true,
	     					maxlength: 50
	     				},
	     				resOrder : {
	     					maxlength: 5,
	     					digits:true
	     				},
	     				resDesc : {
	     					maxlength : 100
	     				}
	     			},
	     			messages : {
	     				resName : {
	     					required : "请填写目录名称",
	     					maxlength : "最多50字符"
	     				},
	     				resOrder : {
	     					maxlength:"最多5位数",
	     					digits:"请输入整数"
	     				},
	     				resDesc : {
	     					maxlength : "最多100字符"
	     				}
	     			}
	     		});
	    	 	//注册保存按钮事件
	    	 	$("#btn_resSort_save").on("click", function(){
	    	 		if ($("#form_resSort").valid()) {
	    	 			var data = Tool.serialize("form_resSort");
	    	 			$.ajax({
	    	 				url : getServer() + "/sword/auth/res/save",
	    	 				data : data,
	    	 				type : "post",
	    	 				success : function(data) {
	    	 					Util.alert(data.message);
	    	 					if (data.success) {
	    	 						slidebar.close();
	    	 						if(!edit) {
	    	 							var treeObj = LocalZTree.getZTreeObj("tree_resDir");
	    	 							if (!treeObj) {
	    	 								createResTree();
	    	 							} else {
	    	 								var nodes = LocalZTree.getZTreeObj("tree_resDir").getSelectedNodes();
	    	 								var node = nodes.length > 0 ? nodes[0] : null;
	    	 								LocalZTree.getZTreeObj("tree_resDir").addNodes(node, data.data);
	    	 							}
	    	 						} else {
	    	 							$.extend(row, data.data);
	    	 							LocalZTree.getZTreeObj("tree_resDir").updateNode(row);
	    	 						}
	    	 					}
	    	 				}
	    	 			});
	    	 		}
	    	 	})
	         }
	     });
    }
    
    //删除资源分类
	function deleteResSort() {
		var nodes = LocalZTree.getZTreeObj("tree_resDir").getSelectedNodes();
		if (nodes && nodes.length > 0) {
			Util.confirm("确定要删除选择的资源目录吗？", function() {
				var ids = "";
				$.each(nodes, function(i, node){
					ids = ids.concat(node.resId).concat(",");
				})
				$.ajax({
					url : getServer() + "/sword/auth/res/deleteSort",
					data : {
						ids : ids
					},
					success : function(data) {
						Util.alert(data.message);
						if (data.success) {
							$.each(nodes, function(i, node){
								LocalZTree.getZTreeObj("tree_resDir").removeNode(node, true);
							})
						}
					}
				})
			});
		} else {
			Util.alert("请选择要删除的行记录");
		}
	}
    
	//添加资源按钮事件
    function on_BtnAuthResAdd_click() {
    	var node = validate_opr_resSort();
    	if (node) {
    		editRes(false, {
    			resPid : node.resId,
    			resParent : node.resName
    		});
    	}
    }
    
    //编辑资源按钮事件
    function on_BtnAuthResEdit_click(row) {
		editRes(true, row);
    }
    
    //查找资源添加按钮事件
    function on_BtnAuthResAddSearch_click() {
    	var node = validate_opr_resSort();
    	if (node) {
    		require(["PDAclDir/aclResService", "text!PDAclDir/views/res_service.html"], function(Service, html) {
    			var title = node.resName;
    			var dialog = Dialog({
    				id:"DialogAclResService",
    				cache:false,                 //是否缓存，默认为true
    				title:"查找资源[所选资源目录-" + title + "]",
    				width:"700px",
    				height:"500px",
    				buttons:[{
    					name : "添加",
    					callback : function() {
    						if (!confirmFlag) {
    							confirmFlag = true;
    							//2秒之后才可以再提交
    							setTimeout(function(){confirmFlag = false;}, 2000);
    							
    							Service.confirm(function(){
    								loadResGrid();
    								dialog.hide();
    							});
    						}
    					}
    				}]
    			});
    			//设置html
    			dialog.setBody(html);
    			dialog.show();
    			
    			Service.init();
    			//短时间内提交多次标志
    			var confirmFlag = false;
    		})
    	}
    }
    
    //删除资源按钮事件
    function on_BtnAuthResDelete_click() {
    	deleteRes();
    }
    
    //刷新资源按钮事件
    function on_BtnAuthResRefresh_click() {
    	loadResGrid();
    }
    
    //编辑资源
    function editRes(edit, row) {
    	var slidebar = Util.slidebar({
            url:path + "/views/res.html",
            width:"500px",
            cache:false,
            close:true,
            afterLoad : function() {
            	//判断是编辑还是添加
            	if (edit) {//edit
            		$.ajax({
            			url:getServer() + "/sword/auth/res/getById",
						data : {
							resId : row.resId
						},
            			success:function(data) {
            				Tool.deserialize("form_res", data);
            			}
            		});
            	} else { // add
            		Tool.deserialize("form_res", row);
            	}
            	//初始化校验
            	$("#form_res").validate({
        			rules : {
	     				resName : {
	     					required : true,
	     					maxlength: 50
	     				},
	     				resUrl : {
	     					required : true,
	     					maxlength : 100,
	     					remote:{
                                type:"POST",                                        //请求方式
                                url: getServer()+"/sword/auth/res/validateExist",   //请求的服务
                                data:{                                              //要传递的参数
                                	resId : function() {return $("#resId").val(); },
                                	resUrl : function() { return $("#resUrl").val(); }
                                }
                            }
	     				},
	     				resDesc : {
	     					maxlength : 100
	     				}
	     			},
	     			messages : {
	     				resName : {
	     					required : "请填写目录名称",
	     					maxlength : "最多50字符"
	     				},
	     				resUrl : {
	     					required : "请填写资源名称",
	     					maxlength : "最多100字符",
	     					remote : "该资源地址已经存在"
	     				},
	     				resDesc : {
	     					maxlength : "最多100字符"
	     				}
	     			}
        		})
            	//监听【保存】按钮事件
            	$("#btn_res_save").on("click", function() {
            		if ($("#form_res").valid()) {
            			var data = Tool.serialize("form_res");
            			$.ajax({
            				url : getServer() + "/sword/auth/res/save",
            				data : data,
            				type : "post",
            				success : function(data) {
            					Util.alert(data.message);
            					if (data.success) {
            						slidebar.close();
            						loadResGrid();
            					}
            				}
            			});
            		}
            	})
            }
        });
    }

    //删除资源
	function deleteRes() {
		var rows = Grid.getGrid("gridRes").getSelectedRow();
		if (rows && rows.length > 0) {
			Util.confirm("确定要删除指定的记录吗？", function() {
				var ids = "";
				$.each(rows, function(i, row){
					ids = ids.concat(row.resId).concat(",");
				})
				$.ajax({
					url : getServer() + "/sword/auth/res/delete",
					data : {
						ids : ids
					},
					success : function(data) {
						Util.alert(data.message);
						if (data.success) {
							loadResGrid();
						}
					}
				})
			});
		} else {
			Util.alert("请选择要删除的行记录");
		}
	}

	return {
		init : initAuthRes
	}
});