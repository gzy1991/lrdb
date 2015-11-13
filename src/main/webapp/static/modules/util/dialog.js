/**
 * 弹出框组件
config = {
    id:"TestDialog",					//id,缓存的key
    url:"",								//远程模板地址
    body:"窗口中间内容",					//窗口内容
    cache:false,                        //是否缓存，默认为false
    title:"",							//title
    drag:false,							//是否可以拖动
    width:"400",						//宽度， 
    height:"100",						//高度
    dialogSize:"",                      //modal-lg或modal-sm
    defaultClose:true,					//是否显示“关闭”按钮，默认显示
    buttons:buttons,					//按钮
    afterLoad : null,					//模板dom加载完成回调
    //afterOpen : null,					//窗口弹出完成回调
    afterClose : null,					//窗口关闭完成回调
    *callback : function(dialog){}		//旧版本模板dom加载完成回调，不建议再使用
};
**/
define(["jquery", "Bootstrap"],function($){
    var cache={};

    function DialogInit(config){
        //合并参数
        config = $.extend({
        	id:"dialog_" + getUniqueId(),		//id,缓存key
    	    url:"",								//远程模板地址
    	    cache:false,                        //是否缓存，默认为false
    	    title:"Dialog",						//title
    	    drag:false,							//是否可以拖动
    	    //width:"300",						//宽度
    	    //height:"100",						//高度
    	    dialogSize:"",                      //modal-lg或modal-sm
    	    body:"",							//直接设置内容
    	    defaultClose:true,					//是否显示“关闭”按钮，默认显示
    	    buttons:[],							//按钮
    	    afterLoad : null,					//模板加载完成回调
    	    //afterOpen : null,					//窗口弹出完成回调
    	    afterClose : null,					//窗口关闭完成回调
    	    callback : null						//旧版本窗口弹出完成回调，不建议使用
        },config);
        //判断是否已缓存
        if (cache[config.id] && config.cache) {
            return cache[config.id];
        }
        //创建并返回新dialog
        return new Dialog(config);
    }

    DialogInit.dropCache = function(){
        for(var i in cache){
            if(cache.hasOwnProperty(i)){
                cache[i].$getDialog().remove();
            }
        }
        cache={};
    };

    DialogInit.getDialog = function(id){
        return cache[id];
    };
    
    //获取惟一id
    function getUniqueId() {
    	var date = new Date();
    	return date.getFullYear() + date.getMonth() + date.getDate() + date.getHours() + date.getMinutes() + date.getSeconds() + date.getMilliseconds();
    }
    
    //获取dom
    function loadDom(config, callback) {
    	var dom;
		var getDom = function() {
    		var deferred = $.Deferred();
    		
    		//如果设置body，直接返回
    		if (config.body) {
    			dom = config.body;
    			deferred.resolve();
    		}
    		//根据id查找本页dom元素
    		/*
    		$Dom = (config.id && $("#" + config.id));
    		if ($Dom && $Dom[0]) {
    			dom = $Dom.html();
    			deferred.resolve();
    		} else {*/
    			if (config.url) {
    				require(['text!'+config.url],function(html){
                        dom = html;
    					deferred.resolve();
    				})
    			} else {
    				deferred.resolve();
    			}
    		//}
    		
    		return deferred.promise();
    	}
    	
    	//监听
    	$.when(getDom()).done(function(){
    		typeof callback == "function" && callback.call(null, dom);
    	}).fail(function(){
    		console.log("加载dom失败，请确认body或id或url属性是否设置正确");
    	})
    }
    
    function Dialog(config){
        //Dialog HTML字符串
        var dialogHTML = [];
        dialogHTML.push('<div class="modal fade"'+(config.zIndex?' style="z-index:'+config.zIndex+'"':'')+'" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" id="'+ config.id +'">');
        var width = config.width?("width:"+parseFloat(config.width) + "px"):"";
        dialogHTML.push('<div class="modal-dialog '+(config.dialogSize||"")+'" style="'+width+'">');
        dialogHTML.push('<div class="modal-content">');
        var dragCss = config.drag ? 'style="cursor:move;"' : '';
        dialogHTML.push('<div class="modal-header" '+dragCss+'>');
        dialogHTML.push('<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>');
        dialogHTML.push('<h4 class="modal-title">'+ (config.title||"") +'</h4>');
        dialogHTML.push('</div>');
        var height = config.height?("height:"+parseFloat(config.height)+"px"):"";
        dialogHTML.push('<div class="modal-body" style="overflow-y:auto;overflow-x:hidden;'+height+'"></div>');
        var footStyle = 'style="border-bottom-right-radius:6px;border-bottom-left-radius:6px;padding:10px 20px 10px;background-color:#eff3f8;"';
        dialogHTML.push('<div class="modal-footer" '+footStyle+'></div>');
        dialogHTML.push('</div></div></div>');
        //生成dialog元素
        this.$dialog = $(dialogHTML.join(""));
        //将dialog添加到DOM页面
        $("body").append(this.$dialog);

        /*拖拽实现*/
        if(config.drag){
            var DRAG = {};
            this.$dialog.mousemove(function(e){
                if(DRAG.widget!=null){
                    DRAG.widget.style.left = (e.pageX - DRAG.widget.eLeft) +"px";
                    DRAG.widget.style.top = (e.pageY - DRAG.widget.eTop) +"px";
                }
            }).mouseup(function(e){
                DRAG = {}
            });

            this.$dialog.find("div[class='modal-header']").mousedown(function(e){
                DRAG.widget = this.parentNode;
                DRAG.widget.eLeft   = e.pageX - DRAG.widget.offsetLeft;
                DRAG.widget.eTop    = e.pageY - DRAG.widget.offsetTop;
            });
        }
        //保存this
        var _this = this;
        //获取dom内容
        loadDom(config, function(html){
        	_this.setBody(html);
        	//双向绑定支持，放到这里是为了解决需要编译的指令中需要依赖body中的元素
        	if(config.$compile && config.$scope){
        		//这里不能直接使用传进来的html参数来编译，因为指令可能会修改上面body设置的html结构
                var link = config.$compile(_this.$dialog.find("div[class='modal-body']").html());
                _this.setBody($(link(config.$scope)));
                config.$scope.$digest();
            }
        	
        	//dom加载完成事件
        	typeof config.afterLoad == "function" && config.afterLoad.call(null);
        	//兼容callbac设置
        	typeof config.callback == "function" && config.callback.call(null);
        });
        //生成底部buttons
        this.setFoot(config.buttons||[], config.defaultClose);
        //设置缓存
        config.cache && (cache[config.id] = this);
        //监听关闭事件
        this.$dialog.on('hidden.bs.modal', function (e) {
            !config.cache && $(_this.$dialog).remove();
            typeof config.afterClose == "function" && config.afterClose.call(null);
        });
        this.$dialog.modal(config.modal);
        //(typeof config.callback == "function")?config.callback(this):null;
    }

    //模块通用方法(扩展)
    Dialog.fn = Dialog.prototype = {
        //对象方法扩展API
        extend : function(object){
            if (typeof object === "object" && object.constructor === Object){
                $.extend(Dialog.fn,object);
            }
        },
        $getDialog : function(){
            return this.$dialog;
        },
        show : function(){
            this.$dialog.modal('show');
        },
        hide : function(){
            this.$dialog.modal("hide");
        }
    };

    //对象原型方法
    Dialog.fn.extend({
        setTitle : function(title){
            if (!this.$title) {
                this.$title =  this.$dialog.find("h4[class='modal-title']");
            }
            this.$title.empty().append(title);
        },
        setBody : function(body){
            if (!this.$body) {
                this.$body = this.$dialog.find("div[class='modal-body']");
            }
            this.$body.empty().append(body);
        },
        setFoot : function(buttons, defaultClose){
            var dialog = this;
            if (!this.$foot) {
                this.$foot = this.$dialog.find("div[class='modal-footer']");
            }
            var close = typeof(defaultClose)=="undefined" ? true: defaultClose;
            this.$foot.empty();
            if(buttons && buttons.length){
                for(var i= 0,b;b=buttons[i++];){
                    this.$foot.append(
                        $('<button'+ (b.id?' id="'+ b.id +'"':'')+' type="button" class="btn btn-primary" '+ (b.close?'data-dismiss="modal"':'')+'>'+ b.name +'</button>')
                            .bind("click",(function(){
                                var callback = b.callback;
                                return function () {
                                    callback && callback(dialog);
                                }
                            })())
                    );
                }
            }
            this.$foot.append(close?'<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>':"");
        }
    });
    

    return DialogInit;
});