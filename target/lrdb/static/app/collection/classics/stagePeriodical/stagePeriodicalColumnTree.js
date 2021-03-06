/**
 * Created by zhanglei on 2015-9-23.
 */
    define(['jquery','PDUtilDir/grid','PDUtilDir/util','PDUtilDir/menu', 'PDUtilDir/dialog','LrdbCommonDir/dict','ZTree','css!ZTreeCss'],
    function($,Grid,Util,Menu, Dialog, Dict){
        var resultTree = {};
        var localTree = $.fn.zTree;
        var _$scope;
        var _$complie;
        var _treeId;
        var _treeNode;
        var _rootId;
        var CreateTree = function(zNodes,id,$scope,$compile,settings){
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
            setting.data.key.name = settings.data.key.name;
            //setting = $.extend(setting,settings);
            localTree.init($("#"+id), setting,zNodes);
            _$scope = $scope;
            _rootId = id;
            _$complie = $compile;
            $('#'+_rootId).bind('contextmenu',function(e){
                return false;
            });
        };

        var initColumnEdit = function(event, treeId, treeNode){
            _treeNode=treeNode;
            _$scope.stagePeriodical.entity.languageCN = treeNode.name;
            _$scope.stagePeriodical.entity.languageEN = treeNode.nameEn;
            _$scope.$digest();
        };

        var RightKey = function(treeId, treeNode){
            _rootId = treeId;
            rightKeyFrame(event,treeId, treeNode);
            localTree.getZTreeObj(_rootId).selectNode(treeNode);
        };

        //移动节点
        var moveNode = function(type){
            var treeObj = localTree.getZTreeObj(_rootId);
            if(type === 'prev' && _treeNode.getPreNode()){
                treeObj.moveNode(_treeNode.getPreNode(),_treeNode,type);
            }else if(type === 'next' && _treeNode.getNextNode()){
                treeObj.moveNode(_treeNode.getNextNode(),_treeNode,type);
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

        var editTree = function($compile,$scope){
            var dialog = Dialog({
                id : 'persionRelEditDialog' ,
                title: '期刊栏目编辑'	,
                drag : true,
                $compile : $compile,
                $scope : $scope,
                url : getServer() +'/static/app/collection/classics/stagePeriodical/views/treeEdit.html',
                //modal:{backdrop:'static'},//则点击空白不自动关闭
                buttons:[
                    {
                        name:'确定',
                        callback:function(dialog){
                            //$scope.stagePeriodical.entity.languageCN = '';
                            //$scope.stagePeriodical.entity.languageEN = '';
                            updataColumn($scope.stagePeriodical.entity.languageCN,$scope.stagePeriodical.entity.languageEN);
                            dialog.hide();
                        }
                    }
                ],
                afterLoad:function(){
                    if(_rootId !== '' && _treeNode != null){
                        var treeObj = $.fn.zTree.getZTreeObj(_rootId);
                        $scope.stagePeriodical.entity.languageCN = _treeNode.columntreeName;
                        $scope.stagePeriodical.entity.languageEN = _treeNode.columntreeNameCn;
                        $scope.$digest();
                    }
                }
            });
            dialog.show();
        };

        //更新栏目
        var updataColumn = function(valCn,valEn){
            if(_rootId !== '' && _treeNode != null){
                var treeObj = $.fn.zTree.getZTreeObj(_rootId);
                _treeNode.columntreeName = valCn;
                _treeNode.columntreeNameCn = valEn;
                treeObj.updateNode(_treeNode);
            }
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
        //初始化栏目树
        resultTree.createTreeInit = function($compile, $scope){
            if($scope.stagePeriodical.entity === null)
            return false;
            var url;
            var stagePeriodicalId = $scope.stagePeriodical.entity.stagePeriodicalId;
            if(stagePeriodicalId != '' && stagePeriodicalId != undefined){ //编辑
                url = Dict.URL_QUERYSTAGEPERIODICALCOLUMNTREEBYID_SERIVCE;
                $.post(url,'stagePeriodicalId='+stagePeriodicalId,'','json').done(function(data){
                    CreateTree(data.model.curPageData, 'commonTreeCN', $scope, $compile, {data: {key: {name: "columntreeName"}}});
                    CreateTree(data.model.curPageData, 'commonTreeEN', $scope, $compile, {data: {key: {name: "columntreeNameEn"}}});
                });
            }else{  //新增
                var periodicalId = $scope.stagePeriodical.entity.periodicalId;
                url = Dict.URl_QUERYPERIODICALCOLUMNTREEBYID_SERVICE;
                if(periodicalId != '' && periodicalId != undefined){
                    $.post(url,'periodicalId='+periodicalId,'','json').done(function(data){
                        CreateTree(data.model.curPageData, 'commonTreeCN', $scope, $compile, {data: {key: {name: "columntreeName"}}});
                        CreateTree(data.model.curPageData, 'commonTreeEN', $scope, $compile, {data: {key: {name: "columntreeNameEn"}}});
                    });
                }
            }
        };
        //右键弹窗口
        var rightKeyFrame = function(evt,treeId, treeNode){
            var menu;
            if (!menu) {
                menu = Menu({
                    items : [ {
                        id : "plus",
                        name : "添加",
                        icon : "fa fa-plus",
                        callback : function() {
                            var newNodes = {"columntreePertreeId":uuid(), "columntreePpertreeId":_treeNode.columntreePertreeId, "columntreeName":"新增","columntreeNameEn":"new add"};
                            localTree.getZTreeObj(_rootId).addNodes(localTree.getZTreeObj(_rootId).getSelectedNodes()[0], newNodes);
                        }
                    }, {
                        id : "pencil",
                        name : "编辑",
                        icon : "fa fa-pencil",
                        callback : function() {
                            editTree(_$complie,_$scope);
                        }
                    }, {
                        id : "trash",
                        name : "删除",
                        icon : "fa fa-trash",
                        callback : function() {
                            removeNode();
                        }
                    }, {
                        id : "up",
                        name : "上移",
                        icon : "fa fa-angle-double-up",
                        callback : function() {
                            moveNode('prev')
                        }
                    }, {
                        id : "down",
                        name : "下移",
                        icon : "fa fa-angle-double-down",
                        callback : function() {
                            moveNode('next')
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