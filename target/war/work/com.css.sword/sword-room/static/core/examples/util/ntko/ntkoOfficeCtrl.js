define(["jquery","PDExamplesDir/common"],function($,Common){

    return function($compile,$scope,$route,$routeParams){
        /*//������ʼ��
        Common.exampleInit($compile,$scope,
            "PDExamplesDir/util/grid/views/source.html",        //��ʾ����·��
            "PDExamplesDir/util/grid/views/doc.html",           //�ĵ�·��
            "800px"                                             //�������ȣ���Ϊ�գ�Ĭ��800px
        );*/
        require(["PDModuleDir/util/ntko/ntkoOffice"],function(){
            NTKO.load({
                url:"",
                defaultTempURL:""
            });
            NTKO.init();
        })
    };
});