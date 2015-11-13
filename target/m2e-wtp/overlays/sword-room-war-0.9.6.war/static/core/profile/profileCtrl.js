/// <reference path="../page/login/widget/base/declare.js" />
/// <reference path="../page/login/widget/form.js" />

define(["jquery"], function ($) {

    return function ($compile, $scope) {
        require(["static/core/profile/js/shortcut",
                 "static/core/profile/js/loginLog",
                 "static/core/profile/js/form", 
                 "PDLoginDir/js/rsa",
                 "Date", "DateCN", "css!DateCss"], function (Shortcut, Log, form, rsa) {
            ///<summary></summary>
            ///<param name="form" value="PdwebFormBase"></param>
        	//初始化菜单
        	Shortcut.init();
        	//初始化登录日志
        	Log.init();
        	
            var f = new form();
            var fpswd = new form();
            fpswd.formSelector = "#pd_web_password_editor";
            fpswd.btnSubmitSelector = "#pd_web_save_pswd_btn";
            fpswd.keyAl = "";
            fpswd.keyEn = "";
            fpswd.submitUrl = getServer() + "/sword/login/profile?SwordControllerName=pdwebprofile";
            fpswd.initValidate(
                {
                    rules: {
                        pd_web_old_pswd: {required:true},
                        pd_web_new_pswd_1: {
                            required: true,
                            PD_ZS: true,
                            minlength: 5,
                            maxlength: 15
                        },
                        pd_web_new_pswd_2: {
                            required: true,
                            PD_ZS: true,
                            minlength: 5,
                            maxlength:15
                        }
                    },
                    messages: {
                        pd_web_old_pswd: "请填写原密码"
                    },
                    errorPlacement:  function (error, element) { 
                        $(element).after(error);
                    },
                    Onubmit: false,
                    onfocusout: false,
                    onkeyup: false,
                    onclick: false
                }
                );
            fpswd.init();
            fpswd.getFormDataAfterFilter = function (data) {
                if(data.pd_web_new_pswd_1===data.pd_web_new_pswd_2)
                {
                    var d = { opType: 3 };
                    var s = data.userUuid;
                    s += "_";
                    s += data.pd_web_old_pswd + "_";
                    s += data.pd_web_new_pswd_1;
                    var rsaKey = rsa.getKeyPair(this.keyEn, "",this.keyAl);
                    d.pswd = rsa.encryptedString(rsaKey, s.split("").reverse().join(""));
                   return  d;
                }else
                {
                    
                    alert("新密码与新密码校验不一致")
                }
                return undefined;
            };
            //取pulicKey 回调
            fpswd.onInitDataSuccess = function (data) {
                if(data.success)
                {
                    var s = data.data;
                    var ss = s.split('_');
                    this.keyAl = ss[0];
                    this.keyEn = ss[1];
                }else
                {
                    alert("加密错误");
                }
            };
            fpswd.onInitDataError=function(r,error,thows)
            {
                alert("加密错误");
            }
            fpswd.on
            //-------
            f.btnSubmitSelector = "#pd_web_save_profile_btn";
            f.formSelector = "#pd_web_userInfo_editor";
            var  initUrl = getServer() + "/sword/login/profile?SwordControllerName=pdwebprofile";
            f.submitUrl = getServer() + "/sword/login/profile?SwordControllerName=pdwebprofile";
            f.setFormDataBefore = function (data) {
                fpswd.setFormData({
                    userCode: data.userCode,
                    userUuid: data.userUuid,
                    userName: data.userName
                });
                fpswd.FetchInitData(getServer() + "/sword/login/profile?SwordControllerName=pdwebprofile", {opType:2});
                return data;
            }

            f.init();
            f.FetchInitData(initUrl, { opType: 0 });
            var v = {
                rules: {
                    birthday: {required:false},
                    officePhone: {
                        PD_officePhone: true,
                        minlength: 0
                    },
                    phone: {
                        PD_mobile: true,
                        minlength: 0
                    },
                    //sex: "required",
                    fax: {
                        PD_fax: true,
                        minlength: 0
                    },
                    email: {
                        //minlength: 0,
                        PD_mail: true, minlength: 0
                    }
                },
                messages: {
                    birthday: "请填写生日"
                },
                errorPlacement: function (error, element) { 
                    $(element).after(error);
                },
                Onubmit: false,
                onfocusout: false,
                onkeyup: false,
                onclick: false
            };
            f.initValidate(v);
            f.getFormDataAfterFilter=function(data)
            {
                data.opType = 1;
                return data;
            }
            var dateTimeConfig = {
                //设置使用语言：cn是自定义的中文版本，还可以扩展其他语言版本
                language: "cn",
                //输出格式化
                format: 'yyyy-mm-dd',
                //直接选择‘今天’
                todayBtn: true,
                //设置最精确的时间选择视图
                minView: 'month',
                //高亮当天日期
                todayHighlight: true,
                //选择完毕后自动关闭
                autoclose: true
            };
           
            $("#birthday").datetimepicker(dateTimeConfig);
        });
    };
});