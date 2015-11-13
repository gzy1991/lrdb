/**
 * Created by YiYing on 2015/3/25.
 */
define([
    "PDUtilDir/util",
    "PDUtilDir/grid",
    "PDOrgDir/util",
    "PDUtilDir/tool",
    "PDUtilDir/org/orgSelect"
    ],function(Util,Grid,OrgUtil,Tool,OrgSelect){
    /*****************************角色相关********************************/
    var _Model = [];
    var _ModelNew = [];

    var Slidebar = null;

    //角色导入
    var importRole = function(){
        var mapping = {
            "ServiceName":"org/role/importRole",
            "EntityClassName":"com.css.sword.common.org.entity.OrgRole",
            "角色编号":"roleCode","角色名称":"roleName",
            "所属目录编号":"dirCode","序号":"sort"
        };
        OrgUtil.importExcel({
            "title":"角色导入",
            "templeteURL":OrgUtil.sysPath+"/org/views/importRole.html",
            "mapping":mapping,
            "importSuccess":function(){
                Grid.getGrid("OrgRoleList").refresh();
            },
            "callback":function(){
                $("#downloadRoleExcel").attr("href",getServer()+"/static/core/system/org/importTemplete/角色导入.xlsx");
            }
        });
    };
    //新增角色
    var addRole = function(){
        showRoleSidebar({
            afterLoad:function(){
                _Model = [];
                _ModelNew = [];

                var curNode = $.fn.zTree.getZTreeObj("roletree").getSelectedNodes()[0];
                $("#dirCode").val(curNode&&curNode.dirCode);
                //事件绑定
                btnBind({initData:[curNode&&curNode.dirCode]});
                //表单验证
                validateRole({
                    rules:{
                        roleCode:{
                            required:true,
                            PD_ZSDX:true,
                            maxlength:32,
                            remote:{
                                type:"POST",  //请求方式
                                url: getServer()+"/sword/org/role/validateRoleCode", //请求的服务
                                data:{  //要传递的参数
                                    roleCode:function(){return $("#roleCode").val();},
                                    roleUuid:function(){return $("#roleUuid").val();}
                                }
                            }
                        }
                    },
                    messages: {
                        roleCode:{
                            remote:"角色编号已存在,请重新输入"
                        }
                    }
                });
            }
        });
    };
    //编辑角色
    var editRole = function(roleUuid){
        $.ajax({
            //url:sysPath+"/org/data/Role.json",
            url:getServer()+"/sword/org/role/getAllRoleInfoByUuid",
            data:{"roleUuid":roleUuid},
            success:function(data){
                //数据缓存，供提交时取差集使用
                _Model    = data.users;
                _ModelNew = $.extend([],data.users);
                showRoleSidebar({
                    afterLoad:function(){
                        $("#org_RoleName").html(data.role.roleName);
                        //设置角色数据
                        Tool.deserialize("RoleForm",data.role);
                        /*//所属目录名称与目录编号
                        var roleDirTree = $.fn.zTree.getZTreeObj("roletree").getSelectedNodes()[0];
                        $("#dirName").val(roleDirTree.name);
                        $("#dirCode").val(roleDirTree.id);*/
                        //显示成员列表
                        $("#RoleUserList").empty().append(Util.template("T_RolePsns",{members:_ModelNew}));
                        //编辑时，角色编号字段不可编辑
                        $("#roleCode").attr("readonly",true);
                        //表单验证
                        validateRole();
                        //事件绑定
                        btnBind({initData:[data.role.dirCode]});
                    }
                });
            }
        });
    };

    var validateRole = function(extend){
        //数据验证
        $("#RoleForm").validate($.extend(true,{
            rules:{
                roleName:{required:true,maxlength:50},
                sort:{digits:true,maxlength:8}
            }
        },extend));
    };

    /**
     * 侧边栏上的事件初始化
     */
    var btnBind = function(param){
        //成员添加事件绑定
        addPsnBtnBind();
        //为列表的删除按钮添加事件
        delPsnBtnBind();
        //保存按钮绑定事件
        saveOrgRoleBtnBind();
        //角色分类选择初始化
        OrgUtil.selectRoleDirInit({id:"dirName",initData:param.initData,callback:function(data){
            $("#dirCode").val(data[0]);
        }});
    };

    /**
     * 角色中人员JSON对象相等的验证规则
     * @param one
     * @param two
     * @returns {boolean}
     */
    var rule = function(one,two){
        return one.userUuid==two.userUuid?true:false;
    };

    /**
     * 角色保存
     */
    var saveOrgRoleBtnBind = function(){
        $("#saveOrgRoleBtn").bind("click",function(){
            if($("#RoleForm").valid()){
                //保存按钮禁用
                $("#saveOrgRoleBtn").attr("disabled","disabled");
                var entity = Tool.serialize("RoleForm");
               /* console.log(_Model);
                console.log(_ModelNew);
                console.log(Tool.jsonArrayIntersection(_Model,_ModelNew,rule));
                console.log(Tool.jsonArrayIntersection(_ModelNew,_Model,rule));*/
                var data = {
                    "role":JSON.stringify(entity),
                    "addRolePsn":JSON.stringify(Tool.jsonArrayIntersection(_ModelNew,_Model,rule)),
                    "delRolePsn":JSON.stringify(Tool.jsonArrayIntersection(_Model,_ModelNew,rule))
                };
                $.ajax({
                    url:getServer()+"/sword/org/role/saveRole",
                    dataType:"json",
                    data:data,
                    success:function(data){
                        //缓存数据重新初始化（采用close侧边栏来解决，因为关联表还必须返回uuid）
                        //_Model = $.extend([],_ModelNew);
                        if(data.status){
                            //刷新表格
                            Grid.getGrid("OrgRoleList").refresh();
                            Slidebar.close();
                        }
                        Util.alert(data.message);
                        $("#saveOrgRoleBtn").removeAttr("disabled");
                    }
                })
            }
        })
    };

    /**
     * 添加成员事件绑定
     */
    var addPsnBtnBind = function(){
        OrgSelect.CS_OrgSelect({
            id : "role_addPsnBtn",
            multi : true,
            title : "人员选择",
            dataRefill:false,
            tagData : ["user"],
            callback : function(data){
                //console.log(data);
                data = data["user"];
                for(var i= 0,item;item=data[i++];){
                    //判断_ModelNew里是否已经存在
                    if(Tool.indexOfJsonArray(item,_ModelNew,rule)==-1){
                        _ModelNew.push(item)
                    }
                }
                $("#RoleUserList").empty().append(Util.template("T_RolePsns",{members:_ModelNew}));
            }
        });
    };

    /**
     * 删除成员事件绑定
     */
    var delPsnBtnBind = function(){
        $("#RoleUserList").bind("click",function(e){
            if(e.target.tagName.toLowerCase()=="i"){
                var $curTrTds = $(e.target.parentNode.parentNode).find("td");
                var index = Tool.indexOfJsonArray({"userUuid":$($curTrTds[3]).text()},_ModelNew,rule);
                if(index!=-1){
                    _ModelNew.splice(index,1);
                }
                //删除当前行
                $(e.target.parentNode.parentNode).remove();
            }
        });
    };


    //弹出角色侧边栏
    var showRoleSidebar = function(param){
        Slidebar = Util.slidebar($.extend({
            url:getStaticPath()+"/core/system/org/views/orgRole.html",
            cache:false,
            close:true,
            width:"500px"
        },param));
    };

    /**
     * 显示角色列表
     * @param serviceName
     * @param extendCofig   主页的查询使用到该参数
     */
    var showRoleList = function(serviceName,extendCofig){
        var config = {
            id: "OrgRoleList",
            multi:true,
            realSort:true,
            toolbar:[
                {name:"新增角色",icon:"fa fa-plus-circle",callback:addRole},
                {name:"删除角色",icon:"fa fa-trash-o",callback:delRole},
                {name:"角色导入",icon:"fa fa-upload",callback:importRole}
            ],
            layout: [
                {
                    name: "角色编号", field: "roleCode", sort:true,click: function (e) {
                    //console.log(e.data);
                    editRole(e.data.row.roleUuid);
                }
                },
                {name: "角色名称", field: "roleName",sort:true},
                //{name: "管理员", field: "managerName"},
                {name: "所属目录", field: "dirName"}/*,
                {name: "序号", field: "sort",sort:true}*/
            ],
            data: {
                "type": "URL",
                //"value": sysPath + "/org/data/Roles.json"
                "value": getServer() + "/sword/org/role/"+serviceName
            }
        };
        Grid.init($.extend(config,extendCofig||OrgUtil.gridDefaultConfig));
    };

    /**
     * 删除角色
     */
    var delRole = function(){
        var grid = Grid.getGrid("OrgRoleList");
        var data = grid.getSelectedRow();
        if(!data.length){
            Util.alert("请选择要删除的角色.");
            return false;
        }
        var okCallback = function(){
            $.ajax({
                url:getServer()+"/sword/org/role/delRole",
                type:"post",
                dateType:"json",
                data:{
                    "OrgRole":data
                },
                success:function(data){
                    if(data.status){
                        grid.refresh();
                    }
                    Util.alert(data.message)
                }
            })
        };
        Util.confirm("删除角色会同时删除角色-人员的关联，且对人员的权限造成影响，是否继续?", okCallback);
    };

    return {
        showRoleList:showRoleList
    }
});
