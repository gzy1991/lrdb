define(["jquery","css!PDCoreDir/examples/markdown"],function($){
    return function($compile,$scope) {
        $("#standardDoc .markdown-body table").addClass("table table-bordered table-hover");
        $("#standardDoc").css({
            'padding': '20px 40px'
        });
    }
});