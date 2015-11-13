/**
 * Created by zhanglei on 2015-9-23.
 */
define(['jquery','PDUtilDir/grid','PDUtilDir/util','PDUtilDir/menu','ZTree','css!ZTreeCss'],
    function($,Grid,Util,Menu){
        var resultTree = {};
        var localTree = $.fn.zTree;
        var _$scope;
        var _treeId;
        var _treeNode;
        var _rootId;
        resultTree.CreateTree = function(zNodes,id,$scope){
            var setting = {
                callback : {
                    beforeRightClick: RightKey,
                    onClick : initColumnEdit
                },
                data: {
                    simpleData: {
                        enable: true,
                        idKey: "columntreePertreeId",
                        pIdKey: "columntreePpertreeId",
                        rootPId: "root"
                    },
                    key:{
                        name :"columntreeName"
                    }
                }
            };
            localTree.init($("#"+id), setting,zNodes);
            _$scope = $scope;
            _rootId = id;
            $('#'+_rootId).bind('contextmenu',function(e){
                return false;
            });
        };

        var initColumnEdit = function(event, treeId, treeNode){
            _treeNode=treeNode;
            _$scope.periodical.entity.languageCN = treeNode.columntreeName;
            _$scope.periodical.entity.languageEN = treeNode.columntreeNameEn;
            _$scope.$digest();
        };

        var RightKey = function(treeId, treeNode){

            rightKeyFrame(event,treeId, treeNode);
            localTree.getZTreeObj(_rootId).selectNode(treeNode);
        };
        //更新栏目
        resultTree.updataColumn = function(val,language){
            if(_rootId !== '' && _treeNode != null){
                var treeObj = $.fn.zTree.getZTreeObj(_rootId);
                if(language==='CN')
                {
                    _treeNode.columntreeName = val;
                }else if(language==='EN'){
                    _treeNode.columntreeNameEn = val;
                }
                treeObj.updateNode(_treeNode);
            }
        };

        //删除节点
        var removeNode = function(){
            Util.confirm("您确定删除吗？", function() {
                var treeObj = localTree.getZTreeObj(_rootId);
                treeObj.removeNode(_treeNode);
            }, function() {

            });

        };

        var uuid = function() {
            var s = [];
            var hexDigits = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
            for (var i = 0; i < 40; i++) {
                s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
            }
            var uuid = s.join("");
            return uuid;
        };

        //右键弹窗口
        var rightKeyFrame = function(evt,treeId, treeNode){
            //document.getElementById('commonTree').oncontextmenu = function(e){
            //    return false;
            //};
            var menu;
            if (!menu) {
                menu = Menu({
                    items : [{
                        id : "plus",
                        name : "添加",
                        icon : "fa fa-plus",
                        callback : function() {
                            var newNodes = {"columntreePertreeId":uuid(), "columntreePpertreeId":_treeNode.columntreePertreeId, "columntreeName":"新增","columntreeNameEn":"new add"};
                            localTree.getZTreeObj(_rootId).addNodes(localTree.getZTreeObj(_rootId).getSelectedNodes()[0], newNodes);
                        }
                    }, {
                        id : "minus",
                        name : "删除",
                        icon : "fa fa-minus",
                        callback : function() {
                            removeNode();
                        }
                    }]
                });
                menu.show({
                    left : evt.pageX,
                    top : evt.pageY
                });
                _treeId = treeId;
                _treeNode = treeNode;
            } else {
                menu.show({
                    left : evt.pageX,
                    top : evt.pageY
                });
                _treeId = treeId;
                _treeNode = treeNode;
            }
        };
        return resultTree;
    }
);