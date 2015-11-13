/// <reference path="../../../../temp/declare.doc .js" />
/// <reference path="lang.js" />
/// <reference path="../../jquery/jquery-2.1.3.min.js" />
(
function (factory) {
     
    if(typeof  define==="function")
    {
        define(["./lang", "./declare", "jquery"], factory)
    }else
    {
        this["PdwebWidgetBase"] = factory(PdwebLang, PdwebDeclare);
    }

}
(function (lang, declare) {
     
    ///<summary></summary>
    ///<param name="lang" value="PdwebLang"></param>
    ///<param name="declare" value="PdwebDeclare"></param>
    function widgetBase()
    {
       
    }
    widgetBase.prototype.On=function(selector,eventName,eventFunction,functionScope,data)
    {
        ///<summary>绑定eventName事件函数（eventfunction）向selector 指定的对象，并指定funttionscope作为函数this，</summary>
        ///<param name="selector" type="String"  > 选择器</param>
        ///<param name="eventName" type="String">事件名称，参见jquery事件</param>
        ///<param name="eventfunction" type="Function">事件回教函数</param>
        ///<param name="functionScope" type="Object">事件this对象，undefined时，原生的this</param>
        var sco = functionScope
        if (typeof functionScope == "undefined")
        {
            sco = this;
        }
        $(selector).on(eventName, data, lang.hitch(sco, eventFunction));
    }
    widgetBase.prototype.hitch = function (callbackFunction, thisObj) {
        ///<summary>钩子函数</summary>
        if (typeof thisObj === "undefined")
            thisObj = this;
        return lang.hitch(thisObj, callbackFunction)
    }
    return widgetBase;
}))