/**
 * Created by YiYing on 2015/6/14.
 */
define(["PDUtilDir/util","PDUtilDir/tool","PDUtilDir/grid","PDOrgDir/util"],function(Util,Tool,Grid,OrgUtil){

    /**
     * 日志列表显示
     */
    var showOrgLogList = function(){
        var config = {
            id: "OrgLogList",
            realSort:true,
            multi:true,
            toolbar:[
                {name:"删除日志",icon:"fa fa-trash-o",callback:delLog}
            ],
            layout: [
                {name: "操作信息", field: "operateInfo",sort:true, click: function (e) {
                        editLog(e.data.row.uuid);
                    }
                },
                {name: "创建时间", field: "createDate",sort:true},
                {name: "操作人", field: "userName"}
            ],
            data: {
                "type": "URL",
                "value": getServer() +"/sword/org/log/getAllLogForGrid"
            }
        };
        Grid.init($.extend(config,OrgUtil.gridDefaultConfig));
    };

    var editLog = function(uuid){
        $.ajax({
            url:getServer()+"/sword/org/log/getLogByUuid",
            dataType:"json",
            data:{"uuid":uuid},
            success:function(data){
                showLogSidebar({
                    afterLoad:function(){
                        Tool.deserialize("LogForm",data);
                        $("#logInfo").html(data.logInfo);
                    }
                });
            }
        });
    };

    //弹出日志侧边栏
    var showLogSidebar = function(param){
        Util.slidebar($.extend({
            url:getStaticPath()+"/core/system/org/views/orgLog.html",
            cache:false,
            close:true,
            width:"500px"
        },param));
    };


    /**
     * 删除日志
     */
    var delLog = function(){
        var grid = Grid.getGrid("OrgLogList");
        var data = grid.getSelectedRow();
        if(!data.length){
            Util.alert("请选择要删除的日志.");
            return false;
        }
        $.ajax({
            url:getServer()+"/sword/org/log/delLog",
            type:"post",
            dateType:"json",
            data:{
                "OrgLog":data
            },
            success:function(data){
                if(data.status){
                    grid.refresh();
                }
                Util.alert("删除成功.")
            }
        })

    };

    return {
        showOrgLogList:showOrgLogList,
        delLog:delLog
    }
});