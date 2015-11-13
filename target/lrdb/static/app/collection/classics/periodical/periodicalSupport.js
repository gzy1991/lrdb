/**
 * @author zhanglei@css.com.cn
 */
define(['jquery', 'PDUtilDir/grid', 'PDUtilDir/util', 'LrdbCommonDir/dict', 'LrdbPeriodicalDir/periodicalColumnTree', 'LrdbPeriodicalDir/groupSelectSupport', 'LrdbCommonDir/record/record', 'PDUtilDir/crop', 'PDUtilDir/dialog', 'ZTree', 'css!ZTreeCss'],
    function ($, Grid, Util, Dict, ColumnTree, GroupSelectSupport, Record, Crop, Dialog) {
        var result = {};
        var gridInstance;
        var columnJson = {"columntreePertreeId":"croot", "columntreePpertreeId":"root", "columntreeName":"栏目","columntreeNameEn":"column"};
        var gridInit = function ($compile,$scope) {
            var config = {
                id: 'periodicalGridId',
                placeAt: 'periodicalList',
                pageSize: 10,
                multi: true,
                pagination: true,
                cache: false,
                layout: [{
                    name: '期刊名称', field: 'periodicalNameCn', width: '20%', click: function (e) {
                        showSlidebar($compile, $scope, 'edit',e.data.row.periodicalId);
                    }
                },
                    {name: '期刊类别', field: 'typeDict', width: '8%'},
                    {name: '主办单位', field: 'sponsor', width: '15%'},
                    {name: '出版单位', field: 'publisher', width: '15%'},
                    {name: '创刊时间', field: 'periodicalFirstTime', width: '8%'},
                    {name: '出版周期', field: 'publishSiteDict', width: '8%'},
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
                        name: '删除', icon: 'fa fa-trash-o', callback: function (event) {
                        delPeriodical($compile,$scope);
                    }
                    },
                    {
                        name: '跟踪', icon: 'fa fa-bar-chart', callback: function () {
                        Record.instance({$scope:$scope,$compile:$compile,objectId:'',model:'s'})
                    }
                    },
                    {
                        name: '查询', icon: 'fa fa-search', callback: function () {
                        $scope.periodical.query.query();
                    }
                    },
                    {
                        name: '重置', icon: 'fa fa-repeat', callback: function () {
                        $scope.periodical.query.reset();
                        $scope.$digest();
                        gridInit($compile,$scope);
                    }
                    }],
                data: {
                    type: 'URL',
                    value: Dict.URL_QUERYPERIODICALINFOLIST_SERVICE
                },
                queryParam: {
                    perName : $scope.periodical.query.conditions.queryPerName,  //期刊名称
                    perType : $scope.periodical.query.conditions.queryPerType, //期刊类别
                    sponsor : $scope.periodical.query.conditions.querySponsor, //主办单位
                    publish : $scope.periodical.query.conditions.queryPublisher//出版单位
                },
                trEvent: []
            };
            gridInstance = Grid.init(config);
        };

        //弹出编辑侧边栏
        var showSlidebar = function ($compile, $scope,type,periodicalId) {
            var config = {
                //id: 'periodicalEditPanel',
                url: getServer() + '/static/app/collection/classics/periodical/views/periodicalEdit.html',
                $compile : $compile,
                $scope : $scope,
                width: '900px',
                afterLoad: function () {
                    validate($scope);
                    slidebarListInit($scope);
                    if(type === 'edit'){
                        initData($scope,periodicalId);
                    }
                    else if(type === 'add'){
                        ColumnTree.CreateTree(columnJson,'commonTree', $scope);
                    }
                }
            };
            Util.slidebar(config);
        };

            //初始化页面数据
        var initData = function ($scope,periodicalId) {
            $.post(Dict.URL_QUERYPERIODICALINFOBYID_SERVICE,"periodicalId="+periodicalId,'','json').done(function(data){
                $scope.periodical.entity = data.model.entity;
                var entity = data.model.entity;
                if(entity.typeDict == ''){
                    $scope.periodical.entity.foliosDict = '';
                }
                if(entity.publishSiteDict === null){
                    $scope.periodical.entity.publishSiteDict = '';
                }
                if(entity.publishCycleDict === null){
                    $scope.periodical.entity.publishCycleDict = '';
                }
                if(entity.languageDict === null){
                    $scope.periodical.entity.languageDict = '';
                }
                if(entity.foliosDict === null){
                    $scope.periodical.entity.foliosDict = '';
                }
                $scope.$digest();
                // 各tab页数据获取
                tabColumnTreeInitData($scope,periodicalId);
                //地点
                unitInitData($scope,periodicalId);
            });
        };

        //初始化地点
        var unitInitData = function($scope,periodicalId){
            $.post(Dict.URl_QUERYPERIODICAUNITBYID_SERVICE,"periodicalId="+periodicalId,'','json').done(function(data){
                if(typeof data.model === 'object'){
                    var arrUnit = data.model.curPageData;
                    for(var i=0;i<arrUnit.length; i++){
                        if(arrUnit[i].unitType === '0') {
                            $scope.periodical.entity.supervisorUnit = arrUnit[i].unitNameMix;
                        }else  if(arrUnit[i].unitType === '1') {
                            $scope.periodical.entity.sponsor = arrUnit[i].unitNameMix;
                        }else  if(arrUnit[i].unitType === '2') {
                            $scope.periodical.entity.publisher = arrUnit[i].unitNameMix;
                        }
                    }
                }
                $scope.$digest();
            });
        };

        //初始化栏目树
        var tabColumnTreeInitData = function($scope,periodicalId){
            $.post(Dict.URl_QUERYPERIODICALCOLUMNTREEBYID_SERVICE,"periodicalId="+periodicalId,'','json').done(function(data){
                ColumnTree.CreateTree(data.model.curPageData, 'commonTree', $scope);
            });
        };



        //初始化侧边栏list
        var slidebarListInit = function ($scope) {

            Dict.queryDict(Dict.URL_PERIODICAL_TYPE).done(function (data) {
                $scope.periodical.list.perTypes = data.curPageData;
                $scope.$digest();
            });

            Dict.queryDict(Dict.URL_PERIODICAL_TYPE).done(function (data) {
                $scope.periodical.list.perTypes = data.curPageData;
                $scope.$digest();
            });
            Dict.queryDict(Dict.URL_PUBLISHCYCLE_TYPE).done(function (data) {
                $scope.periodical.list.publishCycles = data.curPageData;
                $scope.$digest();
            });
            Dict.queryDict(Dict.URL_LANGUAGE_TYPE).done(function (data) {
                $scope.periodical.list.languages = data.curPageData;
                $scope.$digest();
            });
            Dict.queryDict(Dict.URL_FOLIO_TYPE).done(function (data) {
                $scope.periodical.list.folios = data.curPageData;
                $scope.$digest();
            });
            Dict.queryDict(Dict.URL_CITY_TYPES).done(function (data) {
                $scope.periodical.list.publishSites = data;
                $scope.$digest();
            });
        };
        //初始化查询列表
        var queryListInit = function ($scope) {
            Dict.queryDict(Dict.URL_PERIODICAL_TYPE).done(function (data) {
                $scope.periodical.query.list.queryPerTypes = data.curPageData;
                $scope.$digest();
            });
        };
        //控制器初始化函数
        result.initCtrl = function ($compile, $scope) {
            scopeInit($compile, $scope);
            gridInit($compile,$scope);               //初始化grid
            queryListInit($scope);
        };



        //把json树转为普通json
        var disposeJson = function(obj){
            var arrg = [];
            if(typeof obj.children === 'object'){
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

        //保存操作
        var savePeriodical= function($compile,$scope){
            var param = {
                "periodicalInfo" : JSON.stringify($scope.periodical.entity),
                "periodicalColumntree" : JSON.stringify(disposeJson($.fn.zTree.getZTreeObj("commonTree").getNodes()[0])),
                "periodicaUnit" : JSON.stringify(disposeUnit($scope))
            };

            $.post(Dict.URL_SAVEORUPDATEPERIODICAL_SERVICE,param,'','json').done(function(data){
                $scope.periodical.entity.periodicalId = data.model.entity.periodicalId;
                $scope.$digest();
                Util.alert("保存成功");
                gridInit($compile,$scope);
            });
            //一次保存所有信息

        };
        var disposeUnit = function($scope){
            //主管单位 periodical.entity.supervisorUnit  0
            //主办单位 periodical.entity.sponsor  1
            //出版单位 periodical.entity.publisher  2
            var arrUnit = [];
            if($scope.periodical.entity.supervisorUnit != ''){
                arrUnit.push({"unitNameId":"","unitNameMix":$scope.periodical.entity.supervisorUnit,"unitType":0})
            }
            if($scope.periodical.entity.sponsor != ''){
                arrUnit.push({"unitNameId":"","unitNameMix":$scope.periodical.entity.sponsor,"unitType":1})
            }
            if($scope.periodical.entity.publisher != ''){
                arrUnit.push({"unitNameId":"","unitNameMix":$scope.periodical.entity.publisher,"unitType":2})
            }
            return arrUnit;
        };
        //删除操作
        var delPeriodical = function($compile,$scope){
            var selected = gridInstance.getSelectedRow();
            if (selected.length) {
                Util.confirm('确定要删除选择的数据吗?', function () {
                    var periodicalIds = [];
                    for (var i = 0, item; item = selected[i++];) {
                        periodicalIds.push(item.periodicalId);
                    }
                    var ids = periodicalIds.join(',');
                    $.post(Dict.URL_DELBATCHPERIODICALINFOBYID_SERVICE, "periodicalIds=" + ids).done(function (data) {
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
        //判断期刊是否存在
        var isPeriodicalExist = function ($scope) {

        };
        //上传封皮照片
        var uploadPic = function () {
            var dialog = Dialog({
                id: "CropDialog",
                cache: false,                 //是否缓存，默认为true
                title: "图片裁剪-弹出",
                width: "750px",
                height: "450px",
                dialogSize: "",               //modal-lg或modal-sm
                body: "窗口中间内容",
                buttons: [{
                    name: "确定",
                    callback: function () {
                        //图片裁剪后调用submit方法将数据提交至后台
                        //crop.submit();
                        alert("提交");
                    }
                }]
            });
            //设置html
            dialog.setBody("<div id='cropper'></div>");
            //初始化Crop
            var crop = Crop.init({
                //Crop的初始化选择器
                id: "#cropper",
                ratio: 4 / 3,
                //图片提交上传地址
                url: "http://localhost:8080/test",
                //图片上传时额外参数
                formData: {
                    "aaa": "aaa",
                    "bbb": "bbb"
                },
                success: function (file, response) {
                    alert("裁剪成功！");
                },
                error: function (file, reason) {
                    alert("裁剪失败！");
                }
            });
            //弹出窗口
            dialog.show();
        };
        var validate = function($scope) {// 艺术家基本信息校验
            // 艺术家基本信息输入数据验证
            $('#periodicalInfobaseFormId').validate({
                rules : {// 要校验的字段及校验规则
                    periodicalNameCn : {
                        required : true,
                        maxlength : 100
                    },
                    periodicalNameEn : {
                        maxlength : 100
                    },
                    periodicalFormerName : {
                        maxlength : 100
                    },
                    periodicalKeyword : {
                        maxlength : 100
                    },
                    typeDict : {
                        required : true
                    },
                    periodicalFirstTime : {
                        required : true
                    },
                    periodicalInterSeries : {
                        maxlength : 20
                    },
                    periodicalDomSeries : {
                        maxlength : 20
                    },
                    periodicalEmailedCode: {
                        maxlength: 10
                    },
                    periodicalPublicationDate : {
                        maxlength : 20
                    },
                    periodicalIntroduction : {
                        required : true,
                        maxlength : 3000
                    }
                },
                messages : {
                    // 如果使用封装好的校验,提示信息不用写有默认值,会自动出现在输入框下面,自己写的校验规则才写提示信息
                    periodicalNameCn : {
                        required: '请填写期刊名称',
                        maxlength : '不能超过100个字'
                    },
                    periodicalNameEn : {
                        maxlength : '不能超过100个字'
                    },
                    periodicalFormerName : {
                        maxlength : '不能超过100个字'
                    },
                    periodicalKeyword : {
                        maxlength : '不能超过100个字'
                    },
                    typeDict : {
                        required : '请选择期刊类型'
                    },
                    periodicalFirstTime : {
                        required : '请选择创刊时间'
                    },
                    periodicalInterSeries : {
                        maxlength : '不能超过20个字'
                    },
                    periodicalDomSeries : {
                        maxlength : '不能超过20个字'
                    },
                    periodicalEmailedCode : {
                        maxlength : '不能超过10个字'
                    },
                    periodicalPublicationDate : {
                        maxlength : '不能超过20个字'
                    },
                    periodicalIntroduction: {
                        required: '请填写简介信息',
                        maxlength : '不能超过3000个字'
                    }
                }
            });
        };
        //初始化ctrl Scope
        var scopeInit = function ($compile, $scope) {
            $scope.groupSelect = {
                entity : {},
                addGroupName : function(){
                    $scope.periodical.entity.supervisorUnit =
                        $scope.periodical.entity.supervisorUnit === '' || $scope.periodical.entity.supervisorUnit === undefined? $scope.groupSelect.entity.addGroupName : $scope.periodical.entity.supervisorUnit+";  "+$scope.groupSelect.entity.addGroupName;
                }
            };
            $scope.periodical = {
                template: {
                    periodicalEdit: getStaticPath() + '/app/collection/classics/periodical/views/periodicalEdit.html'
                },
                entity: {},
                list: {
                    perTypes: [],
                    publishCycles: [],
                    languages: [],
                    folios: []
                },

                query: {
                    list: {
                        queryPerTypes: []
                    },
                    conditions: {
                        queryPerName: '',
                        queryArtType: '',
                        querySponsor: '',
                        queryPublisher: ''
                    },
                    reset: function () {
                        //$scope.periodical.query.conditions = {queryPerName : '',queryKeyword : '',queryArtType : '',queryPreType : '',querySponsorOrg : '',queryPrintingPlace : ''};
                        $scope.periodical.query.conditions = '';
                        $scope.$digest();
                    },
                    query: function () {
                        gridInit($compile,$scope);
                    }
                },
                supervisorUnits: [],
                uploadPic: function () {
                    uploadPic();
                },
                changeTree: function (changeVal, language) {
                    ColumnTree.updataColumn(changeVal, language);
                },
                addsupUnit: function () {
                    setting = {
                        $compile: $compile,
                        $scope: $scope,
                        itemName: 'periodical.entity.supervisorUnit'
                    };
                    GroupSelectSupport.instance(setting);
                },
                show: true,
                btnShow: false,
                toggleShow: function () {
                    $scope.periodical.btnShow = !$scope.periodical.btnShow;
                    $scope.periodical.show = false;
                },
                saveEntity: function(){
                    if($("#periodicalInfobaseFormId").valid()) {
                        //if($scope.periodical.entity.periodicalId == undefined) {
                            //判断是否已经存在
                        //    isPeriodicalExist($scope);
                        //}else{//编辑
                            savePeriodical($compile, $scope);
                        //}
                    }else{//如果基本信息校验不通过
                        $("a[data-target=#detailInfo]").click();//,则调用jqueryclick函数触发元素的click事件,激活基本信息tab页
                    };
                }
            };
            $scope.$digest();

            //初始化
        };

        //-----
        return result;
    }
);