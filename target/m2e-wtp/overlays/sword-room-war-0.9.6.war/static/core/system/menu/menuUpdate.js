/**
 * 菜单查询变更
 */
define(["PDUtilDir/grid",
        "PDUtilDir/util",
        "PDUtilDir/tool",
        //"PDUtilDir/org/dataSelect",
        "PDUtilDir/org/orgSelect",
        "LocalZTree",
        "ZTree","css!ZTreeCss"],
    function(Grid, Util, Tool, PsnSelect, LocalZTree){
	
	//初始化入口
    function initMenuUpdate() {
    	//初始化监听用户搜索
    	initSearchUser();
    	//初始化用户表格
    	initUserGrid();
    	//初始化菜单树
    	initMenuTreeCheck();
    	//监听查询按钮事件
    	$("#" + btn_menuUpdateSearch_id).on("click", function() {
    		search();
    	})
    }
    
    /**************************************全局变量***********************************/
    //菜单选择树Id-all
    var treeCheckMenuAll = "treeCheck_menuUpdate_all";
    //菜单选择树Id
    var treeCheckMenu = "treeCheck_menuUpdate";
    //人员表格Id
    var userGridId = "grid_userUpdate";
    //用戶权限加载按鈕
    var btn_menuUpdateSearch_id = "btn_menuUpdateSearch";
    //当前用户
    var cUser;
    //当前用户关系
    var cUserRelation;
    //当前用户关系名称Id
    var text_menuUpdateUser_id = "text_menuUpdateUser";
    
    /**
     * 初始化监听搜索用户
     */
    function initSearchUser() {
    	cUser = null;
    	cUserRelation = null;
    	PsnSelect.CS_OrgSelect({
            id : "input_menu_userSelect",
            multi : false,
            tagData:["user","role","dept"],
            dataRefill:false,
            simpleReturnData : true,
            callback : function(simpleData, data){
            	var user = simpleData && simpleData[0];
            	if (user) {
            		//设置当前授权对象
            		cUser = user;
            		//设置授权对象名称
            		$("#input_menu_userSelect").val(user.name);
            		//开始查询
            		search();
            	}
            }
        });
	}
    
    /**
     * 创建用户关系表格
     */
    function initUserGrid() {
    	Grid($.extend(gridUserConfig, {data:[]}));
    } 
    
    /**
     * 加载用户关系表格
     */
    function loadUserGrid() {
    	if (cUser) {
    		//清空所选用户关系
    		cUserRelation = null;
    		$("#" + text_menuUpdateUser_id).html("");
			$.ajax({
				url : getServer() + "/sword/org/user/getUserRelation",
				data : {
					userUuid : cUser.id,
					userType : cUser.type
				},
				success : function(data) {
					if (data && data.length > 0) {
						data.splice(0, 0, {
							userCode : "-",
							userName : "所有权限",
							userType : "-"
						});
						Grid($.extend(gridUserConfig, {
							data : data,
							trEvent : [{
								type : "click",
								callback : function(e) {
									//设置这个用户关系的菜单
									cUserRelation = e.data.row;
									//显示当前用户关系名称
									$("#" + text_menuUpdateUser_id).html("当前选择：" + cUserRelation.userName);
									//勾选当前用户关系权限
									setMenuTreeCheck();
								}
							}]
						}));
					}
				}
			});
    	}
    }
    
    /**
     * 表格配置
     */
    var gridUserConfig = {
		id : "gridUser",
        placeAt : userGridId,
        hidden:false,
        multi:false,
        pagination:true,
        layout : [{
            name:"编号",field:"userCode"
        },{
            name:"名称",field:"userName"
        },{
        	name:"类型",field:"userType",format:function(data){
        		var userType = data.row.userType;
        		if ("user" == userType) {
        			return "人员";
        		} else if ("dept" == userType) {
        			return "部门";
        		} else if ("role" == userType) {
        			return "角色";
        		}
        		return userType
        	}
        }],
        data:[]
    }
    
    /**
     * 初始化菜单树
     */
    function initMenuTreeCheck() {
    	$.ajax({
    		 url : getServer() + "/sword/menu/getMenuAll",
			 success : function(data) {
				//适配数据
            	(function(treeData){
            		for (var i=0; i<treeData.length; i++) {
            			//默认展开根
            			if (treeData[i].menuId == "root") {
            				treeData[i].open = true;
            			}
            			//配置菜单分类图标
            			if (treeData[i].menuType == "1") {
            				treeData[i].isParent = true;
            			}
            		}
            	})(data)
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
                    check : {
                    	enable : true
                    },
                    extraSets : {
	                   	scroll : true,
	                   	toolbar : {
	                   		custom : [{
	                   			name : "保存",
	                   			icon : "fa fa-save",
	                   			callback : function() {
	                   				save();
	                   			}
	                   		}, {
	                   			name : "刷新",
	                   			icon : "fa fa-refresh",
	                   			callback : function() {
	                   				initMenuTreeCheck();
	                   			}
	                   		}]
	                   	}
                   }
                }
            	LocalZTree.destroy(treeCheckMenu);
            	//初始化菜单树
                LocalZTree.init($("#" + treeCheckMenu), setting, data);
            	//初始化选择项
            	setMenuTreeCheck();
			 }
   	 	});
    }
    
    /**
     * 根据某一个用户关系id初始化菜单选择树
     */
    function setMenuTreeCheck() {
    	if (cUserRelation) {
    		if (cUserRelation.userType == "-") {
    			setMenuTreeAllCheck();
    		} else {
	    		$.ajax({
	    			url : getServer() + "/sword/menu/auth/getMenuIdByUserIds",
	    			data : {
	    				userUuids : cUserRelation.userUuid 
	    			},
	    			success : function(data) {
	    				var treeObj = LocalZTree.getZTreeObj(treeCheckMenu);
	    				treeObj.checkAllNodes(false);
	    				if (data) {
	    					$.each(data, function(i, n) {
	    						var node = treeObj.getNodeByParam("menuId", n.menuId);
	    						if (node) {
	    							treeObj.checkNode(node, true);
	    						}
	    					})
	    				}
	    			}
	    		});
    		}
    	}
    }
    
    /**
     * 根据用户id初始化用户菜单选择树
     */
    function setMenuTreeAllCheck() {
    	if (cUser) {
    		$.ajax({
    			url : getServer() + "/sword/menu/auth/getMenuIdByUser",
    			data : {
    				userUuid : cUser.id,
    				userType : cUser.type
    			},
    			success : function(data) {
    				var treeObj = LocalZTree.getZTreeObj(treeCheckMenu);
    				treeObj.checkAllNodes(false);
    				if (data) {
    					$.each(data, function(i, n) {
    						var node = treeObj.getNodeByParam("menuId", n.menuId);
    						if (node) {
    							treeObj.checkNode(node, true);
    						}
    					})
    				}
    			}
    		});
    	}
    }
    
    //查询
    function search() {
    	if (cUser) {
    		//设置用户角色表格
    		loadUserGrid();
    		//重新加载树
    		initMenuTreeCheck();
    	}
    }
    
    //保存变更
    function save() {
    	if (!cUser) {
    		Util.alert("请选择授权对象！");
    		return ;
    	}
    	if (!cUserRelation) {
    		Util.alert("请选择授权对象表格里的某一行记录！");
    		return ;
    	}
    	if (cUserRelation.userCode == "-" && cUserRelation.userType == "-") {
    		Util.alert("请选择除【所有权限】以外的行记录！");
    		return ;
    	}
    	var nodes = LocalZTree.getZTreeObj(treeCheckMenu).getCheckedNodes(true);
		var menuId = [];
		var confirm = "确定要保存授权吗？";
		if (!nodes || nodes.length == 0) {
			confirm = "您未勾选任何资源，继续操作将取消该行记录的所有资源，确定继续吗？"
		} else {
			var flag = false;
			$.each(nodes, function(i, n) {
				menuId.push(n.menuId);
			})
		}
		Util.confirm("确定要保存变更授权吗？", function() {
			var	user = [];
			user.push({
				userId:cUserRelation.userUuid,
				userType:cUserRelation.userType
			})
			$.ajax({
				url : getServer() + "/sword/menu/auth/saveUserMenu",
				data : { 
					menuId : menuId.join(","),
					user : JSON.stringify(user) 
				},
				success : function(data) {
					Util.alert(data.message);
				}
			})
		});
    }
    
    return {
		init : initMenuUpdate
	}
})
