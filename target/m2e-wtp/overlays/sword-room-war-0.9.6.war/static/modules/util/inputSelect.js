/**
 * Created by Henry on 15-6-3.
 */
/**
 config = {
    id : id,        //element ID
    multi : true,  //
    searchAble : true,    //当数据为多层级,需树状显示时, 并提供关键字检索功能
    data : url,     //url,[]
    callback : function(data,arrObj){}, //data:所有选中数据id的数组,arrObj:所有选中数据对象的数组,
    key : {
        id : "id",
        name : "name",
        data : "data"
    },
    placeholder:"",
    initData:[]
 }
 **/
define(["jquery","ZTree","css!ZTreeCss","css!PDUtilDir/css/inputSelect.css"],function($){
    var cache = {}, //模块内部缓存对象
        selectEvent = "mouseup"; //设置在input上触发下拉面板的事件

    //初始化函数
    function init(config){
        var input = new Input(config);
        cache[config.id] = input;
        return input;
    }
    //获取inputSelect对象
    init.getInput = function(id){
        return cache[id];
    };
    //删除缓存,可指定id或清空所有缓存
    init.dropCache = function (id) {
        if(typeof id=="string"&&id){
            delete cache[id];
        }else{
            cache={};
        }
    };
    //inputSelect类
    function Input(config){
        var $input = $("#"+config.id),
            _this = this;
        if(!$input.parent(".inputWrapper").length){
            $input.addClass("inputSelect").wrap('<div id="inputWrapper_'+config.id+'" class="inputWrapper"></div>');
        }else{
            $input.siblings(".inputPanel").remove();
        }
        config.multi?$input.addClass("multi"):false;
        //hack,兼容旧版本onSelect函数API
        !config.callback?function(){config.callback=config.onSelect;delete config.onSelect}():false;
        this.config = $.extend(true,{
            multi : false,
            searchAble : false,
            initData : [],
            setting:{},
            key:{
                id:"id",
                name:"name",
                data:"data"
            }
        },config);
        //配置内置ztree
        this.config.setting = $.extend(true,{
            check : {
                enable : this.config.multi,
                chkboxType : {"Y":"","N":""}
            },
            data : {
                key : {
                    name : this.config.key.name,
                    children : this.config.key.children||this.config.key.data //key.data兼容旧版本
                }
            },
            callback : {
                onCheck : function (event, treeId, treeNode) {
                    _this.setDataSet(treeNode,treeNode.getCheckStatus().checked);
                    _this.fillInput();
                },
                onClick : function (event, treeId, treeNode, clickFlag) {
                    if(!_this.config.multi){//单选
                        _this._dataSet={};
                        _this.setDataSet(treeNode,true);
                        _this.hidePanel();
                    }else{ //多选
                        _this._treeObj.checkNode(treeNode);
                        _this.setDataSet(treeNode,treeNode.getCheckStatus().checked);
                    }
                    _this.fillInput();
                }
            }
        },this.config.setting);
        //配置simpleData的ztree额外设置
        if(!!this.config.simpleData){
            this.config.setting.data.simpleData={
                enable : true,
                idKey : this.config.key.id,
                pIdKey : this.config.key.pid,
                rootPId : this.config.key.rootId
            };
        }
        this._dataSet={}; //当前对象选中数据id为key的map对象
        this.$input = $input;
        this.$wrap = $input.parent();
        this.initPanel();
        this.bindEvent();
    }
    //inputSelect类的原型
    Input.fn = Input.prototype = {
        //初始化面板
        initPanel : function(){
            this.$panel = $('<div class="inputPanel"></div>');
            this.config.searchAble?this.$panel.append("<input class='panelSearch form-control'>"):false;
            this.$content = this.config.multi?$("<div class='inputContent'></div>"):null;
            this.$wrap.append(this.$panel).append(this.$content);
            //disabled readonly
            if (!this.$input.is("input:disabled, input[readonly]")) {
            	this.$wrap.append("<div class='clearAllValue'><i class='fa fa-trash-o'></i></div>")
            }
            //设置placeholder
            if (this.config.placeholder) {
            	this.$placeholder = $("<div class='inputPlaceholder'></div>").html(this.config.placeholder).appendTo(this.$wrap);
				this.$placeholder.css("line-height", this.$placeholder.height() + "px");
            }
            this.initPanelData();
        },
        //初始化面板数据
        initPanelData : function(){
            var _this = this,
                data = this.config.data;
            if (typeof data !== "string") {
                _this.fillPanelData(data);
            } else {
                $.ajax({
                    type : "GET",
                    url : data,
                    dataType : "json",
                    success : function(data){
                        _this.fillPanelData(data);
                    },
                    error : function(){
                        console.log("数据获取失败");
                    }
                });
            }
        },
        //填充面板数据,初始化ztree
        fillPanelData : function(data){
            if(!this.$ztree){
                this.$ztree = $('<ul id="tree_'+this.config.id+'" class="ztree"></ul>');
                this.$panel.append(this.$ztree);
            }
            $.fn.zTree.destroy("tree_"+this.config.id);
            this._treeObj = $.fn.zTree.init(this.$ztree,this.config.setting,data);
            this.dataInit(this.config.initData);
        },
        getTreeObj : function(){
            return this._treeObj;
        },
        //刷新面板数据
        refreshPanel : function(data){
            this.fillPanelData(data);
        },
        //初始化选中数据
        dataInit : function(ids){ //ids 为id数组
            var treeObj = $.fn.zTree.getZTreeObj("tree_"+this.config.id),
                dataMap = {},nodes,key=this.config.key;
            if(!ids){
                return false;
            }else{
                treeObj.checkAllNodes(false);
                this.clearDataSet();
            }
            for(var i= 0,length=this.config.multi?ids.length:1;i<length;i++){
                dataMap[ids[i]]=true;
            }
            nodes = treeObj.getNodesByFilter(function(node){
                return !!dataMap[node[key.id]];
            });
            for(var j= 0,len=nodes.length;j<len;j++){
                this.setDataSet(nodes[j],true);
                this._treeObj.checkNode(nodes[j],true);
            }
            this.fillInput();
            resetZTreeStatus("tree_"+this.config.id);
        },
        //设置选中数据
        setDataSet : function (node,status) {
            var key = this.config.key;
            if(typeof status == "undefined"){
                if(!this._dataSet[node[key.id]]){
                    this._dataSet[node[key.id]]={
                        val : node[key.name],
                        tid : node.tId
                    };
                }else{
                    delete this._dataSet[node[key.id]];
                }
            }else{
                if(status){
                    this._dataSet[node[key.id]]={
                        val : node[key.name],
                        tid : node.tId
                    };
                }else{
                    delete this._dataSet[node[key.id]];
                }
            }
        },
        //清空选中数据
        clearDataSet : function(){
            this._dataSet={};
        },
        //回填input或者多选内容面板
        fillInput : function(){
        	var _this = this;
            var idArr=[],valArr=[],
                dataSet=this._dataSet;
            //先清空$content
            this.config.multi?this.$content.empty():false;
            //判断dataSet是否为空
            (function(){
            	var hasProp = false;
            	for (var prop in dataSet) {
            		hasProp = true;
            		break;
            	}
            	if (!hasProp) {
            		_this.$placeholder && _this.$placeholder.show();
            	} else {
            		_this.$placeholder && _this.$placeholder.hide();
            	}
            })();
            for(var id in dataSet){
                if(dataSet.hasOwnProperty(id)){
                    idArr.push(id);
                    valArr.push(dataSet[id].val);
                    if(this.config.multi){
                        this.$content.append("<a id='"+id+"'>"+dataSet[id].val+"<span class='remove'>x</span></a>");
                    }
                }
            }
            this.$input.val(valArr.join(",")).data("id",idArr.join(","));
            this.setInputStatus();
        },
        //清空input内容
        clearInput : function(){
            this.$input.val("").data("id","");
        },
        //获取当前选中数据
        getCurrentData : function(){
            var dataSet = this._dataSet,
                treeObj = this._treeObj,
                idArr=[],dataArr=[];
            for(var id in dataSet){
                if(dataSet.hasOwnProperty(id)){
                    idArr.push(id);
                    dataArr.push(treeObj.getNodeByTId(dataSet[id].tid));
                }
            }
            dataArr.idArr = idArr;
            return dataArr;
        },
        //显示下拉面板
        showPanel : function(){
            this.bindDocumentEvent();
            this.$panel.show();
            //this._tempDataSet = this._dataSet;//记录打开面板时的数据
            this._tempDataSet = $.extend({},this._dataSet);
        },
        //隐藏下拉面板
        hidePanel : function(){
        	if (this.isDataChanged()) {
        		this.$input.trigger("dataChanged");
        	}
            this.unbindDocumentEvent();
            this.$panel.hide();
            this.$panel.children(".panelSearch").val("").keyup();//重置ztree状态
        },
        isDataChanged : function() { //判断数据是否改变
        	var o = this._tempDataSet,
        		n = this._dataSet,
        		length_o = 0,
        		length_n = 0;
        	for (var i in n) {
        		if (typeof o[i] == "undefined") {
        			return true;
        		}
        		length_n++;
        	}
        	for (var i in o) {
        		length_o++;
        	}
        	if (length_o != length_n) {
        		return true;
        	}
        	return false;
        },
        togglePanel : function(){
            this.$panel.is(":visible")?this.hidePanel():this.showPanel();
        },
        setInputStatus : function(){
        	//hasValue目前用来删掉下拉三角图标
            !this.$input.val()&&this.$wrap.is(".hasValue")&&this.$wrap.removeClass("hasValue");
            this.$input.val()&&this.$wrap.is(":not(.hasValue)")&&this.$wrap.addClass("hasValue");
        },
        //搜索数据,展开相应节点
        searchPanelData : function (content) {
            var nodes = this._treeObj.getNodesByParamFuzzy(this.config.key.name,content);
            for(var i= 0,length = nodes?nodes.length:0;i<length;i++){
                expandParentNodes(this._treeObj,nodes[i],true);
            }
        },
        //绑定事件
        bindEvent : function(){
            var _this = this;
            //输入框点击事件
            this.$input.on(selectEvent,function(event){
                if($(this).is(":disabled,[readonly]")){return false;}
                _this.togglePanel();
            }).on("focus",function(){
                $(this).blur();
            });
            //多选标签面板事件
            this.config.multi?this.$content.on("click",".remove", function (event) {
				if (!_this.$input.is("input:disabled, input[readonly]")) {
					event.stopPropagation();
					var id = $(this).parent().attr("id");
					//checkNoe
					_this._treeObj.checkNode(_this._treeObj.getNodeByTId(_this._dataSet[id].tid),false);
					delete _this._dataSet[id];
					_this.fillInput();
					$(this).parent().remove();
					//如果是关闭状态就触发callback
					if(_this.$panel.is(":hidden")){
						_this.$input.trigger("dataChanged");
					}
				}
            }).on("click", function (event) {
                _this.$input[selectEvent]();
            }):false;
            /*.on("mouseenter",function(){
             $(this).on("mousewheel",function(){
             $(this).children("a:first-child").animate({"left":"+10px"});
             });
             }).on("mouseleave",function(){
             $(this).off("mousewheel");
             })*/
            this.$wrap.find(".clearAllValue").on("click",function(){
                if(_this.config.multi){
                    _this.$content.empty();
                }
                _this._treeObj.checkAllNodes(false);
                _this._dataSet={};
                _this.fillInput();
                //如果是关闭状态就触发callback
                if(_this.$panel.is(":hidden")){
                	_this.$input.trigger("dataChanged");
                	/*
                    var dataArr = _this.getCurrentData();
                    //触发callback
                    _this.config.callback(dataArr.idArr,dataArr);
                    */
                }
            });
            //监听数据是否改变
            this.$input.on("dataChanged", function() {
            	//console.log("data changed");
            	var dataArr = _this.getCurrentData();
            	_this.config.callback && _this.config.callback(dataArr.idArr, dataArr);
            });
            //数据搜索事件
            if(!!this.config.searchAble){
                var trigger=null,
                    lastContent=null,
                    status=true;
                this.$panel.children(".panelSearch").on("keyup",function(event){
                    if($.trim($(this).val())==lastContent){return false;}
                    lastContent=$.trim($(this).val());
                    if(trigger){window.clearTimeout(trigger);}
                    trigger=window.setTimeout(function(){
                        trigger=null;
                        clearAllNodesVisibleStatus(_this.$ztree);
                        if(!lastContent){
                            status = true;
                            setTreeVisibleStatus(_this.$ztree,status);
                        }else{
                            status = false;
                            //_this._treeObj.hideNodes(_this._treeObj.getNodesByFilter(function(node){
                            //    return !node.isHidden;
                            //}));
                            setTreeVisibleStatus(_this.$ztree,status);
                            _this.searchPanelData(lastContent);
                        }
                    },400);
                })
            }
        },
        //绑定document事件,用于处理点击隐藏面板,以及单页多个对象的兼容性问题
        bindDocumentEvent : function(){
            var _this = this;
            $(document).bind(selectEvent+".inputSelect_"+this.config.id,function(event){
                if(!_this.$wrap.has(event.target).length){
                    _this.hidePanel();
                }
            });
        },
        //解绑document事件
        unbindDocumentEvent : function(){
            $(document).unbind(selectEvent+".inputSelect_"+this.config.id);
        }
    };
    //重置ztree状态
    function resetZTreeStatus(treeId){
        var treeObj = $.fn.zTree.getZTreeObj(treeId),
            $tree = $("#"+treeId),
            $nodes = $tree.children(),nodes;
        if (!treeObj) { return false;}
        setTreeVisibleStatus($tree,true);
        clearAllNodesVisibleStatus($tree);
        treeObj.expandAll(false);       //闭合所有节点
        treeObj.cancelSelectedNode();       //取消所有selected状态
        if ($nodes.length==1) {
            treeObj.expandNode(treeObj.getNodeByTId($nodes.first().attr("id")),true);
        }
        nodes = treeObj.getCheckedNodes();      //获取所有checked状态nodes
        for(var i= 0,length = nodes.length;i<length;i++){
            expandParentNodes(treeObj,nodes[i]); //展开checked状态node的父节点
        }
    }
    //自下而上展开当前节点至根节点的所有祖先节点
    function expandParentNodes(treeObj,node,status){
        var $tree = $("#"+treeObj.setting.treeId);
        status?setNodeVisibleStatus($tree.find("#"+node.tId)):false;
        var parentNode = node.getParentNode();
        if(parentNode){
            treeObj.expandNode(parentNode,true);
            expandParentNodes(treeObj,parentNode,status);
        }
    }
    //设置用于搜索功能的节点显隐模式
    function setTreeVisibleStatus($tree,status){
        if((status&&$tree.is(".hideNode"))||(!status&&!$tree.is(".hideNode"))){
            $tree.toggleClass("hideNode");
        }
    }
    //清除所有显隐状态
    function clearAllNodesVisibleStatus($tree){
        $tree.find(".showNode").removeClass("showNode");
    }
    //设置节点为显示状态
    function setNodeVisibleStatus($node){
        if(!$node.is(".showNode")){
            $node.addClass("showNode");
        }
    }

    return init;
});