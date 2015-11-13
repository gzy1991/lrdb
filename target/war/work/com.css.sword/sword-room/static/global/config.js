/*
 * require.js配置
 */
require.config({
    paths:{
        //基础模块配置
        "Bootstrap":"static/modules/bootstrap/js/bootstrap.min",
        /*
        "Ace":"static/modules/ace/dist/js/ace.min",
        "Ace-extra":"static/modules/ace/dist/js/ace-extra.min",
        "Ace-element":"static/modules/ace/dist/js/ace-elements.min",
        */
        "Angular":"static/modules/angular/angular.min",
        "Angular-route":"static/modules/angular/angular-route.min",
        "Angular-ui-router":"static/modules/angular/angular-ui-router.min",
        "jquery":"static/modules/jquery/jquery-2.1.3.min",
        "JQuery.validate":"static/modules/jquery/plugins/validate/jquery.validate.min",
        "JQuery.validate.extra":"static/modules/jquery/plugins/validate/additional-methods",
        "JQuery.validate.message":"static/modules/jquery/plugins/validate/localization/messages_zh",
        "JQuery.pubsub":"static/modules/jquery/plugins/pubsub/pubsub",
        "ZTree":"static/modules/zTree/js/jquery.ztree.all-3.5.min",
        "LocalZTree":"static/modules/util/localZTree/localZTree",
        "WebUploader":"static/modules/webuploader/webuploader.min",
        "Cropper":"static/modules/cropper/js/cropper",
        "Date":"static/modules/bootstrap/plugins/datetimepicker/js/datetimepicker.min",
        "DateCN":"static/modules/bootstrap/plugins/datetimepicker/js/datetimepicker.cn",
        "ClockPicker":"static/modules/bootstrap/plugins/clockpicker/js/bootstrap-clockpicker.min",
//        "Scroll":"static/modules/jquery/plugins/jquery.slimscroll.min",
        /*  echarts 自身的amd加载器与requirejs的加载有差异，
        	对循环依赖的处理方式不同，因此echarts无法使用requirejs进行模块化加载~
        	最终改为整个文件加载~
         */
        "Echarts":"static/modules/echarts/echarts-all",
        "FloatTouch":"static/modules/floatTouch/floatTouch",
        "CkPlayer":"static/modules/ckplayer6.7/ckplayer/ckplayer",
        "ArtTemplate":"static/modules/artTemplate/template",
        "ArtTemplateNative":"static/modules/artTemplate/template-native",

        /*第三方模块文件夹*/
        "CMDir":"static/modules/codemirror",
        "MCScrollbarDir":"static/modules/jquery/plugins/mCustomScrollbar",
//      "EchartsDir":"static/modules/echarts",

        /*静态模块路径配置*/
        "PDAppDir":"static/app",
        "PDCoreDir":"static/core",
        "PDGlobalDir":"static/global",
        "PDUtilDir":"static/modules/util",
        "PDModuleDir":"static/modules",


        /*CSS文件路径映射*/
        "ZTreeCss":"static/modules/zTree/css/zTreeStyle/csTreeStyle",
        "WebUploaderCss":"static/modules/webuploader/css/webuploader",
        "CropperCss":"static/modules/cropper/css/cropper.min",
        "DateCss":"static/modules/bootstrap/plugins/datetimepicker/css/datetimepicker.min",
        "ClockPickerCss":"static/modules/bootstrap/plugins/clockpicker/css/bootstrap-clockpicker.min",
        "FloatTouchCss":"static/modules/floatTouch/css/floatTouch"
    },
    shim:{
        "Bootstrap":["jquery"],
        /*
        "Ace":["Bootstrap"],
        "Ace-element":["Ace"],
        "Ace-extra":["Ace", "Ace-element"],
        */
        "Angular":{"exports":"angular"},
        "Angular-route":['Angular'],
        "Angular-ui-router":["Angular"],
        "ZTree":["jquery"],
        "DateCN":["Date"],
        "JQuery.validate.extra":["JQuery.validate"],
        "JQuery.validate.message":["JQuery.validate"],
        "JQuery.pubsub":["jquery"],
        "Uploader":["WebUploader"],
        "FloatTouch":["jquery"]
    },
    //urlArgs:"v=0.9.2",
    map:{
        '*':{
            'css':"static/modules/requirejs/plugin/require-css/css.min",
            'text':"static/modules/requirejs/plugin/text"
        }
    }
});