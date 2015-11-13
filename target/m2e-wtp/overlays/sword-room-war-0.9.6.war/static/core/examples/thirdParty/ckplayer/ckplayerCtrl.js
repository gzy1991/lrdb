define(["jquery","PDExamplesDir/common"],function($,Common){

    return function($compile,$scope){
        //样例初始化
        Common.exampleInit($compile,$scope,
            "PDExamplesDir/thirdParty/ckplayer/views/source.html",        //演示代码路径
            "PDExamplesDir/thirdParty/ckplayer/views/doc.html",            //文档路径
            "600"
        );
    };
});