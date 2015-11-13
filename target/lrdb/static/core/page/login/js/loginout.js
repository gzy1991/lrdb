/// <reference path="../../../modules/jquery/jquery-2.1.3.js" />
define("PDLoginDir/js/loginout", ["jquery"], function ()
{
  


    var ret = {
        redirectUrl: undefined,
        loginoutUrl:"/sword/loginout"
    };
    ret._onSucsess=function(data)
    {
        if(data.success&&data.status=="0")
        {
            var s = (!!this.redirectUrl) ? this.redirectUrl : getServer() + data.data;
            window.location.href = s;
        }
    };
    ret.onSuccess = function (data) {

        return true;
    };
    ret._onError=function (data) {
        if (this.onError(data)) {
            var s = (!!this.redirectUrl) ? this.redirectUrl : data.data.url;
            window.location.href = s;
        }
    };
    ret.onError = function (data) { return true };
    ret.Logout = function (o) {
        $.ajax(
            {
                global: false,//禁用全局ajax事件
                url: getServer() + this.loginoutUrl,
                timeout: 6000,
                asny:false,
                data: {
                    "SwordControllerName": "loginout",
                    opType:o?o:0
                },
                success:this._hitch(this,this._onSucsess),
                error:  this._hitch(this,this._onError)
            }
            )
    };
    ret._hitch = function (/*Object*/scope, /*Function|String*/method) {

        //if (!method) {
        //    method = scope;
        //    scope = null;
        //}
        //if (d.isString(method)) {
        //    scope = scope || d.global;
        //    if (!scope[method]) { throw (['dojo.hitch: scope["', method, '"] is null (scope="', scope, '")'].join('')); }
        //    return function () { return scope[method].apply(scope, arguments || []); }; // Function
        //}
        return function () { return method.apply(scope, arguments || []); }; // Function
    };
    ret.init = function () {
        // window.onunload = this._hitch(this, this._closewindow);
        //去掉 2015-06-09
        $.ajax(
           {
               global: false,//禁用全局ajax事件
               url: getServer() + this.loginoutUrl,
               timeout: 6000,
               asny: true,
               data: {
                   SwordControllerName: "loginout",
                   opType: 2
               },
               success: this._hitch(this, this._fetchUserSuccess)
           }
           )
    };
    ret._closewindow=function()
    {
        this.Logout(1);

    }
    ret._fetchUserSuccess=function(data)
    {
        if(data.success)
        {
            //var sName = data.data+'<i class="ace-icon fa fa-caret-down"></i>';
            var sName = data.data;
            $("#pd_web_username_home").html(sName);
        }
    }
    return  ret;
})