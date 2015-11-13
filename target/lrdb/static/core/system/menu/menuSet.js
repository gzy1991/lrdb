/**
 * 菜单管理JS
 */
define(["PDUtilDir/grid",
        "PDUtilDir/util",
        "PDUtilDir/tool",
        "PDUtilDir/org/dataSelect",
        "LocalZTree",
        "ZTree","css!ZTreeCss","JQuery.validate","JQuery.validate.extra","JQuery.validate.message"], 
    function(Grid, Util, Tool, PsnSelect, LocalZTree){
	
    //初始化入口
    function initMenuSet() {
    	//初始化菜单选择树
    	createMenuCheckTree();
    	//初始化人员信息列表
    	createUserGrid();
    }
    /**************************************全局变量***********************************/
    //路径变量
    var sysPath = "core/system";
    //菜单选择树Id
    var treeCheckMenu = "treeCheck_menu";
    //人员表格Id
    var userGridId = "grid_userSet";
    //人员表格data
    var userGridData = [];
    
    //初始化用户信息列表
    function createUserGrid() {
    	Grid($.extend(gridUserConfig, {data:[]}));
    } 
    
    //初始化菜单选择树
    function createMenuCheckTree() {
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
                    	enable : true/*,
                    	chkStyle : "radio"
                    	*/
                    },
                    callback : {
                        onClick : function(event, treeId, treeNode, clickFlag) {
                        },
                        onCheck : function() {
                        }
                    },
                    extraSets : {
                    	scroll : true,
                    	toolbar : {
                    		custom : [ {
                    			name : "保存",
                    			icon : "fa fa-save",
                    			callback : function() {
                    				on_BtnSave_click();
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
            	LocalZTree.destroy(treeCheckMenu);
                //初始化
                LocalZTree.init($("#" + treeCheckMenu), setting, data);
            }
        });
    }
    
    //用户表格配置
    var gridUserConfig = {
		id : "gridUser",
        placeAt : userGridId,
        index : true,
//        multi:true,
        hidden:false,
        pagination:true,
        layout : [{
            name:"编号",field:"code"
        },{
            name:"名称",field:"name"
        },{
        	name:"类型",field:"type", format:function(data) {
        		var type = data.row.type;
        		if ("user" == type) {
        			return "人员";
        		} else if ("dept" == type) {
        			return "部门";
        		} else if ("role" == type) {
        			return "角色";
        		}
        	}
        },{
        	name:"删除",field:"oper", format:function(){return '<i class="fa fa-trash-o" title="删除"></i>';}, click:function(e){
        		on_BtnUserDelete_click(e.data.row);
        	}
        }],
        toolbar:[{
        	name:"授权对象",icon:"fa fa-plus-circle",callback:on_BtnUserAdd_click
    	}/*,{
    		name:"删除",class:"fa fa-trash-o",callback:on_BtnUserDelete_click
		}*/],
        data:[]	
    }

    //监听【刷新】点击事件
    function on_BtnRefresh_click() {
    	createMenuCheckTree();
    }
    
    //监听【保存】点击事件
    function on_BtnSave_click() {
		if (userGridData && userGridData.length > 0) {
			var nodes = LocalZTree.getZTreeObj(treeCheckMenu).getCheckedNodes(true);
			var menuId = [];
			var confirm = "确定要保存授权吗？";
			if (!nodes || nodes.length == 0) {
				confirm = "您未勾选任何菜单，继续操作将取消授权对象的所有菜单，确定继续吗？"
			} else {
				var flag = false;
				$.each(nodes, function(i, n) {
					menuId.push(n.menuId);
				})
			}
			Util.confirm(confirm, function() {
				var	user = [];
				for (var i=0; i<userGridData.length; i++) {
					user.push({
						userId:userGridData[i].id,
						userType:userGridData[i].type
					})
				}
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
		} else {
			Util.alert("请添加授权对象");
		}
    }
    
    //监听【添加】点击事件
    function on_BtnUserAdd_click() {
    	PsnSelect({
    		id : "userSelect",
    		multi : true,
    		tagData:["user","role","dept"],
    		dataRefill:false,
    		callback : function(data) {
    			for (var type in data) {
    				if (data[type] && data[type].length > 0) {
    					for (var i=0; i<data[type].length; i++) {
    						var user = data[type][i];
    						var json = {
								id : user["userUuid"] || user["deptUuid"] || user["roleUuid"],
    							code : user["userCode"] || user["deptCode"] || user["roleCode"],
    							name : user["userName"] || user["deptName"] || user["roleName"],
    							type : type
    						}
    						if (-1 == Tool.indexOfJsonArray(json, userGridData, function(json1, json2){
    							return (json1.id == json2.id && json1.type == json2.type);
    						})) {
    							userGridData.push(json);
    						}
    					}
    				}
    			}
    			Grid($.extend(gridUserConfig, {
					data:userGridData
				}));
    		}
    	});
    }
    
    //监听【删除】点击事件
    function on_BtnUserDelete_click(row) {
    	//删除行
		for (var j=0; j<userGridData.length; j++) {
			if (row.id == userGridData[j].id) {
				userGridData.splice(j, 1);
				break;
			}
		}
		//重新渲染表格
		Grid($.extend(gridUserConfig, {
			data:userGridData
		}));
    } 
    
    //监听【删除】点击事件
    /*
    function on_BtnUserDelete_click() {
    	var rows = Grid.getGrid("gridUser") && Grid.getGrid("gridUser").getSelectedRow();
		if (rows && rows.length > 0) {
			for (var i=0; i<rows.length; i++) {
				for (var j=0; j<userGridData.length; j++) {
					if (rows[i].id == userGridData[j].id) {
						userGridData.splice(j, 1);
					}
				}
			}
			Grid($.extend(gridUserConfig, {
				data:userGridData
			}));
		} else {
			Util.alert("请选择行");
		}
    }
	*/
    
	return {
		init : initMenuSet
	}
});