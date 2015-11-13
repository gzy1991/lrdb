/**
 * shortcut
 */
define(["PDModuleDir/artTemplate/template", "PDUtilDir/util"], function(Template, Util){
	
	//初始化
	function init() {
		//初始化已经有的
		initHas();
		//初始化所有的
		initAll();
		//初始化事件
		initEvent();
	}
	
	//变量
	//菜单的map
	var menuMap = {}
	
	//初始化已经选择的菜单数据
	function initHas() {
		$.ajax({
			url : getServer() + "/sword/shortcut/getByUser",
			success : function(data) {
				if (data) {
					var data_has = {
						data : data
					}
					var html = Template("shortcut_has", data_has);
					$(".shortcut-has").html(html);
				}
			}
		})
	}
	
	//初始化该用户所拥有的菜单数据
	function initAll() {
		$.ajax({
			url : getServer() + "/sword/menu/getMenuJson",
			data : {
				"SwordControllerName" : "getMenuJson",
				"level" : "2"
			},
			success : function(data) {
				if (data) {
					//根据数据初始化模板
					var data_sort = {
						data : data
					}
					var data_sort_panel = {
						data : data
					}
					var html = Template("shortcut_sort", data_sort);
					$(".shortcut-sort").html(html);
					
					html = Template("shortcut_sort_panel", data_sort_panel);
					$(".shortcut-sort-panel").html(html);
					//做map
					$.each(data, function(i, n) {
						menuMap[n.menu.menuId] = n;
						if (n.subMenu) {
							$.each(n.subMenu, function(j, n2) {
								menuMap[n2.menu.menuId] = n2;
							})
						}
					})
				}
				
			}
		})
	}
	
	function initEvent() {
		//监听[-]事件
		$(".shortcut-has").undelegate(".shortcut-icon", "click").delegate(".shortcut-icon", "click", function() {
			$(this).closest("li").remove();
		})
		//监听[+]事件
		$(".shortcut-sort-panel").undelegate(".shortcut-icon", "click").delegate(".shortcut-icon", "click", function() {
			var menuid = $(this).closest("li").data("menuid");
			var menu = menuMap[menuid];
			var $exist = isExist(menu);
			if (menu && !$exist) {
				var html = Template("shortcut_has_plus", menu);
				$(".shortcut-has").append($(html));
			} else {
				var $inner = $exist.find(".shortcut-item-inner"); 
				var i=0;
				var timer = setInterval(function(){
					i++;
					if (i % 2 != 0) {
						$inner.css({
							"backgroundColor":"#eee",
							"color":"#fff"
						});
					} else {
						$inner.css({
							"backgroundColor":"#fff",
							"color":"#000"
						})
					} 
					if (i == 8) {
						clearInterval(timer);
					}
				}, 100);
			}
		})
		//监听保存事件
		$("#btn_shortcut_save").off("click").on("click", function(){
			Util.confirm("确定保存修改吗？", function(){
				var arr = [];
				$(".shortcut-has .shortcut-item").each(function(i, n){
					arr.push({
						shortcutMenuId : $(this).data("menuid"),
						shortcutOrder : i
					})
				});
				$.ajax({
					url : getServer() + "/sword/shortcut/edit",
					data : {
						PdWebShortcut : arr
					},
					success : function(data) {
						Util.alert(data.message);
						if (data && data.success) {
							
						}
					}
				})
			})
		})
	}
	
	//判断是否已经存在
	function isExist(m) {
		var select = $(".shortcut-has .shortcut-item[data-menuid=" + m.menu.menuId + "]"); 
		return select.length > 0 ? select : false;
	}
	
	return {
		init : init
	}
})