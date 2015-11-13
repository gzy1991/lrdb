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
    function initAclUpdate() {
    	//初始化监听用户搜索
    	initSearchUser();
    	//初始化用户表格
    	initUserGrid();
    	//初始化菜单树
    	initAclTreeCheck();
    	//监听查询按钮事件
    	$("#" + btn_aclUpdateSearch_id).on("click", function() {
    		search();
    	})
    	
    }
    
    /**************************************全局变量***********************************/
    //菜单选择树Id
    var treeCheckAcl = "treeCheck_aclUpdate";
    //人员表格Id
    var userGridId = "grid_userUpdate";
    //用戶权限加载按鈕
    var btn_aclUpdateSearch_id = "btn_aclUpdateSearch";
    //当前用户
    var cUser;
    //当前用户关系
    var cUserRelation;
    //当前用户关系名称Id
    var text_aclUpdateUser_id = "text_aclUpdateUser";
    
    /**
     * 初始化监听搜索用户
     */
    function initSearchUser() {
    	cUser = null;
    	cUserRelation = null;
    	PsnSelect.CS_OrgSelect({
            id : "input_acl_userSelect",
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
            		$("#input_acl_userSelect").val(user.name);
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
    		$("#" + text_aclUpdateUser_id).html("");
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
									//记录当前用户关系
									cUserRelation = e.data.row;
									//显示当前用户关系名称
									$("#" + text_aclUpdateUser_id).html("当前选择：" + cUserRelation.userName);
									//勾选当前用户关系权限
									setAclTreeCheck();
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
        index : true,
        hidden : false,
        multi : false,
        pagination : true,
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
        		return userType;
        	}
        }],
        data:[]
    }
    
    function initAclTreeCheck() {
    	$.ajax({
   		 url : getServer() + "/sword/auth/res/getAll",
   		 	success : function(data) {
				//调整ztree树节点状态
				(function(treeData){
					if (treeData) {
						$.each(treeData, function(i, n){
							//默认展开根
							if (!n.resPid) {
				   				n.open = true;
				   			}
							//
							if (n.resType == "1") {
								n.isParent = true;
							}
						});
					}
				})(data);
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
	                   				initAclTreeCheck();
	                   			}
	                   		}]
	                   	}
					}
				}
				LocalZTree.destroy(treeCheckAcl);
				//初始化菜单树
				LocalZTree.init($("#" + treeCheckAcl), setting, data);
				//刷新的同时设置选择项
				setAclTreeCheck();
   		 	}
  	 	});
    }
    
    /**
     * 根据某一个用户关系id初始化菜单选择树
     */
    function setAclTreeCheck() {
    	if (cUserRelation) {
    		if (cUserRelation.userType == "-") {
    			setAclTreeAllCheck();
    		} else {
    			$.ajax({
    				url : getServer() + "/sword/auth/set/getResIdByUserIds",
    				data : {
    					userUuids : cUserRelation.userUuid 
    				},
    				success : function(data) {
    					var treeObj = LocalZTree.getZTreeObj(treeCheckAcl);
    					treeObj.checkAllNodes(false);
    					if (data) {
    						$.each(data, function(i, n) {
    							var node = treeObj.getNodeByParam("resId", n.resId);
    							if (node) {
    								treeObj.checkNode(node, true, true);
    							}
    						})
    					}
    				}
    			});
    		}
    	}
    }
    
    /**
     * 根据用户id初始化用户所有资源权限
     */
    function setAclTreeAllCheck() {
    	if (cUser) {
    		$.ajax({
    			url : getServer() + "/sword/auth/set/getResIdByUser",
    			data : {
    				userUuid : cUser.id,
    				userType : cUser.type
    			},
    			success : function(data) {
    				var treeObj = LocalZTree.getZTreeObj(treeCheckAcl);
    				treeObj.checkAllNodes(false);
    				if (data) {
    					$.each(data, function(i, n) {
    						var node = treeObj.getNodeByParam("resId", n.resId);
    						if (node) {
    							treeObj.checkNode(node, true, true);
    						}
    					})
    				}
    			}
    		});
    	}
    }
    
    
    //刷新
    function search() {
    	if (cUser) {
    		//设置用户角色表格
    		loadUserGrid();
    		//重新加载树
    		initAclTreeCheck();
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
    	var nodes = LocalZTree.getZTreeObj(treeCheckAcl).getCheckedNodes(true);
		var resId = [];
		var confirm = "确定要保存授权吗？";
		if (!nodes || nodes.length == 0) {
			confirm = "您未勾选任何资源，继续操作将取消该行记录的所有资源，确定继续吗？"
		} else {
			var flag = false;
			$.each(nodes, function(i, n) {
				if (n.resType == "2") {
					resId.push(n.resId);
				}
			})
			if (resId.length == 0) {
				Util.alert("您所勾选的节点中没有资源实体，保存无效！");
				return ;
			}
		}
		Util.confirm(confirm, function() {
			var	user = [];
			user.push({
				userId:cUserRelation.userUuid,
				userType:cUserRelation.userType
			})
			$.ajax({
				url : getServer() + "/sword/auth/set/saveUserRes",
				data : { 
					resId : resId.join(","),
					user : JSON.stringify(user) 
				},
				success : function(data) {
					Util.alert(data.message);
				}
			})
		});
    }
    
    return {
		init : initAclUpdate
	}
})
