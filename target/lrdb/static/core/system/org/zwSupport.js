define([
    "PDUtilDir/util",
    "PDUtilDir/tool",
    "PDUtilDir/grid",
    "PDOrgDir/util"],function(Util,Tool,Grid,OrgUtil){

    var Slidebar = null;

    /*****************职务相关**************/
    //职务导入
    var importZW = function(){
        var mapping = {
            "ServiceName":"org/zw/importZw",
            "EntityClassName":"com.css.sword.common.org.entity.OrgZw",
            "职务名称":"zwName","职务编号":"zwCode","显示序号":"sort"
        };
        OrgUtil.importExcel({
            "title":"职务导入",
            "templeteURL":OrgUtil.sysPath+"/org/views/importZW.html",
            "mapping":mapping,
            "importSuccess":function(){
                Grid.getGrid("OrgZWList").refresh();
            },
            "callback":function(){
                $("#downloadZwExcel").attr("href",getServer()+"/static/core/system/org/importTemplete/职务导入.xlsx");
            }
        });
    };
    //新增职务
    var addZW = function(){
        showZWSidebar({
            afterLoad:function(){
                //保存事件绑定
                saveOrgZWBtnBind();
                //表单验证
                validateZw({
                    rules:{
                        zwCode:{
                            required:true,
                            maxlength:32,
                            PD_ZSDX:true,
                            remote:{
                                type:"POST",                                        //请求方式
                                url: getServer()+"/sword/org/zw/validateZwCode",           //请求的服务
                                data:{                                              //要传递的参数
                                    zwCode:function(){return $("#zwCode").val();}
                                }
                            }
                        }
                    },
                    messages: {
                        zwCode:{
                            remote:"职务编号已存在,请重新输入"
                        }
                    }
                });
            }
        });
    };
    //编辑职务
    var editZW = function(zwUuid){
        $.ajax({
            //url:sysPath+"/org/data/ZW.json",
            url:getServer()+"/sword/org/zw/getZwByUuid",
            dataType:"json",
            data:{"zwUuid":zwUuid},
            success:function(data){
                showZWSidebar({
                    afterLoad:function(){
                        $("#org_ZWName").html(data.zwName);
                        Tool.deserialize("ZWForm",data);
                        //保存按钮绑定事件
                        saveOrgZWBtnBind();
                        //编辑时，角色编号字段不可编辑
                        $("#zwCode").attr("readonly",true);
                        //表单验证
                        validateZw();
                    }
                });
            }
        });
    };

    var validateZw = function(extend){
        //数据验证
        $("#ZWForm").validate($.extend(true,{
            rules:{
                zwName:{required:true,maxlength:50},
                sort:{digits:true,maxlength:8}
            }
        },extend));
    };

    /**
     * 职务保存
     */
    var saveOrgZWBtnBind = function(){
        $("#saveOrgZWBtn").bind("click",function(){
            if($("#ZWForm").valid()){
                var entity = Tool.serialize("ZWForm");
                $.ajax({
                    url:getServer()+"/sword/org/zw/saveZW",
                    dataType:"json",
                    data:entity,
                    success:function(data){
                        if(data.status){
                            //刷新表格
                            Grid.getGrid("OrgZWList").refresh();
                            Slidebar.close();
                        }
                        Util.alert(data.message);
                    }
                })
            }
        })
    };

    //弹出职务侧边栏
    var showZWSidebar = function(param){
        Slidebar = Util.slidebar($.extend({
            url:getStaticPath()+"/core/system/org/views/orgZW.html",
            //id:"EditZWPanel",
            cache:false,
            close:true,
            width:"500px"
        },param));
    };

    /**
     * 显示职务列表
     */
    var showZWList = function(){
        var config = {
            id: "OrgZWList",
            realSort:true,
            toolbar:[
                {name:"新增职务",icon:"fa fa-plus-circle",callback:addZW},
                {name:"删除职务",icon:"fa fa-trash-o",callback:delZW},
                {name:"职务导入",icon:"fa fa-upload",callback:importZW}
            ],
            layout: [
                {
                    name: "职务编号", field: "zwCode",sort:true, click: function (e) {
                    //console.log(e.data);
                    editZW(e.data.row.zwUuid);
                }
                },
                {name: "职务名称", field: "zwName",sort:true},
                {name: "序号", field: "sort",sort:true}
            ],
            multi:true,
            data: {
                "type": "URL",
                "value": getServer() + "/sword/org/zw/getAllZwForGrid"
            }
        };
        Grid.init($.extend(config,OrgUtil.gridDefaultConfig));
    };

    /**
     * 删除职务
     */
    var delZW = function(){
        var grid = Grid.getGrid("OrgZWList");
        var data = grid.getSelectedRow();
        if(!data.length){
            Util.alert("请选择要删除的职务.");
            return false;
        }
        Util.confirm("是否要删除所选职务?",function(){
            $.ajax({
                url:getServer()+"/sword/org/zw/delZW",
                type:"post",
                dateType:"json",
                data:{
                    "OrgZw":data
                },
                success:function(data){
                    if(data.status){
                        grid.refresh();
                    }
                    Util.alert("删除成功.")
                }
            })
        });
    };

    return {
        showZWList:showZWList
    }
});