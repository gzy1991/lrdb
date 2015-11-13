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
        "Depts":{"old":[],"_new":[]},            //所属部门信息
        "Roles":{"old":[],"_new":[]},            //所属角色信息
        "GWs":{"old":[],"_new":[]}               //所属岗位信息
    };

    var Slidebar = null;

    //人员导入
    var importPerson = function(){
        var mapping = {
            "ServiceName":"org/user/importUser",
            "EntityClassName":"com.css.sword.common.org.vo.ImportUserVo",
            "员工编号":"user.userCode","用户名称":"user.userName","性别":"user.sex","生日":"user.birthday",
            "办公电话":"user.officePhone","移动电话":"user.phone","传真":"user.fax","邮箱":"user.email",
            "职务名称":"user.zwName","职务编号":"user.zwUuid","显示序号":"user.sort",
            "部门编号":"deptCode","兼职部门编号":"jzDeptCodes","所属角色编号":"roleCodes",
            "人员信息1":"user.extend1","人员信息2":"user.extend2","人员信息3":"user.extend3",
            "人员信息4":"user.extend4","人员信息5":"user.extend5","人员信息6":"user.extend6",
            "人员信息7":"user.extend7","人员信息8":"user.extend8","人员信息9":"user.extend9",
            "人员信息10":"user.extend10","人员信息11":"user.extend11","人员信息12":"user.extend12",
            "人员信息13":"user.extend13","人员信息14":"user.extend14","人员信息15":"user.extend15",
            "人员信息16":"user.extend16","人员信息17":"user.extend17","人员信息18":"user.extend18",
            "人员信息19":"user.extend19","人员信息20":"user.extend20"
        };
        OrgUtil.importExcel({
            "title":"人员导入",
            "templeteURL":OrgUtil.sysPath+"/org/views/importPerson.html",
            "mapping":mapping,
            "importSuccess":function(){
                Grid.getGrid("OrgPersonList").refresh();
            },
            "callback":function(){
                $("#downloadPsnExcel").attr("href",getServer()+"/static/core/system/org/importTemplete/人员导入.xlsx");
            }
        });
    };
    //新增人员
    var addPerson = function(){
        showPersonSidebar({
            afterLoad: function(){
                _Model = {
                    "Depts":{"old":[],"_new":[]},            //所属部门信息
                    "Roles":{"old":[],"_new":[]},            //所属角色信息
                    "GWs":{"old":[],"_new":[]}               //所属岗位信息
                };

                //职务初始化
                //initZW();
                //隐藏所属角色、所属岗位页签
                var li = $("#PsnTabId>li");
                $(li[1]).hide();$(li[2]).hide();

                allBindInit();

                //部门设置默认值
                var node = $.fn.zTree.getZTreeObj("orgtree").getSelectedNodes()[0];
                if(node){
                    $("#deptName").val(node.deptName);
                    $("#deptCode").val(node.deptCode);
                    $("#deptUuid").val(node.deptUuid);
                    $("#ou").val(node.ou);
                    //必须在allBindInit方法执行后才能调用该事件
                    $("#addDeptBtn").click();
                }
            }
        });
    };

    /**
     * 表单验证
     */
    var validateUser = function(){
        //数据验证
        $("#PersonBaseInfoForm").validate({
            ignore:"",
            rules:{
                userCode:{
                    required:true,
                    PD_ZSDX:true,
                    maxlength:20,
                    remote:{
                        type:"POST",
                        url: getServer()+"/sword/org/user/validateUserCode",
                        data:{
                            userCode:function(){return $("#userCode").val();},
                            userUuid:function(){return $("#userUuid").val();}
                        }
                    }
                },
                userName:{
                    required:true,
                    maxlength:50
                },
                officePhone:{maxlength:20},
                phone:{PD_mobile:true},
                fax:{maxlength:20},
                email:{PD_mail:true,maxlength:50},
                sort:{digits:true,maxlength:8},
                extend1:{maxlength:50},extend2:{maxlength:50},extend3:{maxlength:50},extend4:{maxlength:50},extend5:{maxlength:50},
                extend6:{maxlength:50},extend7:{maxlength:50},extend8:{maxlength:50},extend9:{maxlength:50},extend10:{maxlength:50},
                extend11:{maxlength:50},extend12:{maxlength:50},extend13:{maxlength:50},extend14:{maxlength:50},extend15:{maxlength:50},
                extend16:{maxlength:50},extend17:{maxlength:50},extend18:{maxlength:50},extend19:{maxlength:50},extend20:{maxlength:50}
            },
            messages: {
                userCode:{
                    remote:"员工编号已存在,请重新输入."
                }
            }
        });
        $("#PersonExtendInfoForm").validate({
            ignore:"",
            rules:{
                extend1:{maxlength:50},extend2:{maxlength:50},extend3:{maxlength:50},extend4:{maxlength:50},extend5:{maxlength:50},
                extend6:{maxlength:50},extend7:{maxlength:50},extend8:{maxlength:50},extend9:{maxlength:50},extend10:{maxlength:50},
                extend11:{maxlength:50},extend12:{maxlength:50},extend13:{maxlength:50},extend14:{maxlength:50},extend15:{maxlength:50},
                extend16:{maxlength:50},extend17:{maxlength:50},extend18:{maxlength:50},extend19:{maxlength:50},extend20:{maxlength:50}
            }
        });
    };

    //人员编辑
    var editPerson = function(userUuid){
        //获取当前需要编辑的人员对象数据
        $.ajax({
            url:getServer()+"/sword/org/user/getAllUserInfoByUuid",
            dataType:"json",
            data:{"userUuid":userUuid},
            success:function(data){
                showPersonSidebar({
                    afterLoad:function(){
                        //把数据绑定到model上，供保存时使用
                        _Model.Depts.old = data.Depts;
                        _Model.Depts._new = $.extend([],data.Depts);
                        _Model.Roles.old = data.Roles;
                        _Model.Roles._new = $.extend([],data.Roles);
                        _Model.GWs.old = data.GWs;
                        _Model.GWs._new = $.extend([],data.GWs);

                        //显示关联部门区域
                        $("#org_PersonName").html(data.PersonInfo.userName);
                        //职务初始化
                        //initZW(data.PersonInfo.zwUuid);
                        Tool.deserialize("PersonBaseInfoForm",data.PersonInfo);
                        Tool.deserialize("PersonExtendInfoForm",data.PersonInfo);
                        //锁定原因
                        var lockedReason = $("#lockedReason");
                        if(data.PersonInfo.locked){
                            data.PersonInfo.loginFailNum>4 ? lockedReason.html("异常登录") : lockedReason.html("管理员锁定");
                        }else{
                            lockedReason.html("无");
                        }

                        //性别与是否冻结
                        //$("input[type='radio'][name='sex'][value='"+data.Org.Person.PersonInfo.sex+"']").attr("checked", "checked");
                        //$("input[type='radio'][name='locked'][value='"+data.Org.Person.PersonInfo.locked+"']").attr("checked", "checked");
                        //OrgUtil.setNgModel("PersonExtendInfo",data);
                        //所属角色
                        $("#PsnRoleList").empty().append(Util.template("T_PersonRoles",data));
                        //所属岗位
                        $("#PsnGwList").empty().append(Util.template("T_PersonGW",data));
                        //部门列表
                        $("#PsnDeptList").empty().append(Util.template("T_PersonDept",data));

                        allBindInit();
                    }
                });
            }
        });
    };

    var allBindInit = function(){
        //表单验证
        validateUser();
        //保存按钮事件绑定
        savePsnBtnBind();
        //添加部门事件绑定
        addDeptBtnBind();
        //删除部门列表事件绑定
        delDeptBtnBind();
        //删除角色事件绑定
        delRoleBtnBind();
        //删除岗位事件绑定
        delGwBtnBind();
        //替换掉扩展字段label
        replaceLabel();
        //职务选择
        selectZW();
        //关联角色
        addRoleBtnBind();
        //生日选择
        require(["jquery", "Date","DateCN", "css!DateCss"],function($) {
            $("#birthday").datetimepicker({
                //设置使用语言：cn是自定义的中文版本，还可以扩展其他语言版本
                language: "cn",
                //输出格式化
                format: 'yyyy-mm-dd',
                //直接选择‘今天’
                todayBtn: true,
                //设置最精确的时间选择视图
                minView: 'month',
                //高亮当天日期
                todayHighlight: true,
                //选择完毕后自动关闭
                autoclose: true
            });
        });
        //选择部门添加
        OrgSelect.CS_OrgSelect({
            id : "deptName",
            multi : false,
            title : "部门选择",
            tagData : ["dept"],
            callback : function(data){
                if(data.dept){
                    data = data.dept[0];
                    $("#deptName").val(data.deptName);
                    $("#deptCode").val(data.deptCode);
                    $("#deptUuid").val(data.deptUuid);
                    $("#ou").val(data.ou);
                }else{
                    $("#deptName").val("");
                    $("#deptCode").val("");
                    $("#deptUuid").val("");
                    $("#ou").val("");
                }
            }
        });
        //直属领导选择
        OrgSelect.CS_OrgSelect({
            id : "directLeaderName",
            multi : false,
            title : "人员选择",
            tagData : ["user"],
            callback : function(data){
                if(data.user){
                    data = data.user[0];
                    $("#directLeaderName").val(data.userName);
                    $("#directLeader").val(data.userUuid);
                }else{
                    $("#directLeaderName").val("");
                    $("#directLeader").val("");
                }
            }
        });

        //人员扩展
        require(["PDOrgDir/userExtend"],function(Extend){
            Extend && (typeof(Extend.init)=="function" && Extend.init())
        });
    };

    /**
     * 职务选择
     */
    var selectZW = function(){
        $("#zwName").bind("click",function(){
            var buttons = [];
            buttons.push(
                {name:"确定",callback:function(){
                    var data = Grid.getGrid("SelectZwGrid").getSelectedRow()[0];
                    if(data){
                        $("#zwUuid").val(data.zwUuid);
                        $("#zwName").val(data.zwName);
                    }else{
                        $("#zwUuid").val("");
                        $("#zwName").val("");
                    }
                    dialog.hide();
                }}
            );
            var dialog = Dialog({
                id:"SelectZwDialog",
                cache:false,
                title:"职务选择",
                width:"520px",
                body:'<div id="SelectZwGrid"></div>',
                buttons:buttons
            });
            var config = {
                placeAt:"SelectZwGrid",
                pageSize:10,
                id: "SelectZwGrid",
                realSort:true,
                multi:false,
                //index:true,
                layout: [
                    {name: "职务编号", field: "zwCode",sort:true},
                    {name: "职务名称", field: "zwName",sort:true}
                ],
                data: {
                    "type": "URL",
                    "value": getServer() + "/sword/org/zw/getAllZwForGrid"
                }
            };
            Grid.init(config);
            dialog.show();
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
                var personData = data.personExtendConfig;
                if(personData){
                    var personJSON = JSON.parse(personData);
                    $("#PersonExtendInfo label").each(function(index,item){
                        var val = personJSON[$(item).attr("for")];
                        val && $(item).text(val);
                    })
                }
            }
        });
    };

    //职务初始化（废弃，采用选择列表，不使用select）
    /*var initZW = function(val){
        $.ajax({
            //url:sysPath+"/org/data/ZWList.json",
            url:getServer()+"/sword/org/zw/getAllZw",
            dataType:"json",
            success:function(data){
                var $sel = $("#sle_PersonZW");
                //初始化人员操作界面的职务选择下拉
                for(var i= 0,item;item=data[i++];){
                    $sel.append('<option value="'+item.zwUuid+'">'+item.zwName+'</option>');
                }
                //设置选中值
                val && $sel.val(val);
            }
        })
    };*/

    //弹出人员侧边栏
    var showPersonSidebar = function(param){
        Slidebar = Util.slidebar($.extend({
            url:getStaticPath()+"/core/system/org/views/orgPerson.html",
            cache:false,
            close:true,
            width:"800px"
        },param));
    };

    /**
     * 显示人员列表
     * @param serviceName
     * @param extendCofig   主页的查询使用到该参数
     */
    var showPersonList = function(serviceName,extendCofig){
        var config = {
            id: "OrgPersonList",
            realSort:true,
            multi:true,
            toolbar:[
                {name:"新增人员",icon:"fa fa-plus-circle",callback:addPerson},
                {name:"删除人员",icon:"fa fa-trash-o",callback:delPerson},
                {name:"人员导入",icon:"fa fa-upload",callback:importPerson}
            ],
            layout:[
                {name:"员工编号",field:"userCode",sort:true,click:function(e){
                    editPerson(e.data.row.userUuid);
                }},
                {name:"用户名称",field:"userName",sort:true},
                {name:"办公电话",field:"officePhone"},
                {name:"移动电话",field:"phone"},
                {name:"邮件",field:"email"}/*,
                {name:"序号",field:"sort",sort:true}*/
            ],
            data:{
                "type":"URL",
                "value": getServer() + "/sword/org/user/"+ serviceName
            }
        };
       /* if(serviceName=="getAllUserForGrid" || serviceName.indexOf("getUserByDeptUuidForGrid")!=-1){
            $.extend(config,{toolbar:[
                {name:"新增人员",icon:"fa fa-plus-circle",callback:addPerson},
                {name:"人员导入",icon:"fa fa-upload",callback:importPerson}
            ]});
        }
        if(serviceName=="getLockedUserForGrid"){
            $.extend(config,{
                multi:true,
                toolbar:[
                    {name:"删除人员",icon:"fa fa-trash-o",callback:delPerson}
                ]});
        }*/
        Grid.init($.extend(config,extendCofig||OrgUtil.gridDefaultConfig));
    };


    var delPerson = function(){
        var grid = Grid.getGrid("OrgPersonList");
        var data = grid.getSelectedRow();
        if(!data.length){
            Util.alert("请选择要删除的人员.");
            return false;
        }
        var okCallback = function(){
            $.ajax({
                url:getServer()+"/sword/org/user/delUser",
                type:"post",
                dateType:"json",
                data:{
                    "OrgUser":data
                },
                success:function(data){
                    if(data.status){
                        grid.refresh();
                    }
                    Util.alert(data.message)
                }
            })
        };
        Util.confirm("删除人员时该人员相关的所有数据都会被删除，是否继续?", okCallback);
    };

    /**
     * 人员保存
     */
    var savePsnBtnBind = function(){
        $("#savePsnBtn").bind("click",function(){
            //表单验证
            if(!$("#PersonBaseInfoForm").valid()){
                $("a[data-target='#PersonBaseInfo']").click();
                return;
            }
            if(!$("#PersonExtendInfoForm").valid()){
                $("a[data-target='#PersonExtendInfo']").click();
                return;
            }

            //禁用按钮
            $("#savePsnBtn").attr("disabled","disabled");

            var personInfo =  $.extend(Tool.serialize("PersonBaseInfoForm"),Tool.serialize("PersonExtendInfoForm"));
            var data = {
                "PersonInfo":JSON.stringify(personInfo),
                "delDepts":JSON.stringify(Tool.jsonArrayIntersection(_Model.Depts.old,_Model.Depts._new,deptRule)),
                //取_new对old的差集，即_new中有而old中没有的部分
                "addDepts":JSON.stringify(Tool.jsonArrayIntersection(_Model.Depts._new,_Model.Depts.old,deptRule)),
                "delRoles":JSON.stringify(Tool.jsonArrayIntersection(_Model.Roles.old,_Model.Roles._new,roleRule)),
                "addRoles":JSON.stringify(Tool.jsonArrayIntersection(_Model.Roles._new,_Model.Roles.old,roleRule)),
                "delGws":JSON.stringify(Tool.jsonArrayIntersection(_Model.GWs.old,_Model.GWs._new,gwRule)),
                "userCert":JSON.stringify({
                    "userUuid":$("#userUuid").val(),
                    "locked":$("input[name='locked']:checked").val()
                })
            };
            //console.log(data);
            //return ;

            $.ajax({
                url:getServer()+"/sword/org/user/saveUser",
                dataType:"json",
                data:data,
                success:function(data){
                    if(data.status){
                        Grid.getGrid("OrgPersonList").refresh();
                        Slidebar.close();
                    }
                    Util.alert(data.message);
                    $("#savePsnBtn").removeAttr("disabled");
                }
            })
        });
    };

    var deptRule = function(one,two){
        return one.deptUuid==two.deptUuid?true:false;
    };

    /**
     * 添加部门
     */
    var addDeptBtnBind = function(){
        $("#addDeptBtn").bind("click",function(){

            if($("#deptUuid").val()){
                var dept = {
                    "deptUuid":$("#deptUuid").val(),
                    "deptName":$("#deptName").val(),
                    "deptCode":$("#deptCode").val(),
                    "ou":$("#ou").val(),
                    "jz":Number($("#jzFlag").val())             //Number($("input[name='jzFlag']:checked").val())
                };
                if(Tool.indexOfJsonArray(dept,_Model.Depts._new,deptRule)==-1){
                    _Model.Depts._new.push(dept);
                    //重新渲染部门表格
                    $("#PsnDeptList").empty().append(Util.template("T_PersonDept",{"Depts":_Model.Depts._new}));
                }else{
                    Util.alert("已存在相同的部门.");
                }
            }else{
                Util.alert("请选择部门.");
            }

        });
    };

    /**
     * 删除部门事件绑定
     */
    var delDeptBtnBind = function(){
        $("#PsnDeptList").bind("click",function(e){
            if(e.target.tagName.toLowerCase()=="i"){
                var $curTrTds = $(e.target.parentNode.parentNode).find("td");
                var index = Tool.indexOfJsonArray({"deptUuid":$($curTrTds[0]).text()},_Model.Depts._new,deptRule);
                _Model.Depts._new.splice(index,1);
                //重新渲染部门表格
                $("#PsnDeptList").empty().append(Util.template("T_PersonDept",{"Depts":_Model.Depts._new}));
            }
        });
    };

    var roleRule = function(one,two){
        return one.roleUuid==two.roleUuid?true:false;
    };

    /**
     * 添加角色事件绑定
     */
    var addRoleBtnBind = function(){
        OrgSelect.CS_OrgSelect({
            id : "user_addRoleBtn",
            multi : true,
            title : "角色选择",
            dataRefill:false,
            tagData : ["role"],
            callback : function(data){
                //console.log(data);
                data = data["role"];
                for(var i= 0,item;item=data[i++];){
                    if(Tool.indexOfJsonArray(item,_Model.Roles._new,roleRule)==-1){
                        _Model.Roles._new.push(item);
                    }
                }
                //重新渲染角色表格
                $("#PsnRoleList").empty().append(Util.template("T_PersonRoles",{"Roles":_Model.Roles._new}));
            }
        });
    };
    /**
     * 删除角色事件绑定
     */
    var delRoleBtnBind = function(){
        $("#PsnRoleList").bind("click",function(e){
            if(e.target.tagName.toLowerCase()=="i"){
                var $curTrTds = $(e.target.parentNode.parentNode).find("td");
                var index = Tool.indexOfJsonArray({"roleUuid":$($curTrTds[0]).text()},_Model.Roles._new,roleRule);
                if(index!=-1){
                    _Model.Roles._new.splice(index,1);
                    //重新渲染角色表格
                    $("#PsnRoleList").empty().append(Util.template("T_PersonRoles",{"Roles":_Model.Roles._new}));
                }
            }
        });
    };

    var gwRule = function(one,two){
        return (one.gwUuid==two.gwUuid&&one.deptCode==two.deptCode)?true:false;
    };

    /**
     * 删除岗位事件绑定
     */
    var delGwBtnBind = function(){
        $("#PsnGwList").bind("click",function(e){
            if(e.target.tagName.toLowerCase()=="i"){
                var $curTrTds = $(e.target.parentNode.parentNode).find("td");
                var index = Tool.indexOfJsonArray({
                    "gwUuid":$($curTrTds[0]).text(),
                    "deptCode":$($curTrTds[2]).text()
                },_Model.GWs._new,gwRule);
                if(index!=-1){
                    _Model.GWs._new.splice(index,1);
                    //重新渲染岗位表格
                    $("#PsnGwList").empty().append(Util.template("T_PersonGW",{"GWs":_Model.GWs._new}));
                }
            }
        });
    };


    return {
        showPersonList:showPersonList
    }
});

