/*
HomeApp模块
 */
define(["PDAppDir/directive","PDCoreDir/directive","Angular", "PDUtilDir/util", "Angular-route"],function(appDirective,coreDirective,angular, Util){
    var HomeApp = angular.module('HomeApp', ["ngRoute"]);

    //基础控制器
    /*
     * BodyCtrl
     */
    HomeApp.controller('BodyCtrl', ["$http",'$scope', function($http,$scope){

    }]);
    
    //兼听菜单点击事件更新bread
    $(".nav-list").bind("click",function(e){
        var li = null;
        e.target.nodeName.toLowerCase()=="a" ? li=e.target.parentNode : li=e.target.parentNode.parentNode;
        $('.nav-list li.active').removeClass('active');
        $(li).parents('.nav-list li').addClass('active');
        $(li).find("ul").length || $(li).addClass('active');
        //更新导航条
        var breadcrumb_items = [];
        $(li.firstChild).parents('.nav-list li').each(function() {
            var link = $(this).find('> a');
            var text = link.text();
            var href = link.attr('href');
            breadcrumb_items.push({'name': text, 'href': href});
        });
        require(["text!PDModuleDir/ace/template/breadcrumbs.html"],function(html){
            $(".breadcrumb").html(Util.template(html,{items:breadcrumb_items}));
        });
    });
    
    //菜单go方法
    window.menuGo = function(menuId) {
    	console.log(menuId);
    	var $menu = $("#sidebar").find("li[data-menuId=" + menuId + "] a");
    	console.log($menu);
    	$menu.trigger("click");
    	//$menu.click();
    }
    
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
            				if (n.menu.menuType == "2") {//菜单实体
            					if (n.menu.menuOpen == "1" || n.menu.menuOpen == "3") { //本窗口 / 新窗口-本域-路由
            						if (n.menu.menuRouter
            								&& n.menu.menuCtrl
            								&& n.menu.menuCtrlUrl
            								&& n.menu.menuUrl) {
            							configs.push({
                    						ctrlName : n.menu.menuCtrl,
                    						ctrlUrl : n.menu.menuCtrlUrl,
                    						routerPath : n.menu.menuRouter,
                    						templateUrl : n.menu.menuUrl,
                    						menuService : n.menu.menuService
                    					});
            						}
            						n.menu.router = true;
            						(n.menu.menuOpen == "3") && (n.menu.openNew = true);
            					} else if (n.menu.menuOpen == "5") { //新窗口-本域-非路由
            						n.menu.openNew = true;
            						n.menu.menuUrl = getServer() + "/" + n.menu.menuUrl;
            					} else if (n.menu.menuOpen == "7") { //新窗口-跨域
            						n.menu.openNew = true;
            					}
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
            //debugger;
            //alert(routerMap);
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
                templateUrl: getStaticPath() +'/core/page/home/views/sidebarLI.html',
                link: function ($scope, element, attrs) {
        			$scope.hover = "";
                    $scope.templateUrl = getStaticPath() +'/core/page/home/views/sidebarLI.html';
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
                }
            };
    }]);

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
                var menuService = config.menuService;
                //处理menuService
                (function(){
                	if (menuService) {
                		//数据格式：id:code,id:code
                		var menuServiceArr = menuService.split(",");
                		menuService = [];
                		if (menuServiceArr) {
                			$.each(menuServiceArr, function(i, n){
                				menuService.push(n.split(":")[1]);
                			})
                		}
                	} else {
                		menuService = [];
                		menuService.push("compile");
                		menuService.push("scope");
                	}
                	$.each(menuService, function(i, n){
                		if (n.indexOf("$") != 0) {
                			n = "$" + n;
                			menuService.splice(i, 1, n);
                		}
                	})
                })();
                menuService.push(function(){
                	var args = arguments;
                	require([config.ctrlUrl], function (ctrl) {
                        if(!ctrl){
                            console.log("controller init error! ctrlName: "+config.ctrlName);
                            console.log(config);
                        }
                        ctrl.apply(null, args);
                    });
                })
                app.controller(config.ctrlName, menuService);
                /*
                app.controller(config.ctrlName, ["$compile", '$scope', function($compile,$scope,$route,$routeParams){
                    require([config.ctrlUrl], function (ctrl) {
                        if(!ctrl){
                            console.log("controller init error! ctrlName: "+config.ctrlName);
                            console.log(config);
                        }
                        ctrl($compile, $scope,$route,$routeParams);
                    });
                }]);
                */
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
            require(["PDWelcomeDir/js/welcomeCtrl"], function (ctrl) {
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
        			templateUrl : getServer() + "/static/core/page/welcome/welcome.html",
    				controller : "welcomeCtrl"
                }).when("/404", {
                	templateUrl : getServer() + "/static/core/page/404.html"
                    //controller : "welcomeCtrl"
                }).otherwise({
                    redirectTo: '/404'
                });
                
            }
        ]);
        //初始化breadcrumb的首页li的点击事件
        /*
        $(".breadcrumb").on("click", function() {
        	alert(this);
        	alert($(this));
        	alert($);
        	var $a = $(this).find("li").eq(0).find("a");
        	$a.attr("href","#welcome").trigger("click");
        })
        */
        //初始化cs-bt-tbar
        var tbar_timer;
        $(".cs-bt-tbar-tab").on("mouseenter", function(){
        	var _this = this;
        	clearTimeout(tbar_timer);
        	tbar_timer = setTimeout(function(){
        		$(_this).find(".cs-bt-tbar-sub").fadeIn();
        		if ($(_this).data("type") == "shortcut") {
        			$.ajax({
        				url : getServer() + "/sword/shortcut/getByUser",
        				success : function(data) {
        					if (data && data.length > 0) {
        						var html = [];
        						$.each(data, function(i, n){
        							/*
        							if (n.menuOpen == "1" || n.menuOpen == "3") { //本窗口 / 新窗口-本域-路由
                						n.router = true;
                						(n.menuOpen == "3") && (n.openNew = true);
                					} else if (n.menuOpen == "5") { //新窗口-本域-非路由
                						n.openNew = true;
                						n.menuUrl = getServer() + "/" + n.menuUrl;
                					} else if (n.menuOpen == "7") { //新窗口-跨域
                						n.openNew = true;
                					}
        							var href = n.router ? ("#" + n.menuRouter || "|| 'javascript:;") : (n.menuUrl || "javascript:;");
        							var target = n.openNew ? "_blank" : "";
        							var str = "<a href='" + href +"' target='" + target + "'  title='" + n.menuName + "'>" + n.menuName + "</a>";
        							html.push(str);
        							 */
        							var click = 'window.menuGo && window.menuGo("' + n.menuId + '")';
        							var href = 'javascript:;';
        							var str = "<a href='" + href +"' title='" + n.menuName + "' onclick='" + click + "'>" + n.menuName + "</a>";
        							html.push(str);
        						})
        						$(".cs-bt-tbar-sub.shortcut").html(html.join(" "));
        					}
        				}
        			})
        		}
        	}, 100);
        }).on("mouseleave", function(){
        	var _this = this;
        	clearTimeout(tbar_timer);
        	tbar_timer = setTimeout(function(){
        		$(_this).find(".cs-bt-tbar-sub").fadeOut();
        	}, 100);
        });
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
