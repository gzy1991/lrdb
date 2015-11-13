/*
HomeApp模块
 */
define(["PDAppDir/directive","PDCoreDir/directive","Angular","Angular-route"],function(appDirective,coreDirective,angular){
    var HomeApp = angular.module('HomeApp', ["ngRoute"]);

    //基础控制器
    /*
     * BodyCtrl
     */
    HomeApp.controller('BodyCtrl', ["$http",'$scope', function($http,$scope){

    }]);
    
    //定义菜单数据
    var menuData = null;
    //远程同步请求菜单数据
    $.ajax({
    	url : getServer() + "/sword/menu/getMenuJson",
    	async: false,
		data : {
			"SwordControllerName" : "getMenuJson"
		},
		success : function(data) {
			//如果包含根节点，就将根节点去掉
			if (data && data.length == 1 && data[0].menu.menuId == "root") {
				data = data[0].subMenu;
			}
			//接收菜单数据
			menuData = data;
			
			//生成routerMap
            var routerMap = (function(menuData){
            	//定义返回结果
            	var result = {};
            	//定义返回结果中的数据格式
            	var configs = result.configs = [];
            	
            	//定义递归方法
            	function t(menuData) {
            		if (menuData && menuData.length > 0) {
            			$.each(menuData, function(i, n){
            				if (n.menu.menuType == "2"
            					&& n.menu.menuRouter
            					&& n.menu.menuCtrl
            					&& n.menu.menuCtrlUrl
            					&& n.menu.menuUrl) { //叶子节点
            					configs.push({
            						ctrlName : n.menu.menuCtrl,
            						ctrlUrl : n.menu.menuCtrlUrl,
            						routerPath : n.menu.menuRouter,
            						templateUrl : n.menu.menuUrl
            					});
            				} else if (n.menu.menuType == "1"){ //分类节点
            					if (n.subMenu && n.subMenu.length > 0) {
            						t(n.subMenu);
            					}
            				}
            			})
            		}
            	}
            	//执行递归方法
            	t(menuData);
            	//返回执行结果
            	return result;
            })(menuData);
            
            //注册routerMap
            routerExtend(routerMap, HomeApp);
		}
    });
    
    //基础指令
    /*
     * sidebarMenu
     */
    HomeApp.directive('sidebarMenu', ["$http",function ($http) {
            return {
                replace: false,
                restrict: 'A',
                templateUrl: getStaticPath() +'/core/home/views/sidebarLI.html',
                link: function ($scope, element, attrs) {
        			$scope.hover = "";
                    $scope.templateUrl = getStaticPath() +'/core/home/views/sidebarLI.html';
                    $scope.sidebar = {
                        subMenu: menuData
                    };
                    //默认展开最后一个菜单组
                    /*setTimeout(function(){
                        //$("#sidebar>ul>li:last>a").click();
                        $("#sidebar>ul>li>a:contains('系统管理')").click();
                    },800);*/
                    //手动刷新视图（模型已更新）
                    //$scope.$digest();
                	/*
                	$http.get(getServer() +'/static/core/home/menu/data/Menu.json').success(function (data) {
                        $scope.hover = "";
                        $scope.templateUrl = getStaticPath() +'/core/home/views/sidebarLI.html';
                        $scope.sidebar = {
                            sidebars: data
                        };
                    });
                    */
                }
            };
    }]);

    //扩展路由&控制器
    /*
    routerExtend(coreRouterMap,HomeApp);
    routerExtend(appRouterMap,HomeApp);
    routerExtend({configs:[{
    	ctrlName : "core_menuCtrl",
    	ctrlUrl : "static/core/system/menu/menuCtrl",
    	routerPath : "menu",
    	templateUrl : "static/core/system/menu/views/index.html"
    }]}, HomeApp);
    */

    //扩展指令
    directiveExtend(coreDirective,HomeApp);
    directiveExtend(appDirective,HomeApp);

    /*
     * 路由&控制器扩展
     * routerExtend
     */
    function routerExtend(obj,app){
        var i=0,length=0;
        for (i=0,length=obj.configs.length;i<length;i++) {
            (function(){
                var config = obj.configs[i];
                if(!config.ctrlName||!config.ctrlUrl||!config.routerPath||!config.templateUrl){
                    console.log("router init error! ctrlName:"+config.ctrlName+", routerPath:"+config.routerPath);
                    console.log(config);
                }
                app.controller(config.ctrlName, ["$compile", '$scope','$route','$routeParams', function($compile,$scope,$route,$routeParams){
                    require([config.ctrlUrl], function (ctrl) {
                        if(!ctrl){
                            console.log("controller init error! ctrlName: "+config.ctrlName);
                            console.log(config);
                        }
                        ctrl($compile, $scope,$route,$routeParams);
                    });
                }]);
                app.config(['$routeProvider',
                    function($routeProvider) {
                        $routeProvider.when("/" + config.routerPath, {
                            //templateUrl : getStaticPath() +'/'+ config.templateUrl,
                        	templateUrl : getServer() + "/" + config.templateUrl,
                            controller : config.ctrlName
                        });
                    }
                ]);
            })();
        }
        /* welcome config */
        app.controller("welcomeCtrl", ["$compile", '$scope','$route','$routeParams', function($compile,$scope,$route,$routeParams){
            require(["static/core/home/welcomeCtrl"], function (ctrl) {
                if(!ctrl){
                    console.log("controller init error! ctrlName: "+config.ctrlName);
                    console.log(config);
                }
                ctrl($compile, $scope,$route,$routeParams);
            });
        }]);
        app.config(['$routeProvider',
            function($routeProvider) {
        		//注册默认的路由地址
                $routeProvider.when("/", {
                	redirectTo: '/welcome'
                }).when("/welcome", {
        			templateUrl : getServer() + "/static/core/home/welcome.html",
    				controller : "welcomeCtrl"
                }).when("/404", {
                	templateUrl : getServer() + "/static/core/home/404.html"
                    //controller : "welcomeCtrl"
                }).otherwise({
                    redirectTo: '/404'
                });
                
            }
        ]);
        //初始化breadcrumb的首页li的点击事件
        $(".breadcrumb").on("click", function() {
        	var $a = $(this).find("li:first-child").find("a");
        	$a.attr("href","#welcome").trigger("click");
        })
    }

    /*
     * 指令扩展
     * directExtend
     */
    function directiveExtend(obj,app){
        var i=0, length=0, directive;
        for (i=0,length=obj.directives.length;i<length;i++) {
            directive = obj.directives[i];
            if(!directive.name||!directive.func){
                console.log("directive init error! Index: "+i+", Name: "+directive.name);
                console.log(directive);
            }
            app.directive(directive.name, directive.func);
        }
    }

    return HomeApp;
});
