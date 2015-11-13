/**
 * 菜单管理JS
 */
define(["PDUtilDir/grid",
        "PDUtilDir/util",
        "PDUtilDir/tool",
        "LocalZTree",
        "PDUtilDir/menu",
        "PDUtilDir/inputSelect",
         /*"ZTree","css!ZTreeCss",*/"JQuery.validate","JQuery.validate.extra","JQuery.validate.message"], 
    function(Grid, Util, Tool, LocalZTree, Menu, InputSelect){
	
    //初始化入口
    function initMenu() {
    	//创建右键菜单
    	//createContextMenu();
    	//初始树
    	createMenuTree();
    	//初始化表格
    	createMenuGrid();
    }
    /**************************************全局变量***********************************/
    //路径变量
    var path = getStaticPath() + "/core/system/menu";
    //当前选中节点
    var currentNode = null;
    //菜单目录树Id
    var menuDirTreeId = "tree_menuDir";
    //菜单表格Id
    var menuGridId = "grid_menu";
    
    var contextMenu;
    var createContextMenu = function() {
    	contextMenu = Menu({
    		items : [{
    			id : "plus",
    			name: "添加",
    			icon: "fa fa-plus",
    			callback : function() {
    				alert("添加");
    			}
    		}, {
    			id : "minus",
    			name : "删除",
    			icon : "fa fa-minus",
    			callback : function() {}
    		}, {
    			id : "edit",
    			name : "编辑",
    			icon : "fa fa-pencil",
    			callback : function() {}
    		}]
    	})
    }
    //初始化菜单目录树
    var createMenuTree = function() {
    	currentNode = null;
        $.ajax({
            url : getServer() + "/sword/menu/getSort",
            success : function(data) {
            	//展开根目录
            	if (data && data.length) {
            		$.each(data, function(i, n){
            			if (n.menuId == "root") {
            				n.open = true;
            			}
            		})
            	}
        		//配置ztree的属性
                var setting = {
                    data: {
                    	key : {
                    		name:"menuName"
                    	},
                        simpleData: {
                            enable: true,
                            idKey:"menuId",
                            pIdKey:"menuPid",
                            rootPId:null
                        }
                    },
                    callback : {
                        onClick : function(event, treeId, treeNode, clickFlag) {
                        	currentNode = treeNode;
                        	loadMenuGrid();
                        }/*,
                        onRightClick : function(event, treeId, treeNode) {
                        	if (treeNode) {
                        		var treeObj = $.fn.zTree.getZTreeObj(treeId);
                        		treeObj.selectNode(treeNode);
                        		currentNode = treeNode;
                        		contextMenu.show({
                        			top: event.clientY,
                        			left: event.clientX + 15
                        		})
                        	}
                        }*/
                    },
                    extraSets : {
                    	scroll : true,
                    	toolbar : {
                    		custom : [{
                    			name : "添加分类",
                    			icon : "fa fa-plus-circle",
                    			callback : function() {
                    				on_BtnMenuAddSort_click();
                    			}
                    		}, {
                    			name : "编辑分类",
                    			icon : "fa fa-edit",
                    			callback : function(){
                    				on_BtnMenuEditSort_click();
                    			}
                    		}, {
                    			name : "删除分类",
                    			icon : "fa fa-trash-o",
                    			callback : function() {
                    				on_BtnMenuDeleteSort_click();
                    			}
                    		}, {
                    			name : "刷新",
                    			icon : "fa fa-refresh",
                    			callback : function() {
                    				on_BtnRefresh_click();
                    			}
                    		}]
                    	}
                    }
                }
                LocalZTree.destroy(menuDirTreeId);
                //初始化
                LocalZTree.init($("#" + menuDirTreeId), setting, data);
                //展开所有
                //LocalZTree.getZTreeObj(menuDirTreeId).expandAll(true);
            }
        });
    }
    
    //初始化表格
    function createMenuGrid() {
    	Grid($.extend(gridBaseConfig, {data:[]}));
    }
    
    //菜单表格配置
    var gridBaseConfig = {
		id : "gridMenu",
        placeAt : menuGridId,
        multi:true,
        hidden:false,
        pagination:true,
        layout : [{
            name:"菜单名称",field:"menuName",click:function(e){
            	on_BtnMenuEdit_click(e.data.row);
        	}
        },{
            name:"路由地址",field:"menuRouter"
        },{
            name:"排序索引",field:"menuOrder"
        },{
            name:"菜单描述",field:"menuDesc"
        }],
        toolbar:[
            {name:"添加",icon:"fa fa-plus-circle",callback:on_BtnMenuAdd_click},
            {name:"删除",icon:"fa fa-trash-o",callback:on_BtnMenuDelete_click}/*,
            {name:"刷新",icon:"fa fa-refresh",callback:on_BtnMenuRefresh_click }*/
        ],
        data:[]
    }
    
    //加载菜单表格数据
    function loadMenuGrid() {
    	if (currentNode) {
    		$.ajax({
    			url : getServer() + "/sword/menu/getBySort",
    			data : {
    				menuPid : currentNode.menuId
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
    function validate_opr_menuSort() {
    	if (!currentNode) {
    		showMenuTreeOprTip();
    		return false;
    	} else {
    		hideMenuTreeOprTip();
    		return currentNode;
    	}
    }
    
    //显示提示信息
    function showMenuTreeOprTip() {
    	//$("#menu_tree_opr_tip").fadeIn();
    	Util.alert("请选择菜单分类");
    }
    
    //隐藏提示信息
    function hideMenuTreeOprTip() {
    	//$("#menu_tree_opr_tip").fadeOut();
    }
    
    //监听【刷新】点击事件
    function on_BtnRefresh_click() {
    	refresh();
    }
    
    function refresh() {
    	//初始树
    	createMenuTree();
    	//初始化表格
    	createMenuGrid();
    }
    
    //监听【添加分类】点击事件
    function on_BtnMenuAddSort_click() {
    	var node = validate_opr_menuSort();
    	if (node) {
    		editMenuSort(false, {
    			menuPid : node.menuId,
    			menuParent : node.menuName
    		});
    	}
    }
    
    //监听【修改分类】点击事件
    function on_BtnMenuEditSort_click() {
    	var node = validate_opr_menuSort();
    	if (node) {
    		editMenuSort(true, node);
    	}
    }
    
    //监听【删除分类】点击事件
    function on_BtnMenuDeleteSort_click() {
		deleteMenuSort();
    }
    
    /** 添加/编辑 菜单分类 */
    function editMenuSort(edit, row) {
    	var tempUrl = path + "/views/menu_sort.html";
    	if (row.menuPid == "root") {
    		tempUrl = path + "/views/menu_sort_icon.html";
    	}
    	var slidebar = Util.slidebar({
    		 url:tempUrl,
	         width:"500px",
	         close : true,
	         cache:false,
	         afterLoad : function() {
	        	//是否需要移动节点
	        	var move = false;
	        	//如果是编辑，需要重新从后台获取最新的数据
	        	if (edit) {
	        		//查询该菜单
            		var deferred = $.ajax({
	        			url : getServer() + "/sword/menu/getById",
	        			data : {
	        				menuId : row.menuId
	        			},
	        			success : function(data) {
	        				Tool.deserialize("form_menuSort", data);
	        			}
	        		});
            		//查询所有菜单分类
            		var deferred_sort = $.ajax({
            			url : getServer() + "/sword/menu/getSort",
                		success : function(data) {
                		}
            		})
            		$.when(deferred, deferred_sort).done(function(d1, d2){
            			var menuPid = d1[0].model.menuPid;
            			initSortSelect(d2[0].model, [menuPid], function(idArr, objArr){
            				move = true;
            				if (row.menuId != "root") {
            					$("#menuPid").val(idArr[0]);
            				} else {
            					Util.alert("根目录不能移动！");
            				} 
            			});
            		});
	        	} else {
	        		//添加时初始化表单
	        		Tool.deserialize("form_menuSort", row);
	        		//查询菜单分类
            		var deferred_sort = $.ajax({
                		url : getServer() + "/sword/menu/getSort"
                	})
            		$.when(deferred_sort).done(function(d){
            			initSortSelect(d.model, [row.menuPid], function(idArr, objArr){
            				$("#menuPid").val(idArr[0]);
            			});
            		})
	        	}
	        	//初始化表单校验
	    	 	$("#form_menuSort").validate({
	    	 		rules : {
	    	 			menuName : {
	     					required : true,
	     					maxlength: 10
	     				},
	     				menuOrder : {
	     					maxlength: 5,
	     					digits:true
	     				},
	     				menuDesc : {
	     					maxlength : 100
	     				}
	     			},
	     			messages : {
	     				menuName : {
	     					required : "请填写分类名称",
	     					maxlength : "最多10字符"
	     				},
	     				menuOrder : {
	     					maxlength: "最多5位数",
	     					digits:"请输入整数"
	     				},
	     				menuDesc : {
	     					maxlength : "最多100字符"
	     				}
	     			}
	     		});
	    	 	//注册保存按钮事件
	    	 	$("#btn_menuSort_save").on("click", function(){
	    	 		if ($("#form_menuSort").valid()) {
	    	 			var data = Tool.serialize("form_menuSort");
	    	 			$.ajax({
	    	 				url : getServer() + "/sword/menu/save",
	    	 				data : data,
	    	 				type : "post",
	    	 				success : function(data) {
	    	 					Util.alert(data.message);
	    	 					if (data.success) {
	    	 						slidebar.close();
	    	 						if(edit) {
	    	 							$.extend(row, data.data);
	    	 							editTreeNode(row);
	    	 							move && moveTreeNode(row)
	    	 						} else {
	    	 							addTreeNode(data.data);
	    	 						}
	    	 					}
	    	 				}
	    	 			});
	    	 		}
	    	 	})
	         }
	     });
    }
    
    //初始化分类下拉框
	function initSortSelect(data, initData, callback) {
		InputSelect({
			id : "menuParent",
			simpleData : true,
			key : {
				id : "menuId",
				name : "menuName",
				pid : "menuPid"
			},
			data : data,
			initData : initData,
			callback : function(idArr, objArr) {
				callback && callback(idArr, objArr);
			}
		})
	};
    
    //添加树节点
    function addTreeNode(node) {
    	var menuPid = node.menuPid;
    	var parentNode = LocalZTree.getZTreeObj(menuDirTreeId).getNodeByParam("menuId", menuPid);
		if (parentNode) {
			LocalZTree.getZTreeObj(menuDirTreeId).addNodes(parentNode, node);
		}
    }
    
    //修改树节点
    function editTreeNode(node) {
    	LocalZTree.getZTreeObj(menuDirTreeId).updateNode(node);
    }
    
    //移动树节点
    function moveTreeNode(node) {
    	var menuPid = node.menuPid;
    	var parentNode = LocalZTree.getZTreeObj(menuDirTreeId).getNodeByParam("menuId", menuPid);
    	if (parentNode)
    		LocalZTree.getZTreeObj(menuDirTreeId).moveNode(parentNode, node, "inner");	
    }
    
    //删除树节点
    function removeTreeNode(node) {
    	LocalZTree.getZTreeObj(menuDirTreeId).removeNode(node, true);
    }
    
    //删除菜单分类
	function deleteMenuSort() {
		if (validate_opr_menuSort()) {
			Util.confirm("确定要删除菜单分类吗？", function() {
				var ids = currentNode.menuId;
				$.ajax({
					url : getServer() + "/sword/menu/deleteSort",
					data : {
						ids : ids
					},
					success : function(data) {
						Util.alert(data.message);
						if (data.success) {
							removeTreeNode(currentNode);
						}
					}
				})
			});
		}
	}
    
	//监听菜单表格【添加】点击事件
    function on_BtnMenuAdd_click() {
    	var node = validate_opr_menuSort();
    	if (node) {
    		editMenu(false, {
    			menuPid : node.menuId,
    			menuParent : node.menuName
    		});
    	}
    }
    
    //监听菜单表格【修改】点击事件
    function on_BtnMenuEdit_click(row) {
    	editMenu(true, row);
    }
    
    //监听菜单表格【删除】点击事件
    function on_BtnMenuDelete_click() {
    	deleteMenu();
    }
    
    //监听菜单表格【刷新】点击事件
    function on_BtnMenuRefresh_click() {
    	loadMenuGrid();
    }
    
    //编辑菜单
    function editMenu(edit, row) {
    	var slidebar = Util.slidebar({
            url:path + "/views/menu.html",
            width:"500px",
            cache:false,
            close:true,
            afterLoad : function() {
            	//监听打开方式切换时的页面变化
            	var menuOpenChange = (function(){
            		function menuOpenChange() {
            			var value = $("#menuOpen").val();
            			if (value == "1" || value == "3") {
            				$("#fs_menu_router .group-url").hide();
            				$("#fs_menu_router .group-router").show();
            				$("#fs_menu_router legend").html("路由信息");
            				$("#menuUrl").attr("placeholder", "例如:static/core/system/menu/views/index.html");
            			} else if (value == "5" || value == "7") {
            				$("#fs_menu_router .group-router").hide();
            				$("#fs_menu_router .group-url").show();
            				$("#fs_menu_router legend").html("资源信息");
            				if (value == "5") {
            					$("#menuUrl").attr("placeholder", "例如:sword/get或者a.html");
            				} else if (value == "7") {
            					$("#menuUrl").attr("placeholder", "例如:http://www.baidu.com");
            				}
            			}
            		}
            		$("#menuOpen").on("change", function() {
            			menuOpenChange();
            		});
            		menuOpenChange();
            		return menuOpenChange;
            	})();
            	if (edit) {//edit
            		//查询该菜单
            		var deferred = $.ajax({
            			url:getServer() + "/sword/menu/getById",
						data : {
							menuId : row.menuId
						},
            			success:function(data) {
            				Tool.deserialize("form_menu", data);
            				menuOpenChange();
            			}
            		});
            		//查询所有依赖服务
            		var deferred_service = $.ajax({
            			url : getServer() + "/sword/sys/dict/queryFromRootByCode",
            			data : {
            				code : "module_service"
            			}
            		});
            		//查询所有菜单分类
            		var deferred_sort = $.ajax({
            			url : getServer() + "/sword/menu/getSort"
            		})
            		//监听完成事件
            		$.when(deferred, deferred_service).done(function(d1, d2){
            			var initData = d1[0].model.menuService;
            			if (initData) {
            				var result = [];
            				var arr = initData.split(",");
            				$.each(arr, function(i, n) {
            					result.push(n.split(":")[0]);
            				})
            				initData = result;
            			}
            			var data = d2[0].model.data;
            			initServiceSelect(data, initData);
            		});
            		$.when(deferred, deferred_sort).done(function(d1, d2){
            			var menuPid = d1[0].model.menuPid;
            			initSortSelect(d2[0].model, [menuPid], function(idArr, objArr){
            				$("#menuPid").val(idArr[0]);
            			});
            		});
            	} else { // add
            		Tool.deserialize("form_menu", row);
            		menuOpenChange();
            		//查询所有依赖服务
            		var deferred_service = $.ajax({
            			url : getServer() + "/sword/sys/dict/queryFromRootByCode",
            			data : {
            				code : "module_service"
            			}
            		});
            		//查询菜单分类
            		var deferred_sort = $.ajax({
                		url : getServer() + "/sword/menu/getSort"
                	})
            		//监听完成事件
            		$.when(deferred_service).done(function(d){
            			var data = d.model.data;
            			initServiceSelect(data);
            		})
            		$.when(deferred_sort).done(function(d){
            			initSortSelect(d.model, [row.menuPid], function(idArr, objArr){
            				$("#menuPid").val(idArr[0]);
            			});
            		})
            	}
            	//初始化服务下拉框
            	var initServiceSelect = function(data, initData){
            		InputSelect({
            			id : "menuSerivceName",
            			multi : true,
            			simpleData : true,
            			key : {
            				id : "id",
            				name : "name",
            				pid : "parentId",
            				rootId : "module_service"
            			},
            			data : data,
            			initData : initData,
            			callback : function(idArr, objArr) {
            				var result = [];
            				if (objArr && objArr.length) {
            					$.each(objArr, function(i, n) {
            						result.push(n.id + ":" + n.code);
            					})
            				}
            				$("#menuService").val(result.join(","));
            			}
            		})
            	};
            	//添加validate
            	$("#form_menu").validate({
        			rules : {
	    	 			menuName : {
	     					required : true,
	     					maxlength: 10
	     				},
	     				menuOrder : {
	     					maxlength: 5,
	     					digits:true
	     				},
	     				menuDesc : {
	     					maxlength : 100
	     				},
	     				menuRouter : {
	     					required : true,
	     					remote:{
                                type:"POST",                                        //请求方式
                                url: getServer()+"/sword/menu/validateExist",   	//请求的服务
                                data:{                                              //要传递的参数
                                	menuId : function() {return $("#menuId").val(); },
                                	menuRouter : function() { return $("#menuRouter").val(); }
                                }
                            }
	     				},
	     				menuUrl : {
	     					required : true
	     				}
	     			},
	     			messages : {
	     				menuName : {
	     					required : "请填写菜单名称",
	     					maxlength : "最多10字符"
	     				},
	     				menuOrder : {
	     					maxlength: "最多5位数",
	     					digits:"请输入整数"
	     				},
	     				menuDesc : {
	     					maxlength : "最多100字符"
	     				},
	     				menuRouter : {
	     					required : "请填写菜单路由地址",
	     					remote : "该路由地址已经存在"
	     				},
	     				menuUrl : {
	     					required : "请填写菜单资源"
	     				}
	     			}
        		})
            	//监听【保存】按钮事件
            	$("#btn_menu_save").on("click", function() {
            		if ($("#form_menu").valid()) {
            			var data = Tool.serialize("form_menu");
            			$.ajax({
            				url : getServer() + "/sword/menu/save",
            				data : data,
            				type : "post",
            				success : function(data) {
            					Util.alert(data.message);
            					if (data.success) {
            						slidebar.close();
            						loadMenuGrid();
            					}
            				}
            			});
            		}
            	})
            }
        });
    }

    //删除菜单
	function deleteMenu() {
		var rows = Grid.getGrid("gridMenu").getSelectedRow();
		if (rows && rows.length > 0) {
			Util.confirm("确定要删除指定的记录吗？", function() {
				var ids = "";
				$.each(rows, function(i, row){
					ids = ids.concat(row.menuId).concat(",");
				})
				$.ajax({
					url : getServer() + "/sword/menu/delete",
					data : {
						ids : ids
					},
					success : function(data) {
						Util.alert(data.message);
						if (data.success) {
							loadMenuGrid();
						}
					}
				})
			});
		} else {
			Util.alert("请选择要删除的行记录");
		}
	}

	return {
		init : initMenu
	}
});