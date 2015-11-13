/**
 * Created by YiYing on 2015/1/14.
 */
define([
    "PDUtilDir/util",
    "PDOrgDir/deptSupport",
    "PDOrgDir/userSupport",
    "PDOrgDir/roleSupport",
    "PDOrgDir/roleDirSupport",
    "PDOrgDir/zwSupport",
    "PDOrgDir/gwSupport",
    "PDOrgDir/configSupport",
    "PDOrgDir/orgLogSupport",
    "LocalZTree",
    "ZTree","css!ZTreeCss"],function(Util,Dept,User,Role,RoleDir,ZW,GW,Config,Log,LocalZTree){
    /**
     * 创建部门树
     */
    var createDeptTree = function(){
        /*var ajaxDataFilter = function(treeId, parentNode, responseData){

            return responseData.model;
        };*/
        var setting = {
            async:{
                dataType:"json",
                autoParam:["deptTreeId"],
                enable:true,
                //dataFilter:ajaxDataFilter,
                url: getServer()+"/sword/org/dept/getAsyncDeptTree"
            },
            data: {
                key:{
                    name:"deptName"
                },
                simpleData: {
                    enable: true,
                    idKey: "deptTreeId",
                    pIdKey: "pDeptTreeId",
                    rootPId: ""
                }
            },
            extraSets:{
                scroll:true,
                toolbar:{
                    //showDefault:true,
                    custom:[
                        {
                            name:"新增部门",
                            icon:"fa fa-plus-circle",
                            callback:function(){
                                Dept.addDept();
                            }
                        },
                        {
                            name:"编辑部门",
                            icon:"fa fa-edit",
                            callback:function(){
                                Dept.editDept();
                            }
                        },
                        {
                            name:"删除部门",
                            icon:"fa fa-trash-o",
                            callback:function(){
                                Dept.delDept();
                            }
                        },
                        {
                            name:"部门导入",
                            icon:"fa fa-upload",
                            callback:function(){
                                Dept.importDept();
                            }
                        }
                    ]
                }
            },
            callback: {
                onClick:function (event, treeId, treeNode) {
                    User.showPersonList("getUserByDeptUuidForGrid?deptUuid="+treeNode.deptUuid);
                    //单击节点展开
                    LocalZTree.getZTreeObj("orgtree").expandNode(treeNode);
                }
            }
        };
        LocalZTree.init($("#orgtree"), setting);
    };

    /**
     * 废弃
     */
    var createDeptTree_bak = function(){
        $.ajax({
            //静态数据
            //"url":sysPath+"/org/data/OrgTree.json",
            //"url": getServer()+"/v1/org/dept",
            "url": getServer()+"/sword/org/dept/getAllDept",
            "success":function(data) {
                //console.log(data)
                for (var i = 0, dept; dept = data[i++];) {
                    if (dept.deptTreeId == "root") {
                        dept.open = true;
                        break;
                    }
                }
                var setting = {
                    data: {
                        key:{
                            name:"deptName"
                        },
                        simpleData: {
                            enable: true,
                            idKey: "deptTreeId",
                            pIdKey: "pDeptTreeId"
                        }
                    },
                    extraSets:{
                        scroll:true,
                        toolbar:{
                            //showDefault:true,
                            custom:[
                                {
                                    name:"新增部门",
                                    icon:"fa fa-plus-circle",
                                    callback:function(){
                                        Dept.addDept();
                                    }
                                },
                                {
                                    name:"编辑部门",
                                    icon:"fa fa-edit",
                                    callback:function(){
                                        Dept.editDept();
                                    }
                                },
                                {
                                    name:"部门导入",
                                    icon:"fa fa-upload",
                                    callback:function(){
                                        Dept.importDept();
                                    }
                                }
                            ]
                        }
                    },
                    callback: {
                        onClick:function (event, treeId, treeNode) {
                            User.showPersonList("getUserByDeptUuidForGrid?deptUuid="+treeNode.deptUuid);
                            //单击节点展开
                            LocalZTree.getZTreeObj("orgtree").expandNode(treeNode);
                        }
                    }
                };
                LocalZTree.init($("#orgtree"), setting, data);
            }
        });
    };

    /**
     * 部门树刷新
     */
    var refreshDeptTree = function(){
        LocalZTree.destroy("orgtree");
        createDeptTree();
    };

    /**
     * 创建角色树
     */
    var createRoleTree = function(){
       $.ajax({
            //"url":sysPath+"/org/data/RoleTree.json",
            //"url": util.getServerPath()+"/org/roleDir/v1/",
            "url": getServer()+"/sword/org/roledir/getAllRoleDir",
            "success":function(data) {
                //默认展开
                for (var i = 0, dir; dir = data[i++];) {
                    if (dir.dirCode == "root") {
                        dir.open = true;
                        break;
                    }
                }
                var setting = {
                    data: {
                        key:{
                            name:"dirName"
                        },
                        simpleData: {
                            enable: true,
                            idKey: "dirCode",
                            pIdKey: "pDirCode"
                        }
                    },
                    extraSets:{
                        scroll:true,
                        toolbar:{
                            //showDefault:true,
                            custom:[
                                {
                                    name:"新增类别",
                                    icon:"fa fa-plus-circle",
                                    callback:function(){
                                        RoleDir.addRoleDir();
                                    }
                                },
                                {
                                    name:"编辑类别",
                                    icon:"fa fa-edit",
                                    callback:function(){
                                        RoleDir.editRoleDir();
                                    }
                                },
                                {
                                    name:"删除类别",
                                    icon:"fa fa-trash-o",
                                    callback:function(){
                                        RoleDir.delRoleDir();
                                    }
                                },
                                {
                                    name:"角色类别导入",
                                    icon:"fa fa-upload",
                                    callback:function(){
                                        RoleDir.importRoleDir();
                                    }
                                }
                            ]
                        }
                    },
                    callback: {
                        onClick:function (event, treeId, treeNode) {
                            //$("#orgShowListTitle").html("角色-"+treeNode.dirName);
                            //查询出该节点下的所有角色信息
                            Role.showRoleList("getRoleByRoleDirCodeForGrid?dirCode="+treeNode.dirCode);
                            //单击节点展开
                            LocalZTree.getZTreeObj("roletree").expandNode(treeNode);
                        }
                    }
                };
                LocalZTree.init($("#roletree"), setting, data);
            }
       });
    };

    /**
     * 角色树刷新
     */
    var refreshRoleTree = function(){
        LocalZTree.destroy("roletree");
        createRoleTree();
    };


    /**
     * 创建高级功能树
     */
    var createConfigTree = function(){
        var setting = {
            data: {
                simpleData: {
                    enable: true
                }
            },
            extraSets: {
                scroll: true
            },
            callback: {
                onClick:function (event, treeId, treeNode) {
                    //$("#orgShowListTitle").html("高级-"+treeNode.name);

                    switch(treeNode.id){
                        case "GWConfig":
                            GW.showGWList();
                            break;
                        case "ZWConfig":
                            ZW.showZWList();
                            break;
                        case "AllDept":
                            Dept.showDeptList("getAllDeptForGrid");
                            break;
                        case "AllPerson":
                            User.showPersonList("getAllUserForGrid");
                            break;
                        case "AllRole":
                            Role.showRoleList("getAllRoleForGrid");
                            break;
                        case "RoleDir":
                            RoleDir.showRoleDirList();
                            break;
                        case "NoDeptPerson":
                            User.showPersonList("getNoDeptUserForGrid");
                            break;
                        case "LockPerson":
                            User.showPersonList("getLockedUserForGrid");
                            break;
                        /*case "LockDept":
                            Dept.showDeptList("getLockedDeptForGrid");
                            break;*/
                        case "Log":
                            Log.showOrgLogList();
                            break;
                        case "Config":
                            Config.showConfigSidebar();
                            break;
                    }
                }
            }
        };
        LocalZTree.init($("#orgConfigTree"), setting, [
            { "id": "root", "name": "高级功能", "open": true },
            { "id": "GWConfig", "pId":"root", "name": "岗位管理"},
            { "id": "ZWConfig", "pId": "root", "name": "职务管理"},
            { "id": "AllDept", "pId":"root", "name": "所有部门列表"},
            { "id": "AllPerson", "pId": "root", "name": "所有人员列表"},
            { "id": "AllRole", "pId": "root", "name": "所有角色列表"},
            { "id": "RoleDir", "pId": "root", "name": "角色分类列表"},
            { "id": "NoDeptPerson", "pId": "root", "name": "未归属部门人员列表"},
            { "id": "LockPerson", "pId": "root", "name": "冻结人员列表"},
            //{ "id": "LockDept", "pId": "root", "name": "冻结部门列表"},
            { "id": "Log", "pId": "root", "name": "特殊操作日志"},
            { "id": "Config", "pId": "root", "name": "组织机构配置"}
        ]);
    };

    //主面板初始化
    var mainContentInit = function(){
        $("#orgSearchTypeSelect").change(function(e){
            var orgSearchText = $("#orgSearchText");
            switch (e.target.value){
                case "user":
                    orgSearchText.attr("placeholder","姓名|编号|部门名称");
                    $("#li_orgTab>a").click();
                    break;
                case "dept":
                    orgSearchText.attr("placeholder","部门名称|编号");
                    $("#li_orgTab>a").click();
                    break;
                case "role":
                    orgSearchText.attr("placeholder","角色名称|编号");
                    $("#li_roleTab>a").click();
                    break;
            }
            //输入内容清空
            orgSearchText.val("");
        });

        //表格的默认配置
        var defaultConfig = {
            placeAt:"orgSearchContent",
            pageSize:10
        };

        //查询按钮事件绑定
        $("#orgSearchBtn").click(function(){
            //清空面板
            $("#orgSearchContent").empty().show();
            $("#orgMainContent").hide();

            var serachVal = $("#orgSearchText").val();
            var sType = $("#orgSearchTypeSelect option:selected").val();
            switch (sType){
                case "user":
                    User.showPersonList("getUserMhForGrid?param="+encodeURI(serachVal),defaultConfig);
                    break;
                case "dept":
                    Dept.showDeptList("getDeptMhForGrid?param="+encodeURI(serachVal),defaultConfig);
                    break;
                case "role":
                    Role.showRoleList("getRoleMhForGrid?param="+encodeURI(serachVal),defaultConfig);
                    break;
            }
        });
        //为输入框绑定回车事件
        $('#orgSearchText').bind('keypress',function(event){
            if(event.keyCode == "13"){
                $("#orgSearchBtn").click();
            }
        });
        //默认查询出所有人员
        //User.showPersonList("getAllUserForGrid",defaultConfig);
    };

    /**
     * 主页初始化
     */
    var orgMainInit = function(){
        //创建部门树
        createDeptTree();
        //创建角色树
        createRoleTree();
        //创建高级功能树
        createConfigTree();
        //初始化主面板（查询功能）
        mainContentInit();
        //默认显示所有人员列表
        User.showPersonList("getAllUserForGrid");
        /******************************页签切换事件绑定**********************************/
        $("#li_orgTab").click(function(){
            $("#orgSearchContent").hide();
            $("#orgMainContent").show();
        });
        $("#li_roleTab").click(function(){
            $("#orgSearchContent").hide();
            $("#orgMainContent").show();
        });
        $("#li_configTab").click(function(){
            $("#orgSearchContent").hide();
            $("#orgMainContent").show();
        });
    };

    return {
        orgMainInit:orgMainInit,
        refreshDeptTree:refreshDeptTree,
        refreshRoleTree:refreshRoleTree
    }
});

/*
$.ajax({
    url: getServer() + "/sword/org/orgSearchForOrgSelect",
    type: "post",
    dataType: "json",
    data: {
        "user": JSON.stringify(["bd0d19187bd04e08938ee63c2f388b13", "834c44753691460ea8cd9f689f66f3cc"]),
        "dept": JSON.stringify(["1f719f8aee5f4495b255fb54fe8f48f1", "66891565f81e4ff98f612b5e6f18a572"]),
        "role": JSON.stringify(["19cd24bba75e46578c3da74e2b34b3e9", "713c7932c49f482298ae89d9cee9fb89"])
    },
    success: function (data) {
        console.log(data)
    }
})*/
