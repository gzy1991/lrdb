/**
 * Created by zhanglei on 2015-9-25.
 */
define(['jquery','PDUtilDir/grid','PDUtilDir/util','LrdbCommonDir/dict','LrdbCommonDir/uploader/multi-uploader','LrdbCkEditor'],
    function($,Grid,Util,Dict,Multiuploader){
        var result = {};
        var editor = '';
        //弹出编辑侧边栏
        var showSlidebar = function($compile,$scope, type) {
            var config = {
                //id: 'articleEditPanel',
                url: getServer() + '/static/app/collection/classics/stagePeriodical/views/article.html',
                $compile : $compile,
                $scope : $scope,
                width: '800px',
                afterLoad: function () {
                    picResouceListMultiuploader($scope);
                    if('edit'===type){
                        initData($scope);
                    }else{
                        if (editor){
                            editor.destroy();
                        }
                        editor = CKEDITOR.replace('content');
                        CKEDITOR.config.height = 330;
                    }
                }
            };
            Util.slidebar(config);
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
        var initData = function($scope){
            var url = getServer() + '/static/app/collection/classics/stagePeriodical/data/articleSingle.json';
            Dict.queryDict(url).done(function(data){
                $scope.article.entity = data.curPageData;
                $scope.$digest();
            });

        };

        //控制器初始化函数
        result.initCtrl = function($compile,$scope, type){
            scopeInit($scope);
            showSlidebar($compile,$scope, type);
        };

        //初始化ctrl Scope
        var scopeInit = function($scope){
            $scope.article = {
                template: {
                    periodicalStageEdit: getStaticPath() + '/app/collection/classics/article/views/articleEdit.html'
                },
                artAuthors : [],
                addArtAuthor : function(){
                    if(this.artAuthors === '') {
                        this.artAuthors=[]; //初始化
                    }
                    this.artAuthors.push({});
                },
                delArtAuthor : function(artAuthor,index){
                    this.artAuthors.splice(index,1);
                },
                artTranslators : [],
                addArtTranslator : function(){
                    if(this.artTranslators === '') {
                        this.artTranslators=[];//初始化
                    }
                    this.artTranslators.push({});
                },
                delArtTranslator : function(artTranslator,index){
                    this.artTranslators.splice(index,1);
                },
                entity: {},
                show: true,
                btnShow: false,
                toggleShow: function () {
                    $scope.periodical.btnShow = !$scope.periodical.btnShow;
                    $scope.periodical.show = false;
                }
            };
            $scope.$digest();
        };
        return result;
    }
);