/**
 * Created by YiYing on 2015/3/25.
 */
define(["PDUtilDir/util"],function(Util){

    /**
     * Excel导入前端公共接口
     * @param param
     */
    var importExcel = function(param){
        require(["PDUtilDir/dialog",
                "WebUploader",
                "text!"+param.templeteURL,
                "css!WebUploaderCss"
            ],
            function(Dialog,WebUploader,body){
                var dialog = Dialog({
                    id:"system_importExcelDialog",
                    title:param.title,
                    cache:false,
                    body:body
                });

                if ( !WebUploader.Uploader.support() ) {
                    alert( 'Flash版本过低，请尝试升级 flash 版本到11.4以上.');
                    throw new Error( 'WebUploader does not support the browser you are using.' );
                    return false;
                }

                //附件上传控件初始化
                var uploader = WebUploader.create({
                    swf:getStaticPath()+'/modules/webuploader/Uploader.swf',
                    server: getServer()+"/sword/"+param.mapping.ServiceName,
                    accept: {
                        title: 'excel',
                        extensions: 'xls,xlsx'
                    },
                    pick:{
                        id:'#ImportExcelPanel',
                        label: '<i class="glyphicon glyphicon-paperclip"></i>&nbsp;请选择Excel',
                        multiple:false
                    }
                });
                //设置上传按钮
                dialog.setFoot([{name:"开始上传",callback:function(){
                    uploader.upload();
                }}]);
                //设置样式，必须uploader初始化后才能设置
                var panel = $("#ImportExcelPanel");
                panel.children(":first").css({
                    "width": "100px",
                    "height": "25px",
                    "padding": "3px"
                });
                panel.children(":last").css({"background": "#00b7ee"});
                panel.find("label").hover(function() {
                    panel.children(":last").css({"background": "#00b7ee"});
                }, function() {
                    panel.children(":last").css({"background": "#00a2d4"});
                });
                //IE8、9兼容
                if(/msie [89]/.test(navigator.userAgent.toLowerCase())){
                    $("#ImportExcelPanel div:first").css("background-color","#00B7EE");
                    $("#ImportExcelPanel div:last").css("background-color","");
                }

                //把附件增加到待上传列表中
                uploader.on( 'fileQueued', function(file) {
                    $("#importExcelInfo").show();
                    $("#importExcelFileName").html(file.name);
                });
                //附件上传数据发送之前触发
                uploader.on( 'uploadBeforeSend', function(object,data,headers) {
                    data["formData"] = encodeURI(JSON.stringify(param.mapping));
                    data["SwordControllerName"] = "ExcelImportController";
                    $("#importExcelStatus").html("开始导入，请耐心等待...");
                });
                //附件上传成功后触发
                uploader.on( 'uploadSuccess', function( file,res ) {
                    //隐藏上传按钮
                    $("#ImportExcelPanel").hide();
                    if(typeof (res)=="object"){
                        $("#importExcelStatus").html("导入失败");
                        $("#importExcelErrorInfo").html("<code>服务器端异常，请查看错误日志</code>");
                    }else{
                        var response = JSON.parse(res);
                        if(response.status){
                            $("#importExcelStatus").html("导入完成");
                            $("#importExcelErrorInfo").html("<code>"+decodeURI(response.message)+"</code>");
                        }else{
                            $("#importExcelStatus").html("导入失败");
                        }
                    }
                    typeof(param.importSuccess)=="function" && param.importSuccess();
                });

                typeof(param.callback)=="function" && param.callback();
            }
        );
    };

    /**
     * 设置指定面板中的数据（废弃）
     * @param id
     * @param data
     */
    /*var setNgModel = function(id,data){
        //得到指定id面板中所有需要绑定的文本框对象
        $("#"+id+" input[type='text'][ng-model]").each(function(index){
            var arr = $(this).attr("ng-model").split(".");
            var temp=data;
            for(var i= 0,item;item=arr[i++];){
                temp = temp[item];
            }
            $(this).val(temp);
        });
    };*/

    /**
     * 获取数据 (废弃)
     * @param id
     */
    /*var getNgModel = function(id){
        var obj = {};
        $("#"+id+" input[type='text'][ng-model]").each(function(index){
            var arr = $(this).attr("ng-model").split(".");
            obj[arr[arr.length-1]] = $(this).val();
        });
        return obj;
    };*/

    /**
     * 取得选择的树节点id
     * @param id
     * @returns {*}
     */
    var getSelectTreeNodeId = function(id){
        var nodes = $.fn.zTree.getZTreeObj(id).getSelectedNodes();
        return nodes.length?nodes[0].id : false
    };
    var getSelectTreeNodeName = function(id){
        var nodes = $.fn.zTree.getZTreeObj(id).getSelectedNodes();
        return nodes.length?nodes[0].name : false
    };

    //数据列表公共部分
    var gridDefaultConfig = {
        placeAt:"orgShowListContent",        //存放Grid的容器ID
        pageSize:10                          //一页多少条数据
    };


    /**
     * 下拉选择角色分类初始化
     */
    var selectRoleDirInit = function(param){
        require(["PDUtilDir/inputSelect"],function(InputSelect){
            $.ajax({
                "url": getServer()+"/sword/org/roledir/getAllRoleDir",
                "type": "post",
                "dataType": "json",
                "success": function(data){
                    var inputSelect = InputSelect({
                        id: param.id,
                        multi: false,
                        initData:param.initData,
                        data: data,
                        key : {
                            id : "dirCode",
                            name : "dirName",
                            pid : "pDirCode",
                            rootId : "root"
                        },
                        simpleData: true,
                        searchAble : true,
                        callback : function(data) {
                            param.callback(data);
                        }
                    });
                    //过滤掉指定节点(包含子节点)
                    if(param.ignoreNodeId){
                        var tree = inputSelect.getTreeObj();
                        tree.removeNode(tree.getNodesByParam("dirCode",param.ignoreNodeId)[0])
                    }
                }
            });
        });
    };

    /**
     * 暂未使用
     * 忽略树指定节点（包括该节点的子节点）
     * @param param
     * {
        data:[],
        ignoreNodeId:'',
        key:{
            id:"",
            pid:""
        }
     }
     */
    /*var ignoreTreeNode = function(param){
        //默认配置项
        var config = $.extend({
            data:[],
            ignoreNodeId:'',
            key:{
                id:"id",
                pid:"pid"
            }
        },param);
        var temp = [];
        for(var i= 0,item;item=config.data[i++];){
            if(item[config.key.id] == config.ignoreNodeId){
                continue;
            }
            temp.push(item);
        }
        return temp;
    };*/

    return {
        sysPath:"static/core/system",
        gridDefaultConfig:gridDefaultConfig,
        importExcel:importExcel,
        //setNgModel:setNgModel,
        //getNgModel:getNgModel,
        getSelectTreeNodeId:getSelectTreeNodeId,
        getSelectTreeNodeName:getSelectTreeNodeName,
        selectRoleDirInit:selectRoleDirInit
    }
});