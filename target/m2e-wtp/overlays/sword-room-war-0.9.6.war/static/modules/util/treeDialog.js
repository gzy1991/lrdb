/**
 * Created by Henry on 15-6-3.
 */
define(["jquery","PDUtilDir/dialog","ZTree","css!ZTreeCss","css!PDUtilDir/css/treeDialog.css"],function($,Dialog){
    var cache = {};

    function init(config){
        var treeDialog = new TreeDialog(config);
        cache[config.id] = treeDialog;
        return treeDialog;
    }

    init.get = function(id){
        return cache[id]||{};
    };

    init.drop = function(id){
      if(!id){
          cache = {};
      }else{
          var obj = cache[id];
          obj?delete cache[id]:false;
          return obj||{};
      }
    };

    function TreeDialog(config){
        this.config = $.extend({
            data : [],
            setting : {
                check : {
                    enable : config.multi,
                    chkboxType : {"Y":"","N":""}
                }
            },
            width:"300px",
            height:"320px"
        },config);
        this.initDialog();
        this.initTree();
        this.bindEvent();
    }

    TreeDialog.prototype = {
        initDialog : function(){
            var _this = this,
                template = '<div class="tree-dialog">'+
                    (this.config.searchAble?'<input type="text" class="tree-search form-control" style="width:'+(parseInt(this.config.width)-30)+'px">':'')+
                    '<ul id="tree_'+this.config.id+'" class="ztree">'+
                    '</div>';
            var dialog = Dialog({
                id:"treeDialog_"+this.config.id,
                cache:true,
                title:"数据选择",
                width:this.config.width,
                height:this.config.height,
                zIndex:1100,
                modal:"hide",              //modal-lg或modal-sm
                body:template,
                buttons:[{
                    name : "确定",
                    close : true,
                    callback : function(){
                        var result=_this.config.multi?_this._treeObj.getCheckedNodes():_this._treeObj.getSelectedNodes();
                        _this.config.callback?_this.config.callback(result):null;
                    }
                }]
            });
            dialog.$getDialog().on('hidden.bs.modal', function (e) {
                _this.clear();
            });//.find(".modal-body").css("position","static");
            this._dialog = dialog;
        },
        initTree : function(){
            if(!this.$ztree||!this.$ztree.length){
                this.$ztree = this._dialog.$getDialog().find("#tree_"+this.config.id);
                this.$search = this._dialog.$getDialog().find(".tree-search");
            }
            $.fn.zTree.destroy("tree_"+this.config.id);
            if(typeof this.config.data!=="string"){
                this._treeObj = $.fn.zTree.init(this.$ztree,this.config.setting,this.config.data);
            }else{
                var _this = this;
                $.ajax({
                    url : this.config.data,
                    type : "POST",
                    dataType : "json",
                    success : function(data){
                        _this._treeObj = $.fn.zTree.init(_this.$ztree,_this.config.setting,data);
                    }
                });
            }
        },
        bindEvent : function(){
            var _this = this;
            //数据搜索事件
            if(!!this.config.searchAble){
                var trigger=null,
                    lastContent=null,
                    status=true;
                this.$search.on("keyup",function(event){
                    if($.trim($(this).val())==lastContent){return false;}
                    lastContent=$.trim($(this).val());
                    if(trigger){window.clearTimeout(trigger);}
                    trigger=window.setTimeout(function(){
                        trigger=null;
                        clearAllNodesVisibleStatus(_this.$ztree);
                        if(!lastContent){
                            status = true;
                            setTreeVisibleStatus(_this.$ztree,status);
                        }else{
                            status = false;
                            setTreeVisibleStatus(_this.$ztree,status);
                            _this.searchPanelData(lastContent);
                        }
                    },400);
                });
            }
        },
        searchPanelData : function (content) {
            var nodes = this._treeObj.getNodesByParamFuzzy(this.config.key.name,content);
            for(var i= 0,length = nodes?nodes.length:0;i<length;i++){
                expandParentNodes(this._treeObj,nodes[i],true);
            }
        },
        clear : function(){
            this.$search?this.$search.val(""):false;
        }
    };

    TreeDialog.prototype.init = function(config){
        if(config){
            this.config = $.extend(true,this.config,config);
        }
        if(this.config.realTimeData){
            this.initTree();
        }else{
            resetZTreeStatus(this.$ztree.attr("id"));
        }
        this._dialog.show();
    };

    function resetZTreeStatus(treeId){
        var treeObj = $.fn.zTree.getZTreeObj(treeId),
            $tree = $("#"+treeId),
            $nodes = $tree.children(),nodes;
        if (!treeObj) { return false;}
        setTreeVisibleStatus($tree,true);
        clearAllNodesVisibleStatus($tree);
        treeObj.expandAll(false);       //闭合所有节点
        treeObj.cancelSelectedNode();       //取消所有selected状态
        if ($nodes.length==1) {
            treeObj.expandNode(treeObj.getNodeByTId($nodes.first().attr("id")),true);
        }
        nodes = treeObj.getCheckedNodes();      //获取所有checked状态nodes
        for(var i= 0,length = nodes.length;i<length;i++){
            expandParentNodes(treeObj,nodes[i]); //展开checked状态node的父节点
        }
    }

    function expandParentNodes(treeObj,node,status){
        var $tree = $("#"+treeObj.setting.treeId);
        status?setNodeVisibleStatus($tree.find("#"+node.tId)):false;
        var parentNode = node.getParentNode();
        if(parentNode){
            treeObj.expandNode(parentNode,true);
            expandParentNodes(treeObj,parentNode,status);
        }
    }

    function setTreeVisibleStatus($tree,status){
        if((status&&$tree.is(".hideNode"))||(!status&&!$tree.is(".hideNode"))){
            $tree.toggleClass("hideNode");
        }
    }

    function clearAllNodesVisibleStatus($tree){
        $tree.find(".showNode").removeClass("showNode");
    }

    function setNodeVisibleStatus($node){
        if(!$node.is(".showNode")){
            $node.addClass("showNode");
        }
    }

    return init;
});