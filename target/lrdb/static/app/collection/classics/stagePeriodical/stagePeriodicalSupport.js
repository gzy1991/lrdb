/**
 * @author zhanglei@css.com.cn
 */
define(['jquery', 'PDUtilDir/grid', 'PDUtilDir/util', 'LrdbCommonDir/dict', 'LrdbStagePeriodicalDir/stagePeriodicalColumnTree', 'LrdbStagePeriodicalDir/periodicalSelectSupport', 'LrdbStagePeriodicalDir/articleSupport', 'LrdbCommonDir/uploader/multi-uploader', 'LrdbCommonDir/record/record'],
    function ($, Grid, Util, Dict, stagePerTree, periodicalSelectSupport, articleSupport, Multiuploader, Record) {
        var result = {};
        var gridInstance;
        var gridInit = function ($compile, $scope) {
            var config = {
                id: 'stagePeriodicalGridId',
                placeAt: 'stagePeriodicalList',
                pageSize: 10,
                multi: true,
                pagination: true,
                cache: false,
                layout: [{
                    name: '期刊名称', field: 'stagePeriodicalName', width: '20%', click: function (e) {
                        showSlidebar($compile, $scope, 'edit', e.data.row.stagePeriodicalId);
                    }
                },
                    {name: '期刊类别', field: 'typeDict', width: '8%'},
                    {name: '刊发日期', field: 'stagePeriodicalPublishDate', width: '8%'},
                    {name: '期数', field: 'stagePeriodicalStage', width: '15%'},
                    {name: '采集人员', field: 'createUser', width: '8%'},
                    {name: '操作人员', field: 'lastmodifyUser', width: '8%'},
                    {name: '操作时间', field: 'lastmodifyTime', width: '10%'}
                ],
                toolbar: [
                    {
                        name: '添加', icon: 'fa fa-plus-circle', callback: function () {
                        showSlidebar($compile, $scope,'add','');
                    }
                    },
                    {
                        name: '删除', icon: 'fa fa-trash-o', callback: function () {
                        delStagePeriodical($compile,$scope);
                    }
                    },
                    {
                        name: '跟踪', icon: 'fa fa-bar-chart', callback: function () {
                        Record.instance({$scope: $scope, $compile: $compile, objectId: '', model: 's'})
                    }
                    },
                    {
                        name: '查询', icon: 'fa fa-search', callback: function () {
                        $scope.stagePeriodical.query.query();
                    }
                    },
                    {
                        name: '重置', icon: 'fa fa-repeat', callback: function () {
                        $scope.stagePeriodical.query.reset();
                        gridInit($compile, $scope);
                    }
                    }],
                data: {
                    type: 'URL',
                    value: Dict.URL_QUERYSTAGEPERIODICALINFOLIST_SERIVCE
                },
                queryParam: {
                    stagePerName : $scope.stagePeriodical.query.conditions.queryStaPerName, //期刊名称
                    stagePerStage : $scope.stagePeriodical.query.conditions.queryStaPerStage, //期数
                    stagePerYear : $scope.stagePeriodical.query.conditions.queryStaPerPerYear, //年份
                    perType : $scope.stagePeriodical.query.conditions.queryPerType
                },
                trEvent: []
            };
            gridInstance = Grid.init(config);
        };

        //树列表
        var treeGridInit = function ($compile, $scope) {
            var config = {
                id: 'stagePeriodicalColumnGridId',
                placeAt: 'stagePeriodicalColumnList',
                pageSize: 10,
                multi : true,
                cache: false,
                layout: [{name: '文章名称', field: 'perArticle', width: '80%', click: function () {
                    openArticleSlidebar($compile, $scope, 'edit');}}
                   ],
                toolbar: [{
                    name: '添加', icon: 'fa fa-plus-circle', callback: function () {
                        openArticleSlidebar($compile, $scope,'add');
                    }},
                    {
                    name: '删除', icon: 'fa fa-trash-o', callback: function () {
                        Util.alert('删除成功！');
                    }
                }],
                data: {
                    type: 'URL',
                    value: ''
                },
                format: {},
                trEvent: []
            };
            Grid(config);
        };

        //期刊资源附件上传组件
        var perResouceMultiuploader = function ($scope) {
            Multiuploader.init($scope, {
                edit: true,
                uploader: 'ResouceList',
                param: {
                    placeAt: '#ResouceList',
                    file: 'doc'
                },
                template: {
                    'detail-remark': true
                },
                data: {
                    123: {
                        fileId: 123,
                        detailName: '电子资源1',
                        detailFormat: ['76020']
                    }
                }
            });
        };

        //弹出编辑侧边栏
        var showSlidebar = function ($compile, $scope, type, stagePeriodicalId) {
            var config = {
                url: getServer() + '/static/app/collection/classics/stagePeriodical/views/stagePeriodicalEdit.html',
                $compile: $compile,
                $scope: $scope,
                width: '900px',
                afterLoad: function () {
                    if(type === 'edit'){
                        initData($scope, stagePeriodicalId);
                    }
                    stagePerTree.createTreeInit($compile, $scope);
                    perResouceMultiuploader($scope);
                    treeGridInit($compile, $scope);

                }
            };
            Util.slidebar(config);
        };


        //初始化页面数据
        var initData = function ($scope, stagePeriodicalId) {
            $.ajax({
                url : Dict.URL_QUERYSTAGEPERIODICALINFOBYID_SERIVCE,
                async:false,
                type: "POST",
                data:"stagePeriodicalId="+stagePeriodicalId,
                dataType:"json",
                success:function(e){
                    $scope.stagePeriodical.entity = e.entity;
                    var entity = e.entity;
                    //if(entity.typeDict == ''){
                    //    $scope.periodical.entity.foliosDict = '';
                    //}
                    if(e.entity.stagePeriodicalIsCore==='1'){
                        $scope.stagePeriodical.entity.IsCore = true;
                    }
                    $scope.$digest();
                    // 各tab页数据获取
                    //地点
                }
            });
           /* $.post(Dict.URL_QUERYSTAGEPERIODICALINFOBYID_SERIVCE,"stagePeriodicalId="+stagePeriodicalId,'','json').done(function(data){
                $scope.stagePeriodical.entity = data.model.entity;
                var entity = data.model.entity;
                //if(entity.typeDict == ''){
                //    $scope.periodical.entity.foliosDict = '';
                //}
                $scope.$digest();
                // 各tab页数据获取
                stagePerTree.createTreeInit($compile, $scope);
                //地点
            });*/
        };

        //初始化查询列表
        var queryListInit = function ($scope) {
            Dict.queryDict(Dict.URL_PERIODICAL_TYPE).done(function (data) {
                $scope.stagePeriodical.query.list.queryPerTypes = data.curPageData;
                $scope.$digest();
            });
        };

        //控制器初始化函数
        result.initCtrl = function ($compile, $scope) {
            scopeInit($compile, $scope);
            gridInit($compile, $scope);               //初始化grid
            queryListInit($scope);
        };

        //打开文章侧边栏
        var openArticleSlidebar = function ($compile, $scope, type) {
            //$scope.application = {};
            articleSupport.initCtrl($compile, $scope, type);
        };

        //把json树转为普通json
        var disposeJson = function(obj){
            var arrg = [];
            if(obj != undefined && typeof obj.children === 'object'){
                for(var i=0;i<obj.children.length; i++){
                    if(typeof obj.children === 'object'){
                        arrg.push({"columntreePertreeId":obj.children[i].columntreePertreeId,
                            "columntreePpertreeId": obj.children[i].columntreePpertreeId,
                            "columntreeName": obj.children[i].columntreeName,
                            "columntreeNameEn": obj.children[i].columntreeNameEn});
                        disposeJson(obj.children[i],1);
                    }
                }
            }
            arrg.push({"columntreePertreeId":obj.columntreePertreeId, "columntreePpertreeId": obj.columntreePpertreeId,
                "columntreeName": obj.columntreeName, "columntreeNameEn": obj.columntreeNameEn});
            return arrg;
        };

        //保存分期刊
        var saveStagePeriodical = function($compile, $scope){
            if($scope.stagePeriodical.entity.IsCore){
                $scope.stagePeriodical.entity.stagePeriodicalIsCore = 1;
            }else{
                $scope.stagePeriodical.entity.stagePeriodicalIsCore = 0;
            }
            //$scope.stagePeriodical.entity.stagePeriodicalIsCore
            var param = {
                'stagePeriodicalInfo' : JSON.stringify($scope.stagePeriodical.entity),
                'stagePeriodicalColumntree' : JSON.stringify(disposeJson($.fn.zTree.getZTreeObj("commonTreeCN").getNodes()[0]))
            };
            $.post(Dict.URL_SAVEORUPDATESTAGEPERIODICAL_SERIVCE,param,'','json').done(function(data){
                $scope.stagePeriodical.entity.stagePeriodicalId = data.model.entity.stagePeriodicalId;
                $scope.$digest();
                Util.alert("保存成功");
                gridInit($compile,$scope);
            });
        };
        //删除操作
        var delStagePeriodical = function($compile,$scope){
            var selected = gridInstance.getSelectedRow();
            if (selected.length) {
                Util.confirm('确定要删除选择的数据吗?', function () {
                    var stagePeriodicalIds = [];
                    for (var i = 0, item; item = selected[i++];) {
                        stagePeriodicalIds.push(item.stagePeriodicalId);
                    }
                    var ids = stagePeriodicalIds.join(',');
                    $.post(Dict.URL_DELBATCHSTAGEPERIODICALINFOBYID_SERIVCE, "stagePeriodicalIds=" + ids).done(function (data) {
                        if(data.status ==='200'){
                            Util.alert('删除成功!');
                        }else{
                            Util.alert('删除失败!');
                        }
                        //刷新grid
                        gridInit($compile,$scope);
                    });
                })
            }else{
                Util.alert('请选择要删除的数据!');
            }
        };
        //初始化ctrl Scope
        var scopeInit = function ($compile, $scope) {
            $scope.stagePeriodical = {
                template: {
                    periodicalStageEdit: getStaticPath() + '/app/collection/classics/stagePeriodical/views/stagePeriodicalEdit.html'
                },
                query: {
                    conditions: {
                        queryStaPerName: '',
                        queryStaPerStage: '',
                        queryStaPerPerYear: ''
                    },
                    query: function () {
                        gridInit($compile,$scope);
                    },
                    list: {
                        queryPerTypes: []
                    },
                    reset: function () {
                        $scope.stagePeriodical.query.conditions = {
                            queryStaPerName: '',
                            queryStaPerStage: '',
                            queryStaPerPerYear: ''
                        };
                        $scope.$digest();
                    }
                },
                entity: {},
                show: true,
                btnShow: false,
                selectPerName: function () {
                    var setting = {
                        $compile: $compile,
                        $scope: $scope,
                        itemName: 'periodical.entity.supervisorUnit'
                    };
                    periodicalSelectSupport.instance(setting);
                },
                saveEntity: function(){
                    saveStagePeriodical($compile, $scope);
                },
                perSelect: {
                    query : {
                        queryGroupName : '',
                        reset: function(){
                            $scope.stagePeriodical.perSelect.query.queryGroupName = '';
                            $scope.$digest();
                        }
                    }
                }
            };

            $scope.$digest();
        };
        return result;
    }
);