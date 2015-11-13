/**
 * Created by YiYing on 2015/3/25.
 */
define([
    "PDUtilDir/util",
    "PDUtilDir/tool",
    "PDUtilDir/dialog",
    "PDOrgDir/util",
    "PDUtilDir/grid",
    "PDUtilDir/org/orgSelect"],function(Util,Tool,Dialog,OrgUtil,Grid,OrgSelect){

    //保存时，做新旧对比，找出表格中新增与删除项
    var _Model = {
        users:{"old":[],"_new":[]},     //原有人员、修改后的人员
        gws:{"old":[],"_new":[]}        //原有岗位、修改后的岗位
    };

    var Slidebar = null;

    //部门导入
    var importDept = function(){
        var mapping = {
            "ServiceName":"org/dept/importDept",
            "EntityClassName":"com.css.sword.common.org.entity.OrgDept",
            "部门编号":"deptCode","部门名称":"deptName",
            "成本中心名称":"costCenterName","成本中心代码":"costCenterCode","部门级别":"deptLevel",
            "显示序号":"sort","部门树ID":"deptTreeId","所属部门树ID":"pDeptTreeId","部门OU":"ou",
            "部门信息1":"extend1","部门信息2":"extend2","部门信息3":"extend3","部门信息4":"extend4",
            "部门信息5":"extend5","部门信息6":"extend6","部门信息7":"extend7","部门信息8":"extend8",
            "部门信息9":"extend9","部门信息10":"extend10","部门信息11":"extend11","部门信息12":"extend12",
            "部门信息13":"extend13","部门信息14":"extend14","部门信息15":"extend15","部门信息16":"extend16",
            "部门信息17":"extend17","部门信息18":"extend18","部门信息19":"extend19","部门信息20":"extend20"
        };
        OrgUtil.importExcel({
            "title":"部门导入",
            "templeteURL":OrgUtil.sysPath+"/org/views/importDept.html",
            "mapping":mapping,
            "importSuccess":function(){
                //刷新部门树
                require(["PDOrgDir/orgSupport"],function(OrgSupport){
                    OrgSupport.refreshDeptTree();
                })
            },
            "callback":function(){
                $("#downloadDeptExcel").attr("href",getServer()+"/static/core/system/org/importTemplete/部门导入.xlsx");
            }
        });
    };

    //部门侧边栏操作按钮显示隐藏控制
    var orgSidebarTools = function(){
        $("#tab_DeptBaseInfo").click(function(){
            $("#btn_orgDetpAddPerson").hide();
        });
        $("#tab_DeptMembers").click(function(){
            $("#btn_orgDetpAddPerson").show();
        });
        $("#tab_DeptGWInfo").click(function(){
            $("#btn_orgDetpAddPerson").hide();
        });
        $("#tab_DeptExtendInfo").click(function(){
            $("#btn_orgDetpAddPerson").hide();
        })
    };

    //所有新增和编辑部门时需要绑定的事件
    var allBindInit = function(){
        //页签切换时控制操作按钮的显示隐藏
        //orgSidebarTools();
        //新增成员
        addMemberBtnBind();
        //删除成员事件绑定
        delPsnBtnBind();
        //新增岗位
        addGwBtnBind();
        //删除岗位事件绑定
        delGwBtnBind();
        //岗位From人员选择和岗位选择事件绑定
        gwFromBind();
        //新增岗位必填验证
        validateGwForm();
        //保存部门验证
        validateDeptInfo();
        //替换掉扩展字段label
        replaceLabel();
        //部门领导选择
        OrgSelect.CS_OrgSelect({
            id : "DdeptLeader",
            multi : false,
            title : "人员选择",
            tagData : ["user"],
            //dataFilter:{user:{root:$("#deptCode").val()}},
            callback : function(data){
                if(data.user){
                    data = data.user[0];
                    $("#DdeptLeader").val(data.userName);
                    $("#DdeptLeaderCode").val(data.userCode);
                    $("#DdeptLeaderUuid").val(data.userUuid);
                }else{
                    $("#DdeptLeader").val("");
                    $("#DdeptLeaderCode").val("");
                    $("#DdeptLeaderUuid").val("");
                }
            }
        });
        //管理人员选择
        /*OrgSelect.CS_OrgSelect({
            id : "deptManager",
            multi : false,
            title : "人员选择",
            tagData : ["user"],
            //dataFilter:{user:{root:$("#deptCode").val()}},
            callback : function(data){
                if(data.user){
                    data = data.user[0];
                    $("#deptManager").val(data.userName);
                    $("#deptManagerCode").val(data.userCode);
                }else{
                    $("#deptManager").val("");
                    $("#deptManagerCode").val("");
                }
            }
        });*/
        //所属部门选择
        OrgSelect.CS_OrgSelect({
            id : "pDeptName",
            multi : false,
            title : "部门选择",
            tagData : ["dept"],
            callback : function(data){
                if(data.dept){
                    data = data.dept[0];
                    $("#pDeptName").val(data.deptName);
                    $("#pDeptCode").val(data.deptCode);
                    $("#pDeptTreeId").val(data.deptTreeId);
                }else{
                    $("#pDeptName").val("");
                    $("#pDeptCode").val("");
                    $("#pDeptTreeId").val("");
                }
            }
        });
        //部门扩展
        require(["PDOrgDir/deptExtend"],function(Extend){
            Extend && (typeof(Extend.init)=="function" && Extend.init())
        });
    };

    /**
     * 替换掉扩展字段的Label标签值
     */
    var replaceLabel = function(){
        $.ajax({
            url:getServer()+"/sword/org/config/getOrgConfig",
            dataType:"json",
            success:function(data){
                var deptData = data.deptExtendConfig;
                if(deptData){
                    var deptJSON = JSON.parse(deptData);
                    $("#DeptExtendInfoForm label").each(function(index,item){
                        var val = deptJSON[$(item).attr("for").replace("D","")];
                        val && $(item).text(val);
                    })
                }
            }
        });
    };

    //部门编辑
    var editDept = function(uuid){
        var deptNode = $.fn.zTree.getZTreeObj("orgtree").getSelectedNodes()[0];
        var deptUuid = uuid || (deptNode?deptNode.deptUuid:"");
        if(!deptUuid){
            Util.alert("请选择要编辑的部门.");
            return false;
        }
        //获取当前需要编辑的部门对象数据
        $.ajax({
            url:getServer()+"/sword/org/dept/getAllDeptInfoByUuid",
            dataType:"json",
            data:{"deptUuid":deptUuid},
            success:function(data){
                _Model = {
                    users:{
                        "old":data.Members,
                        "_new":$.extend([],data.Members)
                    },
                    gws:{
                        "old":data.GW,
                        "_new":$.extend([],data.GW)
                    }
                };

                //弹出部门编辑侧边栏
                showDeptSidebar({
                    afterLoad:function(){
                        $("#org_deptName").html(data.DeptInfo.deptName);
                        //$("#org_deptCode").html(data.DeptInfo.deptCode);
                        //表单数据初始化
                        Tool.deserialize("DeptBaseInfoForm",data.DeptInfo);
                        Tool.deserialize("DeptExtendInfoForm",data.DeptInfo);
                        //人员列表
                        $("#DeptPsnList").empty().append(Util.template("T_DeptMembers",data));
                        //岗位列表
                        $("#DeptGwList").empty().append(Util.template("T_GWList",data));

                        allBindInit();
                        //部门保存
                        saveDeptBtnBind("edit");
                        //部门编号为root时部门编号字段不可编辑
                        data.DeptInfo.deptCode=="root" && $("#deptCode").attr("readonly",true);
                    }
                });
            }
        });
    };

    //部门信息验证
    var validateDeptInfo = function(){
        $("#DeptBaseInfoForm").validate({
            ignore:"",
            rules:{
                deptName:{required:true,maxlength:50},
                deptCode:{
                    required:true,
                    PD_ZSDX:true,
                    maxlength:20,
                    remote:{
                        type:"POST",
                        url: getServer()+"/sword/org/dept/validateDeptCode",
                        data:{
                            deptCode:function(){return $("#deptCode").val();},
                            deptUuid:function(){return $("#deptUuid").val();}
                        }
                    }
                },
                costCenterCode:{maxlength:32},sort:{digits:true,maxlength:8},deptLevel:{maxlength:20},
                extend1:{maxlength:50},extend2:{maxlength:50},extend3:{maxlength:50},extend4:{maxlength:50},extend5:{maxlength:50},
                extend6:{maxlength:50},extend7:{maxlength:50},extend8:{maxlength:50},extend9:{maxlength:50},extend10:{maxlength:50},
                extend11:{maxlength:50},extend12:{maxlength:50},extend13:{maxlength:50},extend14:{maxlength:50},extend15:{maxlength:50},
                extend16:{maxlength:50},extend17:{maxlength:50},extend18:{maxlength:50},extend19:{maxlength:50},extend20:{maxlength:50}
            },
            messages: {
                deptCode:{
                    remote:"部门编号已存在,请重新输入"
                }
            }
        });
        $("#DeptExtendInfoForm").validate({
            ignore:"",
            rules:{
                extend1:{maxlength:50},extend2:{maxlength:50},extend3:{maxlength:50},extend4:{maxlength:50},extend5:{maxlength:50},
                extend6:{maxlength:50},extend7:{maxlength:50},extend8:{maxlength:50},extend9:{maxlength:50},extend10:{maxlength:50},
                extend11:{maxlength:50},extend12:{maxlength:50},extend13:{maxlength:50},extend14:{maxlength:50},extend15:{maxlength:50},
                extend16:{maxlength:50},extend17:{maxlength:50},extend18:{maxlength:50},extend19:{maxlength:50},extend20:{maxlength:50}
            }
        });
    };

    //部门保存
    var saveDeptBtnBind = function(saveType){
        $("#btn_orgDetpSave").click(function(){
            //表单验证
            if(!$("#DeptBaseInfoForm").valid()){
                $("a[data-target='#DeptBaseInfo']").click();
                return;
            }
            if(!$("#DeptExtendInfoForm").valid()){
                $("a[data-target='#DeptExtendInfo']").click();
                return;
            }

            $("#btn_orgDetpSave").attr("disabled","disabled");
            //岗位转换，把一条岗位记录拆为后端的两张表，方便后端转换为对应实体
            var gwZH = function(gwList){
                var orgDeptGw = [],orgDeptGwUser=[];
                for(var i= 0,m;m=gwList[i++];){
                    var arr = m.gwMembersUuid.split(";");
                    var uuid = m.deptGwUserUuid?m.deptGwUserUuid.split(";"):[];
                    for(var j= 0;j<arr.length;j++){
                        var userUuid = arr[j];
                        if(userUuid!=""){
                            orgDeptGwUser.push({
                                "uuid":uuid[j]||"",
                                "gwUuid": m.gwUuid,
                                "userUuid":userUuid
                            })
                        }
                    }
                    orgDeptGw.push({
                        "uuid": m.uuid||"",
                        "gwUuid": m.gwUuid,
                        "extend": m.gwExtend
                    })
                }
                return {
                    "orgDeptGw":orgDeptGw,
                    "orgDeptGwUser":orgDeptGwUser
                }
            };

            var addGwZh = gwZH(Tool.jsonArrayIntersection(_Model.gws._new,_Model.gws.old,gwAndUserRule));
            var delGwZh = gwZH(Tool.jsonArrayIntersection(_Model.gws.old,_Model.gws._new,gwAndUserRule));
            var dept = $.extend(Tool.serialize("DeptBaseInfoForm"),Tool.serialize("DeptExtendInfoForm"));
            var data = {
                "dept": JSON.stringify(dept),
                "addPsn":JSON.stringify(Tool.jsonArrayIntersection(_Model.users._new,_Model.users.old,psnRule)),
                "delPsn":JSON.stringify(Tool.jsonArrayIntersection(_Model.users.old,_Model.users._new,psnRule)),
                "addDeptGw":JSON.stringify(addGwZh.orgDeptGw),
                "addDeptGwUser":JSON.stringify(addGwZh.orgDeptGwUser),
                "delDeptGw":JSON.stringify(delGwZh.orgDeptGw),
                "delDeptGwUser":JSON.stringify(delGwZh.orgDeptGwUser)
            };

            //console.log(data);
            //return false;

            $.ajax({
                url:getServer()+"/sword/org/dept/saveDept",
                dataType:"json",
                data:data,
                success:function(data){
                    if(data.status){
                        /*//刷新树
                        var tree = $.fn.zTree.getZTreeObj("orgtree");
                        var curNode = tree.getSelectedNodes()[0];
                        if(saveType=="insert"){
                            dept.deptUuid = data.deptUuid;
                            tree.addNodes(curNode,dept);
                        }
                        if(saveType=="edit"){
                            //curNode.name = dept.deptName;
                            alert(data.message);
                            //刷新页面更新部门树
                            location.reload();
                        }
                        tree.updateNode(curNode);*/

                        //刷新部门树
                        require(["PDOrgDir/orgSupport"],function(OrgSupport){
                            OrgSupport.refreshDeptTree();
                        });
                        //刷新部门列表
                        if($("#li_configTab").attr("class")=="active"){
                            Grid.getGrid("OrgDeptList") && Grid.getGrid("OrgDeptList").refresh();
                        }
                        //刷新人员列表
                        if($("#li_orgTab").attr("class")=="active"){
                            Grid.getGrid("OrgPersonList") && Grid.getGrid("OrgPersonList").refresh();
                        }
                        //关闭侧边栏
                        Slidebar.close();
                    }
                    Util.alert(data.message);
                    $("#btn_orgDetpSave").removeAttr("disabled");
                }
            })
        });
    };

    var psnRule = function(one,two){
        return one.userUuid==two.userUuid?true:false;
    };

    /**
     * 删除人员事件绑定
     */
    var delPsnBtnBind = function(){
        $("#DeptPsnList").bind("click",function(e){
            if(e.target.tagName.toLowerCase()=="i"){
                var $curTrTds = $(e.target.parentNode.parentNode).find("td");
                var index = Tool.indexOfJsonArray({"userUuid":$($curTrTds[0]).text()},_Model.users._new,psnRule);
                if(index!=-1){
                    _Model.users._new.splice(index,1);
                    //重新渲染表格
                    $("#DeptPsnList").empty().append(Util.template("T_DeptMembers",{"Members":_Model.users._new}))
                }
            }
        });
    };

    //新增成员
    var addMemberBtnBind = function(){
        OrgSelect.CS_OrgSelect({
            id : "btn_orgDetpAddPerson",
            multi : true,
            title : "人员选择",
            dataRefill: false,
            tagData : ["user"],
            callback : function(data){
                data = data.user;
                if(data.length){
                    for(var i= 0,item;item=data[i++];){
                        if(Tool.indexOfJsonArray(item,_Model.users._new,psnRule)==-1){
                            item["jz"] = Number($("#jzFlag").val());
                            _Model.users._new.push(item)
                        }
                    }
                    $("#DeptPsnList").empty().append(Util.template("T_DeptMembers",{"Members":_Model.users._new}))
                }
            }
        });
    };

    /**
     * 自定义两个json对象的校验规则
     * @param one
     * @param two
     * @returns {boolean}
     */
    var gwRule = function(one,two){
        return one.gwUuid==two.gwUuid?true:false;
    };

    var gwAndUserRule = function(one,two){
        //岗位UUID和该岗位下对应的人员一致时才相等
        return (one.gwUuid==two.gwUuid && one.gwMembersUuid==two.gwMembersUuid)?true:false;
    };

    /**
     * 新增岗位必填项验证
     */
    var validateGwForm = function(){
        //数据验证
        $("#DeptGWInfoForm").validate({
            rules:{
                gwCode:{required:true},
                gwMembers:{required:true}
            },
            messages: {
                gwCode:"请选择岗位",
                gwMembers:"请选择人员"
            }
        });
    };

    //新增岗位事件绑定
    var addGwBtnBind = function(){
        $("#addDeptGwBtn").bind("click",function(){
            if($("#DeptGWInfoForm").valid()){
                var data = Tool.serialize("DeptGWInfoForm");
                if(Tool.indexOfJsonArray(data,_Model.gws._new,gwRule)==-1){
                    _Model.gws._new.push(data)
                }else{
                    Util.alert("岗位<code>"+data.gwName+"</code>已经在列表中.");
                }
                $("#DeptGwList").empty().append(Util.template("T_GWList",{"GW":_Model.gws._new}));
                //清空数据
                $("#DeptGWInfoForm")[0].reset();
            }
        });
    };

    //删除岗位
    var delGwBtnBind = function(){
        $("#DeptGwList").bind("click",function(e){
            if(e.target.tagName.toLowerCase()=="i"){
                var $curTrTds = $(e.target.parentNode.parentNode).find("td");
                var index = Tool.indexOfJsonArray({"gwUuid":$($curTrTds[0]).text()},_Model.gws._new,gwRule);
                if(index!=-1){
                    _Model.gws._new.splice(index,1);
                    //重新渲染表格
                    $("#DeptGwList").empty().append(Util.template("T_GWList",{"GW":_Model.gws._new}));
                }
            }
        });
    };


    var showGwList = function(serviceName){
        //岗位列表
        var config = {
            placeAt:"DeptSelectGwGrid",           //存放Grid的容器ID
            pageSize:10,                          //一页多少条数据
            id: "SelectGwGrid",
            realSort:true,
            multi:false,
            //index:true,
            layout: [
                {name: "岗位编号", field: "gwCode",sort:true},
                {name: "岗位名称", field: "gwName",sort:true}/*,
                 {name: "序号", field: "sort",sort:true}*/
            ],
            data: {
                "type": "URL",
                "value": getServer() + "/sword/org/gw/"+serviceName
            }
        };
        Grid.init(config);
    };

    var gwFromBind = function(){
        //选择岗位
        $("#gwCode").bind("click",function(){
            //为弹出框增加操作按钮
            var buttons = [];
            buttons.push(
                {name:"确定",callback:function(){
                    var data = Grid.getGrid("SelectGwGrid").getSelectedRow()[0];
                    if(data){
                        $("#gwCode").val(data.gwCode);
                        $("#gwUuid").val(data.gwUuid);
                        $("#gwName").val(data.gwName);
                    }else{
                        $("#gwCode").val("");
                        $("#gwUuid").val("");
                        $("#gwName").val("");
                    }
                    dialog.hide();
                }}
            );
            var dialog = Dialog({
                id:"DeptSelectGw",
                cache:false,                 //是否缓存，默认为true
                title:"岗位选择",
                width:"520px",
                buttons:buttons
            });

            var selectGwHtmlPath = getServer()+"/static/core/system/org/views/selectGw.html";
            require(["text!"+selectGwHtmlPath],function(html){
                dialog.setBody(html);
                showGwList("getAllGwForGrid");
                dialog.show();
                //绑定模糊查询事件
                $("#gwSearchBtn").click(function(){
                    showGwList("getGwMhForGrid?param="+encodeURI($("#gwSearch").val()));
                });
                //为输入框绑定回车事件
                $('#gwSearch').bind('keypress',function(event){
                    if(event.keyCode == "13"){
                        $("#gwSearchBtn").click();
                    }
                });
            });
        });
        //选择人员
        OrgSelect.CS_OrgSelect({
            id : "gwMembers",
            multi : true,
            title : "人员选择",
            dataRefill: false,
            tagData : ["user"],
            //dataFilter:{user:{root:$("#deptCode").val()}},
            callback : function(data){
                data = data.user;
                if(data.length){
                    var psn="",psnCode="",psnUuid="";
                    for(var i= 0,item;item=data[i++];){
                        psn+= item.userName+"/"+item.userCode+";";
                        psnCode+= item.userCode+";";
                        psnUuid+= item.userUuid+";";
                    }
                    $("#gwMembers").val(psn);
                    $("#gwMembersCode").val(psnCode);
                    $("#gwMembersUuid").val(psnUuid);
                }else{
                    $("#gwMembers").val("");
                    $("#gwMembersCode").val("");
                    $("#gwMembersUuid").val("");
                }

            }
        });
    };

    //新增部门
    var addDept = function(){
        var deptNode = $.fn.zTree.getZTreeObj("orgtree").getSelectedNodes()[0];
        showDeptSidebar({
            afterLoad:function(){
                //Model清空
                _Model = {
                    users:{"old":[],"_new":[]},     //原有人员、修改后的人员
                    gws:{"old":[],"_new":[]}        //原有岗位、修改后的岗位
                };
                if(deptNode){
                    $("#pDeptName").val(deptNode.deptName);
                    $("#pDeptTreeId").val(deptNode.deptTreeId);
                    $("#pDeptCode").val(deptNode.deptCode);
                }
                allBindInit();
                //部门保存
                saveDeptBtnBind("insert");
            }
        });
    };

    //弹出部门侧边栏
    var showDeptSidebar = function(param){
        Slidebar = Util.slidebar($.extend({
            url:getStaticPath()+"/core/system/org/views/orgDept.html",
            cache:false,
            close:true,
            width:"800px"
        },param));
    };

    /**
     * 显示部门列表
     */
    var showDeptList = function(serviceName,extendCofig){
        var config = {
            id: "OrgDeptList",
            realSort:true,
            multi:false,
            toolbar:[
                {name:"新增部门",icon:"fa fa-plus-circle",callback:addDept},
                {name:"删除部门",icon:"fa fa-trash-o",callback:delDeptGrid},
                {name:"部门导入",icon:"fa fa-upload",callback:importDept}
            ],
            layout: [
                {
                    name: "部门名称", field: "deptName",width:"20%",sort:true, click: function (e) {
                    editDept(e.data.row.deptUuid);
                }
                },
                {name: "部门编号", field: "deptCode",width:"15%",sort:true},
                {name: "部门领导", field: "leader",width:"15%"},
                {name: "部门OU", field: "ou",width:"50%"}/*,
                {name: "序号", field: "sort",width:"15%",sort:true}*/
            ],
            data: {
                "type": "URL",
                //"value": sysPath + "/org/data/AllDept.json"
                "value": getServer() +"/sword/org/dept/"+serviceName
            }
        };
        /*if(serviceName=="getLockedDeptForGrid"){
            $.extend(config,{
                multi:true,
                toolbar:[
                    {name:"删除部门",icon:"fa fa-trash-o",callback:delDept}
                ]});
        }*/
        Grid.init($.extend(config,extendCofig||OrgUtil.gridDefaultConfig));
    };

    var delDept = function(){
        var tree = $.fn.zTree.getZTreeObj("orgtree");
        var curNode = tree.getSelectedNodes()[0];
        var okCallback = function(){
            $.ajax({
                url:getServer()+"/sword/org/dept/delDept",
                type:"post",
                dateType:"json",
                data:{
                    "deptUuid":curNode.deptUuid,
                    "deptName":curNode.deptName,
                    "deptCode":curNode.deptCode,
                    "deptTreeId":curNode.deptTreeId
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
            Util.confirm("是否删除<code>"+curNode.deptName+"</code>?",okCallback);
        }else{
            Util.alert("请选择要删除的部门.");
        }
    };

    var delDeptGrid = function(){
        var grid = Grid.getGrid("OrgDeptList");
        var data = grid.getSelectedRow();
        if(!data.length){
            Util.alert("请选择要删除的部门.");
            return false;
        }
        var okCallback = function(){
            $.ajax({
                url:getServer()+"/sword/org/dept/delDept",
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
        Util.confirm("是否删除<code>"+data[0].deptName+"</code>?", okCallback);
    };

    return {
        importDept:importDept,
        editDept:editDept,
        addDept:addDept,
        delDept:delDept,
        showDeptList:showDeptList
    }
});