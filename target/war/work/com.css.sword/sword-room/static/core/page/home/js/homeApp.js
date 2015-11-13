/*
HomeApp模块
 */
define(["PDAppDir/directive","PDCoreDir/directive","Angular", "PDUtilDir/util", /*"Angular-route",*/ "Angular-ui-router"],function(appDirective,coreDirective,angular, Util){
    var HomeApp = angular.module('HomeApp', [/*"ngRoute", */"ui.router"]);

    //基础控制器
    /*
     * BodyCtrl
     */
    HomeApp.controller('BodyCtrl', ["$http",'$scope', function($http,$scope){

    }]);
   
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
            								//&& n.menu.menuCtrl
            								//&& n.menu.menuCtrlUrl
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
    
    
    //生成菜单
    (function(){
    	function makeMenu(subMenu) {
    		var html = [];
    		if (subMenu && subMenu.length > 0) {
    			for(var i=0; i<subMenu.length; i++) {
    				html.push(make(subMenu[i]));
    			}
    		}
    		return html.join("");
    	}
    	
    	function make(m) {
    		var menuId = m.menu.menuId;
    		var menuName = m.menu.menuName;
    		var menuIcon = m.menu.menuIcon;
    		var subMenu = m.subMenu && m.subMenu.length > 0;
    		var router = m.menu.router && (m.menu.menuRouter || '');
    		var uiSref = router ? (' ui-sref="' + router + '"') : '';
    		//var uiSrefActive = router ? ('ui-sref-active="active open"') : '';
    		var uiSrefActive = '';
    		var target = m.menu.openNew ? (' target="_blank"') : '';
    		var href = router ? '' : ' href="' + m.menu.menuUrl + '"';
    			
    		var $li = $( 
    				'<li ' + uiSrefActive + ' data-menuid="' + menuId + '" ' +'>' + 
	    				'<a ' + uiSref + href + target + (subMenu ? ' class="dropdown-toggle"' : '') + '>' +
		    				'<i class="menu-icon ' + (menuIcon || "fa fa-caret-right") + '"></i>' +
		    				'<span class="menu-text">' + menuName + '</span>' +
		    				'<b class="arrow ' + (subMenu ? "fa fa-angle-down" : "") + '"></b>' +
	    				'</a>' +
	    				'<b class="arrow"></b>' + 
    				'</li>'
    		);
    		if (subMenu) {
    			$ul = $('<ul class="submenu"></ul>').appendTo($li);
    			$ul.html(makeMenu(m.subMenu));
    		}
    		return $("<div></div>").append($li).html();
    	}
    	
    	var menuHtml = makeMenu(menuData);
    	$("#sidebar-menu").html(menuHtml);
    })();
    
    
    //基础指令
    /*
     * sidebarMenu
     */
    /*
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
                }
            };
    }]);
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
                if(!config.routerPath || !config.templateUrl
                		/*|| !config.ctrlName || !config.ctrlUrl*/){
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
                	//执行业务ctrl
                	require([config.ctrlUrl], function (ctrl) {
                        if(!ctrl){
                            console.log("controller init error! ctrlName: "+config.ctrlName);
                            console.log(config);
                        }
                        ctrl.apply(null, args);
                    });
                	//执行
                })
                //注册controller
                if (config.ctrlName && config.ctrlUrl) {
                	app.controller(config.ctrlName, menuService);
                }
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
                //注册state及router
                app.config(["$stateProvider", "$urlRouterProvider", function($stateProvider, $urlRouterProvider){
                	$stateProvider.state(config.routerPath, {
    	                url: "/" + config.routerPath,
    	                templateUrl: getServer() + "/" + config.templateUrl,
    	                controller : config.ctrlName
    	            })
                }]);
            })();
        }
        
        //配置全局路由
        var routerGlobal = [];
        app.config(['$stateProvider', '$urlRouterProvider',
            function($stateProvider, $urlRouterProvider) {
        		//全局state
	        	$stateProvider.state("welcome", {
	        		url: "/welcome",
	                templateUrl: getServer() + "/static/core/page/welcome/welcome.html",
	                controller : function($compile,$scope) {
    					require(["PDWelcomeDir/js/welcomeCtrl"], function (ctrl) {
    		                if (!ctrl) {
    		                	console.log("welcomeCtrl init error");
    		                	return ;
    		                }
    						ctrl($compile, $scope);
    		            });
    				}
	        	}).state("404", {
	        		url: "/404",
	        		templateUrl : getServer() + "/static/core/page/404.html"
	        	});
	        	//全局urlRouter
	        	$urlRouterProvider.when("", "welcome").otherwise("404");
            }
        ]);

        //监听全局状态路由事件
        app.run(["$rootScope", function($rootScope){
        	$rootScope.$on('$stateChangeSuccess', 
        			function(event, toState, toParams, fromState, fromParams){
        		var $a;
        		//1.更新菜单状态
        		//关闭上一个state对应的菜单状态
        		if (fromState && fromState.name){
        			var fromName = fromState.name;
        			$a= $("#sidebar-menu a[ui-sref=" + fromName + "]");
        			if ($a[0]) {
        				//将li移除active
        				var $li = $a.closest("li");
        				$li.removeClass("active");	
        				//将所有父li移除open active
        				var $li_p = $li.parentsUntil("#sidebar-menu", "li");
        				$li_p.removeClass("active");
        				if (needClose(toState)) {
        					$li_p.removeClass("open");
        				}
        				//将所有父ul设置display:none
        				var $ul_p = $li.parentsUntil("#sidebar-menu", "ul");
        				//$ul_p.css("display", "none");
        			}
        		}
        		//打开当前state对应的菜单状态
        		if (toState && toState.name) {
        			var toName = toState.name;
        			$a = $("#sidebar-menu a[ui-sref=" + toName + "]");
        			if ($a[0]) {
        				var $li = $a.closest("li");
        				//将li设置active
        				$li.addClass("active");
        				//将所有父li设置open active
        				var $li_p = $li.parentsUntil("#sidebar-menu", "li");
        				$li_p.addClass("open active");
        				//将所有父ul设置display:block
        				var $ul_p = $li.parentsUntil("#sidebar-menu", "ul");
        				//$ul_p.css("display", "block");
        			}
        		}
        		
        		//2.更新breadcrumbs状态
        		var breadcrumbs = [];
        		if ($a[0]) {
	        		var $aArr = $li_p.find("> a");
	        		var arr = $.makeArray($aArr);
	        		//将自己装进去
        			arr[arr.length] = $a[0];
        			$.each(arr, function(i, n) {
        				var text = $(this).text();
        				var href = $(this).attr("href");
        				breadcrumbs.push({
        					text : text,
        					href : href ? ("href=" + href) : ""
        				})
        			});
        		}
        		require(["text!PDModuleDir/ace/template/breadcrumbs.html", "PDModuleDir/artTemplate/template-debug"],function(html, Template){
        			var render = Template.compile(html);
        		    var html = render({items:breadcrumbs});
        		    $(".breadcrumb").html(html);
                });
        	});
        	
        	//判断当前菜单是否需要关闭
        	function needClose(state) {
        		return !(state.name == "404" || state.name == "welcome");
        	}
        }]);
        
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
