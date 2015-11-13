/**
 * Created by zhanglei on 2015-9-25.
 */
define(['jquery','PDUtilDir/grid','PDUtilDir/util','LrdbCommonDir/dict','LrdbCommonDir/uploader/multi-uploader','LrdbCkEditor'],
    function($,Grid,Util,Dict,Multiuploader){
        var result = {};
        var editor = '';
        var slidebar;
        var articleGrid;
        //弹出编辑侧边栏
        var showSlidebar = function($compile,$scope, type, ColumnId, row) {
            var dataedi;
            var config = {
                //id:'articleEditPanel',
                url: getServer() + '/static/app/collection/classics/stagePeriodical/views/article.html',
                $compile : $compile,
                $scope : $scope,
                width: '800px',
                afterLoad: function () {
                    //表单验证
                    validate($scope);

                    if (editor){
                        editor.destroy();
                    }//else{
                    editor = CKEDITOR.replace('content');
                    CKEDITOR.config.height = 330;
                    //}
                    $scope.article.entity.columntreePertreeId = ColumnId;
                    picResouceListMultiuploader($scope);

                    if('edit'=== type) {
                        initData($scope, row);
                    }else{
                        $scope.article.entity.artAuthors.push({stageArtistType:'artAuthor'});
                        $scope.article.entity.artTranslators.push({stageArtistType:'artTranslator'});
                        $scope.$digest();
                    }

                }
            };
            slidebar = Util.slidebar(config);
        };

        //图片集/幻灯片集
        var picResouceListMultiuploader = function($scope){
            Multiuploader.init($scope,{
                edit : true,
                uploader : 'picResouceList',
                param : {
                    placeAt : '#picResouceList',
                    file : 'doc'
                },
                template : {
                    'detail-remark' : true
                },
                data : {
                    123 : {
                        fileId : 123,
                        detailName : '电子资源1',
                        detailFormat : ['76020']
                    }
                }
            });
        };

        //初始化页面数据
        var initData = function($scope, row){

            var articleId = row.articleId;
            if(articleId != undefined && articleId != ''){
                var jsonObj = $scope.stagePeriodical.articleUpdataEntity;
                for(var i=0, item; item = jsonObj[i++];){
                    if(articleId === item.articleId){
                        $scope.article.entity = item;
                        $scope.article.entity._index = row._index;
                        editor.setData(item.articleContent);
                        $scope.stagePeriodical.articleTmpEntity = item;
                        $scope.$digest();
                        return false;
                    }
                }
                $.post(Dict.URL_QUERYSTAGEPERIODICALARTICLEBYID_SERVICE,{articleId:articleId}).done(function(data){
                    $scope.article.entity = data.model.entity;
                    $scope.article.entity._index = row._index;
                    editor.setData($scope.article.entity.articleContent);
                    $scope.stagePeriodical.articleTmpEntity = item;
                    $scope.$digest();
                });
            }else{
                var jsonObj = $scope.stagePeriodical.articleAddEntity;
                for(var i=0, item; item = jsonObj[i++];) {
                    if(item === row){
                        $scope.article.entity = item;
                        $scope.article.entity._index = row._index;
                        editor.setData(item.articleContent);
                        $scope.stagePeriodical.articleTmpEntity = item;
                        $scope.$digest();
                        return false;
                    }
                }
            }
        };

        //树列表
        result.treeGridInit = function ($compile, $scope, ColumnId) {

            var config = {
                id: 'stagePeriodicalColumnGridId',
                placeAt: 'stagePeriodicalColumnList',
                pageSize: 10,
                multi : true,
                cache: false,
                layout: [{name: '文章名称', field: 'articleTitle', width: '80%', click: function (e) {
                    initCtrl($compile, $scope, 'edit', ColumnId, e.data.row);
                }}
                ],
                toolbar: [{
                    name: '添加', icon: 'fa fa-plus-circle', callback: function () {
                        if(ColumnId != '' && ColumnId != undefined) {
                            initCtrl($compile, $scope, 'add',ColumnId,'');
                        }else{
                            Util.alert('请先选择栏目!');
                        }
                    }},
                    {
                        name: '删除', icon: 'fa fa-trash-o', callback: function () {
                        delStagePeriodicalArticle($compile, $scope, ColumnId);
                    }
                    }],
                data: {
                    type: 'URL',
                    value: Dict.URL_QUERYSTAGEPERIODICALARTICLEINFOLIST_SERVICE
                },
                queryParam : {
                    columntreePertreeId : ColumnId
                },
                trEvent: []
            };
            articleGrid = Grid(config);
        };

        //刷新grid 因为文章保存，更新都存在临时域中 result.refreshArticleGrid($compile, $scope, ColumnId)
        result.refreshArticleGrid = function($compile, $scope, ColumnId){
            result.treeGridInit($compile, $scope, ColumnId);
            if($scope.stagePeriodical.articleAddEntity != undefined && $scope.stagePeriodical.articleAddEntity.length > 0){
                for(var i = 0, item; item = $scope.stagePeriodical.articleAddEntity[i++];){
                    if(item.columntreePertreeId === ColumnId){
                        articleGrid.appendRow(item);
                    }
                }
            }
            if($scope.stagePeriodical.articleUpdataEntity != undefined && $scope.stagePeriodical.articleUpdataEntity.length != 0){
                for(var i = 0, item; item = $scope.stagePeriodical.articleUpdataEntity[i++];){
                    if(item.columntreePertreeId === ColumnId){
                        articleGrid.updateRow({index:item._index,row:item});
                    }
                }
            }
            if($scope.stagePeriodical.articleDelEntity != undefined && $scope.stagePeriodical.articleDelEntity.length != 0){
                for(var i = 0, item; item = $scope.stagePeriodical.articleDelEntity[i++];){
                    if(item.columntreePertreeId === ColumnId){
                        articleGrid.deleteRow(item._index);
                    }
                }
            }
        };

        //保存文章内容
        var saveArticle = function($compile, $scope){
            $scope.article.entity.articleContent = editor.getData();
            var tmpEntity = $scope.stagePeriodical.articleTmpEntity;
            if($scope.article.entity.articleId != undefined && $scope.article.entity.articleId != ''){
                var tempUpdataEntity = $scope.stagePeriodical.articleUpdataEntity;
                if(tempUpdataEntity.length > 0){
                    for(var i= 0,updataItem;updataItem = tempUpdataEntity[i++];){
                        if(updataItem === tmpEntity){
                            tempUpdataEntity.splice(i-1,1);
                            break;
                        }
                    }
                    $scope.stagePeriodical.articleUpdataEntity = tempUpdataEntity;
                }
                $scope.stagePeriodical.articleUpdataEntity.push($scope.article.entity);
            }else{
                var tempAddEntity = $scope.stagePeriodical.articleAddEntity;
                if(tempAddEntity.length > 0){
                    for(var i= 0,addItem;addItem = tempAddEntity[i++];){
                        if(addItem === tmpEntity){
                            tempAddEntity.splice(i-1,1);
                            break;
                        }
                    }
                    $scope.stagePeriodical.articleAddEntity = tempAddEntity;
                }
                $scope.stagePeriodical.articleAddEntity.push($scope.article.entity);
            }
            Util.alert("保存成功！");
            slidebar.close();
            result.refreshArticleGrid($compile, $scope, $scope.article.entity.columntreePertreeId)
        };

        //删除操作
        var delStagePeriodicalArticle = function($compile, $scope, ColumnId){
            var selected = articleGrid.getSelectedRow();
            if (selected.length) {
                Util.confirm('确定要删除选择的数据吗?', function () {
                    for (var i = 0, delItem; delItem = selected[i++];) {
                        if(delItem.articleId != '' && delItem.articleId != undefined){
                            if($scope.stagePeriodical.articleDelEntity.indexOf(delItem) === -1){
                                $scope.stagePeriodical.articleDelEntity.push(delItem);
                            }
                        }else{
                            var tempAddEntity = $scope.stagePeriodical.articleAddEntity;
                            if(tempAddEntity.length > 0){
                                for(var i= 0,addItem;addItem = tempAddEntity[i++];){
                                    if(addItem === delItem){
                                        tempAddEntity.splice(i-1,1);
                                        $scope.stagePeriodical.articleAddEntity = tempAddEntity;
                                        break;
                                    }
                                }
                            }
                        }
                        articleGrid.deleteRow(delItem._index);

                    }
                    Util.alert('删除成功!');
                    result.refreshArticleGrid($compile, $scope, ColumnId);
                });
            }else{
                Util.alert('请选择要删除的数据!');
            }

        };

        var validate = function($scope) {// 艺术家基本信息校验
            // 艺术家基本信息输入数据验证
            $('#articeDetailInfoFormId').validate({
                rules : {// 要校验的字段及校验规则
                    articleTitle : {
                        required : true,
                        maxlength : 100
                    },
                    articlePageNumStart : {
                        digits : true
                    },
                    articlePageNumEnd : {
                        digits : true
                    }
                },
                messages : {
                    // 如果使用封装好的校验,提示信息不用写有默认值,会自动出现在输入框下面,自己写的校验规则才写提示信息
                    articleTitle : {
                        required: '请填写文章标题！',
                        maxlength : '不能超过100个字'
                    },
                    articlePageNumStart : {
                        digits : '请填写整数数字'
                    },
                    articlePageNumEnd : {
                        digits : '请填写整数数字'
                    }
                }
            });
        };

        //控制器初始化函数
        var initCtrl = function($compile, $scope, type, ColumnId, row){
            scopeInit($compile,$scope);
            showSlidebar($compile,$scope, type, ColumnId, row);

        };

        //初始化ctrl Scope
        var scopeInit = function($compile, $scope){
            $scope.article = {
                template: {
                    periodicalStageEdit: getStaticPath() + '/app/collection/classics/article/views/articleEdit.html'
                },

                addArtAuthor : function(){
                    if($scope.article.entity.artAuthors === undefined) {
                        $scope.article.entity.artAuthors=[]; //初始化
                    }
                    $scope.article.entity.artAuthors.push({stageArtistType:'artAuthor'});

                },
                delArtAuthor : function(artAuthor,index){
                    if($scope.article.entity.artAuthors.length != 1){
                        $scope.article.entity.artAuthors.splice(index,1);
                    }
                },

                addArtTranslator : function(){
                    if($scope.article.entity.artTranslators === undefined) {
                        $scope.article.entity.artTranslators=[];//初始化
                    }
                    $scope.article.entity.artTranslators.push({stageArtistType:'artTranslator'});
                },
                delArtTranslator : function(artTranslator,index){
                    if($scope.article.entity.artTranslators.length != 1){
                        $scope.article.entity.artTranslators.splice(index,1);
                    }
                },
                entity: {
                    artAuthors : [],
                    artTranslators : []
                },

                show : true,
                saveEntity  : function(){
                    if($("#articeDetailInfoFormId").valid()) {
                        saveArticle($compile, $scope);
                    }
                }
            };
            $scope.$digest();
        };
        return result;
    }
);