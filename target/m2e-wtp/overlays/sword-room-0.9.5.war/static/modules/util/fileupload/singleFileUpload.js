/**
 * Created by YiYing on 2014/12/14.
 */
define(['WebUploader',
        'PDUtilDir/fileupload/fileUpload',
        'PDUtilDir/util',
        'css!WebUploaderCss'],function(WebUploader,UploadUtil,Util){

    var init = function(options){
        var settings = {
            swf: getStaticPath() + 'modules/webuploader/Uploader.swf',
            chunked:true,
            server: getServer() +"/sword?SwordControllerName=sword-room-fileUpload",
            fileMiddleDir:"",
            onUploadedFile:function(file){},
            onDeletedFile:function(file){}
        };
        return new SimpleUpload($.extend(settings,options)).render();
    };

    /**
     * 简单附件上传对象
     * @param settings
     * @constructor
     */
    function SimpleUpload(settings){
        this.file       = null;                 //webuploader的文件对象
        this.$img       = null;                 //附件上传组件图标
        this.$upload    = null;                 //上传图标DOM对象
        this.settings   = settings;
    }

    /**
     * 渲染附件上传组件
     */
    SimpleUpload.prototype.render = function () {
        var html = '<div class="cs-single-upload">'+
                        '<div class="cs-sUpload-body">' +
                            '<div>'+
                                '<input type="text" class="form-control">'+
                            '</div>'+
                        '</div>'+
                    '</div>';
        var progress = '<div class="progress">'+
                            '<div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 1%;">'+
                                '1%'+
                            '</div>'+
                        '</div>';
        var status  =   '<div class="cs-sUpload-status">' +
                            '<a href=""></a>' +
                            '<i class="fa fa-times" title="删除"></i>'+
                        '</div>';
        this.$container = $(html);
        var _this = this;
        this.$uploadBody = this.$container.find("div:first");
        this.$img       = $('<i class="fa fa-cloud-upload"></i>');
        this.$upload    = $('<i class="fa fa-upload" title="上传"></i>').bind('click',function(){_this.startUpload()});
        this.$uploadBody.append(this.$img).append(this.$upload);
        this.$progress  = $(progress).hide();
        this.$status    = $(status).hide();
        this.$container.append(this.$progress).append(this.$status);
        //添加附件上传组件到指定位置
        var placeAt     = this.settings.placeAt;
        var $placeAt    = typeof(placeAt)=="string" ? $("#"+placeAt) : $(placeAt);
        $placeAt.append(this.$container);

        //上传按钮
        this.settings.pick = {
            id:this.$uploadBody[0].firstChild,
            multiple:false
        };
        //初始化WebUploader
        this.webUploader    = InitUploader(this,this.settings);

        //渲染已上传的附件
        var savedFileId = this.settings.data;
        if(savedFileId){
            this.renderSavedFile    (UploadUtil.getSavedFiles([savedFileId])[0]);
        }

        return this;
    };


    SimpleUpload.prototype.renderSavedFile = function (file) {
        var _this = this;
        _this.$uploadBody.hide();
        _this.$progress.hide();
        _this.$status.find("a")
            .attr('href',getServer()+'/sword?SwordControllerName=sword-room-fileDownload&id='+file.swordFileId)
            .text(file.name)
            .attr('title',file.name);
        //删除已上传的附件事件绑定
        _this.$status.find(".fa-times").click(function(){
            Util.confirm("是否从服务器中删除该附件?",function(){
                $.ajax({
                    url:getServer()+"/sword/sword-room/fileupload/delFile",
                    dataType: 'json',
                    data: {
                        id:file.swordFileId
                    },
                    success: function (response) {
                        if(response.success){
                            _this.remove();
                        }else{
                            Util.alert("删除失败.");
                        }
                    }
                });
            });
        });
        _this.$status.show();
    };

    /**
     * 开始上传附件
     */
    SimpleUpload.prototype.startUpload = function(){
        this.webUploader.upload();
    };

    /**
     * 删除附件
     */
    SimpleUpload.prototype.remove = function(){
        this.$container.find("input")[0].value = "";
        //重置uploader。目前只重置了队列。
        this.webUploader.reset();
        //显示隐藏控制
        this.$img.show();
        this.$upload.hide();
        this.$status.hide();
        this.$uploadBody.show();
        this.settings.onDeletedFile.apply(this,[this.file]);
    };

    var InitUploader = function(simpleUpload,settings) {
        //开启断点续传
        if(settings.chunked==true){
            UploadUtil.register();
        }

        var uploader = WebUploader.create(settings);
        /**
         * 当文件被加入队列以后触发。
         */
        uploader.on( 'fileQueued', function( file ) {
            simpleUpload.$container.find("input")[0].value = file.name;
            //显示删除和上传图标
            simpleUpload.$img.hide();
            simpleUpload.$upload.show();
            file.swordProgress = simpleUpload.$progress.find('div[class="progress-bar"]');
        });
        /**
         * 当一批文件添加进队列以后触发。
         */
        uploader.on( 'filesQueued', function( files ) {

        });
        /**
         * 附件上传数据发送之前触发
         */
        uploader.on( 'uploadBeforeSend', function(object,data,headers) {
            data["chunkSize"]   = this.options.chunkSize;                 //发送每片大小到后端
            data["md5"]         = object.file.swordFileId;         //文件MD5
            data["filePath"]    = object.file.swordFilePath;        //文件路径
        });
        /**
         * 当开始上传流程时触发。
         */
        uploader.on( 'uploadStart', function( file ) {
            simpleUpload.$uploadBody.hide();
            simpleUpload.$progress.show();
        });
        /**
         * 上传过程中触发，携带上传进度。
         */
        uploader.on( 'uploadProgress', function( file, percentage ) {
            simpleUpload.$progress.find('div[class="progress-bar"]').css('width', percentage*95+5 +'%').html((percentage*95+5).toFixed(2) +'%');
        });
        /**
         * 当文件上传出错时触发。
         */
        uploader.on( 'uploadError', function( file, reason ) {

        });
        /**
         * 当文件上传成功时触发。
         */
        uploader.on( 'uploadSuccess', function( file, response ) {
            simpleUpload.settings.onUploadedFile.apply(simpleUpload,[file, response]);
            simpleUpload.renderSavedFile(file);
        });
        /**
         * 不管成功或者失败，文件上传完成时触发。
         */
        uploader.on('uploadComplete',function(file){

        });

        return uploader;
    };

    return {
        init:init
    }
});