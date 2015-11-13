/**
 * 功能：给制定div、span、tbody等，包装一个block，可以block折叠、展开
 * 版本：v1.1
 * 参数：
 *      两种传值方式
 *      1. config 直接传入id（内容采用默认方式）
 *      2. config 传入config对象（可定义标题、标题处图标，展开、收缩图标，展开、收缩说明标题） 格式如：
 *      config = {
 *          // 元素id
 *          id: "",
 *          // 显示标题 ，默认为"查询条件"
 *          homeTitle: ""，
 *          // 标题左侧的图标
 *          homeIcon: "",
 *          // 展开图标
 *          expandIcon: "",
 *          // 展开提示
 *          expandTitle: "",
 *          // 折叠图标
 *          collapseIcon: "",
 *          // 折叠提示
 *          collapseTitle: ""
 *      }
 *
 * 调用方式：
 *      define(["xxx/searchBlock"], function (searchBlock){
 *          ...
 *          // 元素id
 *          var config = "queryConditions";
 *          searchBlock.init(config);
 *          
 *          // 
 *      })
 */
define(['PDUtilDir/util', 'css!LrdbUtilDir/css/searchBlock'], function (util) {
    var searchBlock = {};
    //var _this;
    //var $block;
    searchBlock.init = function (config) {
        var _this = this;

        if (config === '' && !config.id) {
            util.alert('请指定要绑定的id！');
            return false;
        }

        // search块的id信息
        this.id = config.id ? config.id : config;
        
        // 如果已经加载了searchBlock，则不重复加载
        if ($('#' + _this.id).parent('.search-body').length > 0) {
            return false;
        }

        // search块头部的标题
        this.homeTitle = config.homeTitle ? config.homeTitle : '查询条件';

        // search块头部右侧的图标
        this.homeIcon = config.homeIcon ? config.homeIcon : 'fa fa-search';

        // search块展开图标
        this.expandIcon = config.expandIcon ? config.expandIcon : 'fa fa-angle-double-down';

        // search块展开提示
        this.expandTitle = config.expandTitle ? config.expandTitle : '展开';

        // search块折叠图标
        this.collapseIcon = config.collapseIcon ? config.collapseIcon : 'fa fa-angle-double-up';

        // search块折叠提示
        this.collapseTitle = config.collapseTitle ? config.collapseTitle : '折叠';

        // 创建search块
        createSearchBlock(_this);
    };

    // 创建search块
    var createSearchBlock = function (_this) {
        // search块主体
        $('#' + _this.id).wrap('<div class="search-body"></div>');

        var searchBody = $('#' + _this.id).parent('.search-body');
        // 默认块，作为search-body调整padding高度的临时div
        searchBody.append('<div class="clearfix"></div>');

        // search块容器
        searchBody.wrap('<div class="col-xs-12 search-container expandMode"></div>');
        var $block = $('#' + _this.id).closest('.search-container').wrap('<div class="col-xs-12"></div>');

        // search标题
        $('<div class="search-title"><i class="' + _this.homeIcon + '"></i>' + _this.homeTitle + '&nbsp; <a class="search-click"><i class="' + _this.collapseIcon + '" title="' + _this.collapseTitle + '"></i></a></div>').insertBefore(searchBody);
        // 展开/折叠searchBlock
        toggleSearchBlock(_this, $block);
    };

    // 展开/折叠searchBlock
    var toggleSearchBlock = function (_this, $block) {
        // 点击箭头图标展开/折叠
    	$($block).find('.search-click i').bind('click', function () {
            // 展开折叠的实现函数
            toggleSupport(this,_this);
        });

        // 标题栏双击展开/折叠功能
    	$($block).find('.search-title').bind('dblclick', function () {
            // 展开/折叠图标对象
            var obj = $(this).find('.search-click i');
            // 展开折叠的实现函数
            toggleSupport(obj,_this);
        });

        // 展开折叠的实现方法
        function toggleSupport(obj,_this){
            // 切换展开/折叠图标
            $(obj).toggleClass(_this.collapseIcon).toggleClass(_this.expandIcon);

            // 切换展开/折叠的title提示
            if ($(obj).attr('title') == _this.collapseTitle) {
                $(obj).attr('title', _this.expandTitle);
            } else {
                $(obj).attr('title', _this.collapseTitle);
            }

            // 搜索栏展开/折叠
            $($block).find('.search-body').slideToggle();
            $($block).closest('.search-container').toggleClass('expandMode').toggleClass('collapseMode');
        }
    };

    return searchBlock;
});