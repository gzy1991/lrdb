define(["PDUtilDir/util",
        "ZTree",
        "css!ZTreeCss",
        "css!PDAclDir/style/acl"], function(Util){
	
	//初始化
	var init = function() {
		initSearchText();
	};
	
	//搜索输入框id
	var textServiceSearchId = "text_serviceSearch";
	//搜索按钮
	var btnServiceSearch = "btn_serviceSearch";
	//搜索结果树
	var treeServiceSearchId = "tree_serviceSearch";
	var loadingServiceSearchId = "loading_serviceSearch";
	//搜索的form表单
	var form_authServiceSearch_id = "form_authServiceSearch";
	
	//初始化搜索框事件
	function initSearchText() {
		var timer = null;
		//监听表单提交事件并阻止
		$("#" + form_authServiceSearch_id).on("submit", function(){
			return false;
		})
		//监听搜索框输入keyup事件
		$("#" + textServiceSearchId).on("keyup", function(evt) {
			clearTimeout(timer);
			var search = $(this).val();
			if (!validateSearch(search)) return ;
			if (evt.keyCode == 13) {//回车
				searchService(search);
			} else {
				timer = setTimeout(function(){
					searchService(search);
				}, 300);
			}
		});
		//监听查询按钮事件
		$("#" + btnServiceSearch).on("click", function() {
			var search = $("#" + textServiceSearchId).val();
			if (!validateSearch(search)) return ;
			searchService(search);
		})
	}
	
	//校验search
	function validateSearch(search) {
		if (!search) return false;
		return true;
	}
	
	//执行搜索
	function searchService(search) {
		if (search) {
			$.fn.zTree.destroy(treeServiceSearchId);
			$.ajax({
				url : getServer() + "/sword/auth/res/searchService",
				data : {
					search : search
				},
				success : function(data) {
					//$("." + loadingServiceSearchId).hide();
					var setting = {
							data: {
								key : {
									//name:"resName"
									name : "resText"
								},
								simpleData: {
									enable: true,
									idKey:"resId",
									pIdKey:"resPid",
									rootPId:null
								}
							},
							view : {
								selectedMulti : false //单选
							},
							check : {
								enable : true
							},
							callback : {
								onClick:function (event, treeId, treeNode) {
		                            //单击节点展开
		                            $.fn.zTree.getZTreeObj(treeServiceSearchId).expandNode(treeNode);
		                        }
							}
					}
					if (data && data.length > 0) {
						data.splice(0, 0, {resText : "查找结果", open : true});
					} else {
						data.splice(0, 0, {resText : "无结果"});
						delete setting.check;
					}
					$.fn.zTree.init($("#" + treeServiceSearchId), setting, data);
				}
			})
		}
	}
	
	//确认
	function confirm(callback) {
		var treeObj = $.fn.zTree.getZTreeObj(treeServiceSearchId);
		if (treeObj) {
			//获取选择的资源
			var nodes = treeObj.getCheckedNodes(true);
			if (!nodes || nodes.length == 0) {
				Util.alert("请勾选要添加的资源！");
				return ;
			}
			//获取保存类型
			var saveType = $("input[name=saveType]:checked").val();
			//获取选择的资源目录树节点
			var dirNodes = $.fn.zTree.getZTreeObj("tree_resDir").getSelectedNodes(); 
			var dirNode = dirNodes && dirNodes[0];
			var dirName = dirNode && dirNode.resName;
			var dirId = dirNode && dirNode.resId;
			if (!dirNode) {
				Util.alert("请选择资源目录树节点");
				return ;
			}
			//var confirmStr = dirName ? "确定要把选择的资源服务添加到【" + dirName + "】吗？" : "未指定资源目录，确定将选择的资源服务添加到根目录下吗";
			//Util.confirm(confirmStr, function() {
				var result = [];
				$.each(nodes, function(i, n){
					var json = {};
					if (n.resType == saveType && !n.isExist) {
						json.resName = n.resName;
						json.resUrl = n.resUrl;
						result.push(json);
					}
				})
				$.ajax({
					url : getServer() + "/sword/auth/res/saveResByService",
					data : {
						resList : JSON.stringify(result),
						resPid : dirId || ""
					},
					success : function(data) {
						Util.alert(data.message);
						if (data.success) {
							typeof callback == "function" && callback();
						}
					},
					error : function() {
					}
				});
			//});
		} else {
			Util.alert("请先查找你要的资源");
		}
	}
	
	return {
		init : init,
		confirm : confirm
	}
})