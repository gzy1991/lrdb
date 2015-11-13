define([
    "PDUtilDir/util",
    "PDUtilDir/tool",
    "PDUtilDir/grid",
    "PDOrgDir/util"],function(Util,Tool,Grid,OrgUtil){

    var Slidebar = null;

    /*****************岗位相关**************/
    //岗位导入
    var importGW = function(){
        var mapping = {
            "ServiceName":"org/gw/importGw",
            "EntityClassName":"com.css.sword.common.org.entity.OrgGw",
            "岗位名称":"gwName","岗位编号":"gwCode","显示序号":"sort"
        };
        OrgUtil.importExcel({
            "title":"岗位导入",
            "templeteURL":OrgUtil.sysPath+"/org/views/importGW.html",
            "mapping":mapping,
            "importSuccess":function(){
                Grid.getGrid("OrgGWList").refresh();
            },
            "callback":function(){
                $("#downloadGwExcel").attr("href",getServer()+"/static/core/system/org/importTemplete/岗位导入.xlsx")
            }
        });
    };
    //新增岗位
    var addGW = function(){
        showGWSidebar({
            afterLoad:function(){
                //保存事件绑定
                saveOrgGWBtnBind();
                //表单验证
                validateGw({
                    rules:{
                        gwCode:{
                            required:true,
                            PD_ZSDX:true,
                            maxlength:32,
                            remote:{
                                type:"POST",                                        //请求方式
                                url: getServer()+"/sword/org/gw/validateGwCode",    //请求的服务
                                data:{                                              //要传递的参数
                                    gwCode:function(){return $("#gwCode").val();}
                                }
                            }
                        }
                    },
                    messages: {
                        gwCode:{
                            remote:"岗位编号已存在,请重新输入"
                        }
                    }
                });
            }
        });
    };
    //编辑岗位
    var editGW = function(GWUuid){
        $.ajax({
            //url:sysPath+"/org/data/GW.json",
            url:getServer()+"/sword/org/gw/getGwByUuid",
            dataType:"json",
            data:{"gwUuid":GWUuid},
            success:function(data){
                showGWSidebar({
                    afterLoad:function(){
                        $("#org_GWName").html(data.gwName);
                        Tool.deserialize("GWForm",data);
                        //保存按钮绑定事件
                        saveOrgGWBtnBind();
                        //编辑时，角色编号字段不可编辑
                        $("#gwCode").attr("readonly",true);
                        //表单验证
                        validateGw();
                    }
                });
            }
        });
    };

    var validateGw = function(extend){
        //数据验证
        $("#GWForm").validate($.extend(true,{
            rules:{
                gwName:{required:true,maxlength:50},
                sort:{digits:true,maxlength:8}
            }
        },extend));
    };

    /**
     * 岗位保存
     */
    var saveOrgGWBtnBind = function(){
        $("#saveOrgGWBtn").bind("click",function(){
            if($("#GWForm").valid()){
                var entity = Tool.serialize("GWForm");
                $.ajax({
                    url:getServer()+"/sword/org/gw/saveGw",
                    dataType:"json",
                    data:entity,
                    success:function(data){
                        if(data.status){
                            //刷新表格
                            Grid.getGrid("OrgGWList").refresh();
                            Slidebar.close();
                        }
                        Util.alert(data.message);
                    }
                })
            }
        })
    };

    //弹出岗位侧边栏
    var showGWSidebar = function(param){
        Slidebar = Util.slidebar($.extend({
            url:getStaticPath()+"/core/system/org/views/orgGW.html",
            //id:"EditGWPanel",
            cache:false,
            close:true,
            width:"500px"
        },param));
    };

    /**
     * 显示岗位列表
     */
    var showGWList = function(){
        var config = {
            id: "OrgGWList",
            realSort:true,
            toolbar:[
                {name:"新增岗位",icon:"fa fa-plus-circle",callback:addGW},
                {name:"删除岗位",icon:"fa fa-trash-o",callback:delGW},
                {name:"岗位导入",icon:"fa fa-upload",callback:importGW}
            ],
            layout: [
                {
                    name: "岗位编号", field: "gwCode",sort:true, click: function (e) {
                    editGW(e.data.row.gwUuid);
                }
                },
                {name: "岗位名称", field: "gwName",sort:true},
                {name: "序号", field: "sort",sort:true}
            ],
            multi:true,
            data: {
                "type": "URL",
                "value": getServer() + "/sword/org/gw/getAllGwForGrid"
            }
        };
        Grid($.extend(config,OrgUtil.gridDefaultConfig));
    };

    /**
     * 删除岗位
     */
    var delGW = function(){
        var grid = Grid.getGrid("OrgGWList");
        var data = grid.getSelectedRow();
        if(!data.length){
            Util.alert("请选择要删除的岗位.");
            return false;
        }
        Util.confirm("是否要删除所选岗位?",function(){
            $.ajax({
                url:getServer()+"/sword/org/gw/delGW",
                type:"post",
                dateType:"json",
                data:{
                    "OrgGw":data
                },
                success:function(data){
                    if(data.status){
                        grid.refresh();
                    }
                    Util.alert(data.message)
                }
            })
        });
    };

    return {
        showGWList:showGWList
    }
});