/**
 * Created by YiYing on 2015/3/25.
 */
define(["PDUtilDir/util","PDUtilDir/tool","PDUtilDir/grid","PDOrgDir/util"],function(Util,Tool,Grid,OrgUtil){

    var Slidebar = null;

    /*****************角色目录相关**************/
    //角色目录导入
    var importRoleDir = function(){
        var mapping = {
            "ServiceName":"org/roledir/importRoleDir",
            "EntityClassName":"com.css.sword.common.org.entity.OrgRoleDir",
            "目录名称":"dirName","目录编号":"dirCode","父目录编号":"pDirCode"
        };
        OrgUtil.importExcel({
            "title":"角色目录导入",
            "templeteURL":OrgUtil.sysPath+"/org/views/importRoleDir.html",
            "mapping":mapping,
            "importSuccess":function(){
                //刷新角色树
                require(["PDOrgDir/orgSupport"],function(OrgSupport){
                    OrgSupport.refreshRoleTree();
                })
            },
            "callback":function(){
                $("#downloadRoleDirExcel").attr("href",getServer()+"/static/core/system/org/importTemplete/角色类别导入.xlsx");
            }
        });
    };

    //编辑角色目录
    var editRoleDir = function(dirCode){
        var roleDirNode = $.fn.zTree.getZTreeObj("roletree").getSelectedNodes()[0];
        var dir_code = dirCode || (roleDirNode?roleDirNode.dirCode:"");
        if(!dir_code){
            Util.alert("请选择要编辑的角色分类.");
            return false;
        }
        $.ajax({
            url:getServer()+"/sword/org/roledir/getRoleDirByCode",
            data:{"dirCode":dir_code},
            success:function(data){
                showRoleDirSidebar({
                    afterLoad:function(){
                        $("#org_RoleDirName").html(data.dirName);
                        Tool.deserialize("RoleDirForm",data);
                        //保存事件绑定
                        saveOrgRoleDirBtnBind("update");
                        //编辑时，角色编号字段不可编辑
                        $("#dirCode").attr("readonly",true);
                        //表单验证
                        validateRoleDir();

                        commonFun({
                            initData:[data.pDirCode],
                            ignoreNodeId:data.dirCode
                        });
                    }
                });
            }
        });
    };

    var commonFun = function(param){
        //角色分类选择初始化
        OrgUtil.selectRoleDirInit({
            id:"pDirName",
            initData:(param?param.initData:[]),
            ignoreNodeId:param?param.ignoreNodeId:"",
            callback:function(data){
                $("#pDirCode").val(data[0]);
            }
        });
    };

    //新增角色目录
    var addRoleDir = function(){
        showRoleDirSidebar({
            afterLoad:function(){
                //保存事件绑定
                saveOrgRoleDirBtnBind("insert");
                var curNode = $.fn.zTree.getZTreeObj("roletree").getSelectedNodes()[0];//.getParentNode();
                commonFun(curNode&&{initData:[curNode.dirCode]});
                //$("#PDirName").val(curNode.dirName);
                $("#pDirCode").val(curNode&&curNode.dirCode);

                //表单验证
                validateRoleDir({
                    rules:{
                        dirCode:{
                            required:true,
                            PD_ZSDX:true,
                            maxlength:32,
                            remote:{
                                type:"POST",                                        //请求方式
                                url: getServer()+"/sword/org/roledir/validateRoleDirCode",      //请求的服务
                                data:{                                              //要传递的参数
                                    dirCode:function(){return $("#dirCode").val();}
                                }
                            }
                        }
                    },
                    messages: {
                        dirCode:{
                            remote:"角色目录编号已存在,请重新输入"
                        }
                    }
                });
            }
        });
    };

    /**
     * 角色目录保存
     */
    var saveOrgRoleDirBtnBind = function(saveType){
        $("#saveOrgRoleDirBtn").bind("click",function(){
            if($("#RoleDirForm").valid()){
                //保存按钮禁用
                $("#saveOrgRoleDirBtn").attr("disabled","disabled");
                //var entity = OrgUtil.getNgModel("tab_RoleDir");
                var entity = Tool.serialize("RoleDirForm");
                $.ajax({
                    url:getServer()+"/sword/org/roledir/saveRoleDir?saveType="+saveType,
                    dataType:"json",
                    data:entity,
                    success:function(data){
                        //console.log(data);
                        if(data.status){
                            /*//刷新树
                            //$.fn.zTree.getZTreeObj("roletree").reAsyncChildNodes(null, "refresh");
                            var tree = $.fn.zTree.getZTreeObj("roletree");
                            var curNode = tree.getSelectedNodes()[0];
                            //除去在高级功能页签下的情况
                            if(curNode && $("#li_roleTab").attr("class")=="active"){
                                if(saveType=="insert"){
                                    $.fn.zTree.getZTreeObj("roletree").addNodes(curNode,entity);
                                }else{
                                    curNode.dirName = entity.dirName;
                                }
                            }else{
                                //在高级功能下操作时需刷新表格
                                Grid.getGrid("OrgRoleDirList").refresh();
                                //查找对应的树节点并更新
                                curNode = tree.getNodesByParam("dirCode",entity.dirCode)[0];
                                curNode.dirName = entity.dirName;
                            }
                            tree.updateNode(curNode);*/

                            //在高级功能下操作时需刷新表格
                            if($("#li_configTab").attr("class")=="active"){
                                Grid.getGrid("OrgRoleDirList").refresh();
                            }
                            //刷新角色树
                            require(["PDOrgDir/orgSupport"],function(OrgSupport){
                                OrgSupport.refreshRoleTree();
                            });
                            //关闭侧边栏
                            Slidebar.close();
                        }
                        Util.alert(data.message);
                        $("#saveOrgRoleDirBtn").removeAttr("disabled");
                    }
                })
            }
        })
    };

    var validateRoleDir = function(extend){
        //数据验证
        $("#RoleDirForm").validate($.extend(true,{
            rules:{
                dirName:{required:true,maxlength:50}
            },
            messages: {}
        },extend));
    };

    //弹出角色目录侧边栏
    var showRoleDirSidebar = function(param){
        Slidebar = Util.slidebar($.extend({
            url:getStaticPath()+"/core/system/org/views/orgRoleDir.html",
            cache:false,
            close:true,
            width:"500px"
        },param));
    };

    /**
     * 显示角色目录列表
     */
    var showRoleDirList = function(){
        var config = {
            id: "OrgRoleDirList",
            realSort:true,
            multi:false,
            toolbar:[
                {name:"新增目录",icon:"fa fa-plus-circle",callback:addRoleDir},
                {name:"删除目录",icon:"fa fa-trash-o",callback:delRoleDirGrid},
                {name:"目录导入",icon:"fa fa-upload",callback:importRoleDir}
            ],
            layout: [
                {
                    name: "目录编号", field: "dirCode",sort:true, click: function (e) {
                        editRoleDir(e.data.row.dirCode);
                    }
                },
                {name: "目录名称", field: "dirName",sort:true},
                {name: "父节点编号", field: "pDirCode",sort:true},
                {name: "父节点名称", field: "pDirName"}
            ],
            data: {
                "type": "URL",
                "value": getServer() + "/sword/org/roledir/getAllRoleDirForGrid"
            }
        };
        Grid.init($.extend(config,OrgUtil.gridDefaultConfig));
    };

    /**
     * 删除角色分类
     */
    var delRoleDir = function(){
        var tree = $.fn.zTree.getZTreeObj("roletree");
        var curNode = tree.getSelectedNodes()[0];

        var okCallback = function(){
            $.ajax({
                url:getServer()+"/sword/org/roledir/delRoleDir",
                type:"post",
                dateType:"json",
                data:{
                    "dirCode":curNode.dirCode
                },
                success:function(data){
                    if(data.status){
                        tree.removeNode(curNode);
                    }
                    Util.alert(data.message)
                }
            })
        };
        if(curNode){
            Util.confirm("是否删除<code>"+curNode.dirName+"</code>?",okCallback);
        }else{
            Util.alert("请选择要删除的角色分类.");
        }
    };

    var delRoleDirGrid = function(){
        var grid = Grid.getGrid("OrgRoleDirList");
        var data = grid.getSelectedRow();
        if(!data.length){
            Util.alert("请选择要删除的角色目录.");
            return false;
        }
        var okCallback = function(){
            $.ajax({
                url:getServer()+"/sword/org/roledir/delRoleDir",
                type:"post",
                dateType:"json",
                data:data[0],
                success:function(data){
                    if(data.status){
                        grid.refresh();
                    }
                    Util.alert(data.message)
                }
            })
        };
        Util.confirm("是否删除<code>"+data[0].dirName+"</code>?", okCallback);
    };

    return {
        importRoleDir:importRoleDir,
        editRoleDir:editRoleDir,
        addRoleDir:addRoleDir,
        delRoleDir:delRoleDir,
        showRoleDirList:showRoleDirList
    }

});