/*
* config = {
*   id : "", //页面锚点id
*   itemWidth : "", //规定每个查询组件的宽度
*   items : [
*       {
*           field : "",
*           name : "",
*           type: ""
*       }
*   ],
*   toolbar : [
*       {
*           id : "",
*           name : "",
*           icon : "",
*           click : function(){}
*       }
*   ]
* }
*/
define(["jquery","css!PDUtilDir/css/searchPanel.css"],function($){
    //表单元素类型及通用api方法
    var pluginType = {
        //默认类型
        "default" : {
            create : function(setting){
                return $('<div class="'+setting.type+' searchItem input-group" style="width:'+itemWidth+'">'+
                '<label class="input-group-addon" for="'+setting.field+'">'+setting.name+'</label>'+
                '<input class="form-control" type="text" id="'+setting.field+'" name="'+setting.field+'"></div>');
            },
            validate : function(){

            },
            getValue : function(){

            },
            setValue : function(){

            }
        }
    },itemWidth;
    return function init(config){
        if(!config||!config.id){return false}
        itemWidth = config.itemWidth||'50%';
        var items = config.items||[],
            $wrapper = $("#"+config.id).empty(),
            $searchPanel = $('<div class="searchPanel form-inline"></div>'),
            $searchToolbar = $('<div class="searchToolbar"></div>');
        for(var i= 0,len=items.length,$item;i<len;i++){
            items[i].type=items[i].type||"default";
            $searchPanel.append(pluginType[items[i].type].create(items[i]));
        }
        $searchPanel.children().length>0?$wrapper.append($searchPanel):false;
        if(config.toolbar&&config.toolbar.length){
            for(var j= 0,btn,$btn;j<config.toolbar.length;j++){
                btn = config.toolbar[j];
                $btn = $('<a'+(btn.id?' id="'+btn.id+'"':'')+' class="btn btn-default">' +
                    '<i class="'+btn.icon+'"></i>'+(btn.name?btn.name:'查询')+'</a>');
                typeof btn.click=="function"?$btn.on("click",btn.click):false;
                $searchToolbar.append($btn);
            }
            $searchToolbar.children().length>0?$searchPanel.append($searchToolbar):false;
        }
    }
});