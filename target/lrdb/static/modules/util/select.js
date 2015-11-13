/*
 * jQuery插件, 在选中select元素后直接调用, 如下
 * $(select).csSelect();        //直接将原select元素替换为改写的select组件
 * $(select).csSelect(data);    //将页面元素替换为改写的select组件, 数据由参数传入
 * $(select).csSelect(data,fn); //将页面元素替换为改写的select组件, 传入数据和选中数据时的回调函数
 * 该组件获取和设置数据由独立API进行操作, 需要传入组件元素$select
 *      获取值 $.fn.csSelect.val($select)
 *      设置值 $.fn.csSelect.val($select,value)
 *      获取文本内容 $.fn.csSelect.text($select)
 * 需要注意的是, 由于该组件直接替换了之前的元素, 所以当使用独立API进行操作时, 需要利用组件类(.cs-select)重新获取组件元素$select
 */
define(["jquery","css!PDUtilDir/css/csSelect.css"],function($){
    var store={};
    $.fn.csSelect=function(data,onSelect){
        if(arguments.length>2){return false;}
        else if(arguments.length==1){
            onSelect=data;
            data=null;
        }
        $(this).each(function(){
            var $wrap = $("<div class='cs-select'></div>")
                            .addClass(this.className)
                            .attr("id",this.id)
                            .attr("style",$(this).attr("style")),
                $select = $("<input class='cs-select-input form-control' type='text' />"),
                $panel = $("<ul class='cs-select-panel'></ul>"),
                $fragment = $(document.createDocumentFragment()),
                id;
            do{
                id = "csSelect_"+Math.floor(Math.random()*1000000)
            }while(store[id]);
            store[id]={};
            $wrap.append($select.attr("id",id)).append($panel);
            if(data){
                for(var i= 0,len=data.length;i<len;i++){
                    store[id][data[i].value]=data[i].name;
                }
            }else{
                var $options = $(this).children("option");
                for(var i= 0,len=$options.length;i<len;i++){
                    store[id][$($options[i]).val()]=$($options[i]).text();
                }
            }
            for(var value in store[id]){
                if(store[id].hasOwnProperty(value)){
                    $fragment.append($("<li class='cs-select-item'></li>").data("value",value).text(store[id][value]));
                }
            }
            $panel.append($fragment);
            $(this).replaceWith($wrap);

            $select.on("click",function(){
                var _this = this,
                    evt = "click.csSelect_"+this.id;
                if($panel.is(":hidden")){
                    $panel.show();
                    $(document).on(evt,function(event){
                        if(event.target==_this){return false}
                        $panel.hide();
                        $(document).off(evt);
                    })
                }else{
                    $panel.hide();
                    $(document).off(evt);
                }
            }).on("focus",function(){
                $(this).blur();
            });
            $panel.on("click",".cs-select-item",function(){
                $select.val($(this).text()).data("value",$(this).data("value"));
                onSelect?onSelect.call($wrap[0],$(this).text(),$(this).data("value")):false;
            });
        });
    };
    $.fn.csSelect.val = function($wrap,value){
        if(!$wrap||$wrap.length!=1||!$wrap.is(".cs-select")||!$wrap.has(".cs-select-input")){return false}
        var $select = $wrap.children(".cs-select-input"),
            id = $select[0].id;
        if(value){
            $select.val(store[id][value]).data("value",value);
            value = store[id][value];
        }else{
            value = $select.data("value");
        }
        return value;
    };
    $.fn.csSelect.text = function($wrap){
        if(!$wrap||$wrap.length!=1||!$wrap.is(".cs-select")||!$wrap.has(".cs-select-input")){return false}
        return $wrap.children(".cs-select-input").val();
    };
    return {};
});