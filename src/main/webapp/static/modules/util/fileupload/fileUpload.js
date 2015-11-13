define(['WebUploader','PDUtilDir/util'],function(WebUploader,Util){
    /**
     * 附件MD5、分片是否传过验证、文件上传完毕事件注册
     */
    var register = function(){
        //先清除事件注册
        unRegister();

        var UPLOAD_FILE = null;

        WebUploader.Uploader.register({
            'name': 'beforeSendFile',
            'before-send-file': function( file ) {
                var deferred = WebUploader.Deferred();
                var start = new Date().getTime();
                var owner = this.owner;
                owner.md5File( file.source )
                    .progress(function(percentage){
                        file.swordProgress.css('width', percentage*5 +'%').html((percentage*5).toFixed(2) +'%');
                    })
                    .fail(function() {
                        deferred.reject();
                    })
                    .then(function( md5 ) {
                        //MD5计算完毕，向服务器端验证该文件上传状态（未上传[包含已上传一部分]、成功）
                        console.log("总耗时: "+((new Date().getTime()) - start)/1000);
                        $.ajax({
                           //  url:getServer()+"/sword/sword-room/fileupload/beforeSendFile",
                            url:getServer()+"/sword/fileUpload/beforeSendFile",
                            dataType: 'json',
                            data: {
                                md5: md5,
                                fileFullName:file.name,
                                fileMiddleDir:owner.options.fileMiddleDir,
                                fileSize:file.size
                            },
                            success: function (response) {
                                //未配置附件配置
                                if(response.status=="noConfig"){
                                    Util.alert("未找到附件配置，中断上传.");
                                    deferred.reject();
                                }else{
                                    //每次向后台发送分片时使用
                                    file.swordFileId     = md5;
                                    //file.swordFilePath    = response.data.file.filePath;
                                    file.swordFilePath    = response.data.filePath;
                                    //已经上传，跳过此文件，秒传
                                    if(response.status=="completed"){
                                        owner.skipFile(file);
                                    }else{
                                        UPLOAD_FILE = response.data;
                                    }
                                    //webuploader接着往下走。
                                    deferred.resolve();
                                }
                            }
                        });
                    });

                return deferred.promise();
            }
        });
        WebUploader.Uploader.register({
            'name': 'beforeSend',
            'before-send': function(block){
                //是否上传分片验证
                var checkBlock = function(){
                    for(var i= 0,chunk;chunk=UPLOAD_FILE.chunks[i++];){
                        if(chunk.chunk==block.chunk){
                            return true;
                        }
                    }
                    return false;
                };
                var deferred = WebUploader.Deferred();
                if(!UPLOAD_FILE.chunks){
                    //第一次上传
                    deferred.resolve();
                }else{
                    if(checkBlock()){
                        //已经存在跳过上传
                        deferred.reject();
                    }else{
                        deferred.resolve();
                    }
                }
                return deferred.promise();
            }
        });
        WebUploader.Uploader.register({
            'name': 'afterSendFile',
            'after-send-file': function(file){
                //上传完成修改状态
                $.ajax({
                   // url:getServer()+"/sword/sword-room/fileupload/afterSendFile",
                    url:getServer()+"/sword/fileUpload/afterSendFile",
                    dataType: 'json',
                    data: {
                        md5:file.swordFileId
                    },
                    success: function (response) {
                        if(response.success){
                            //console.log("========"+file.name+"上传完成========");
                            //console.log(file);
                        }
                    }
                });
            }
        });
    };

    /**
     * 取消注册
     */
    var unRegister = function(){
        WebUploader.Uploader.unRegister('beforeSendFile');
        WebUploader.Uploader.unRegister('beforeSend');
        WebUploader.Uploader.unRegister('afterSendFile');
    };

    /**
     * 获取已经上传的附件
     * @param ids
     * @returns {*}
     */
    var getSavedFiles = function(ids){
        var result;
        $.ajax({
            url:getServer()+"/sword/sword-room/fileupload/getFilesByIds",
            type:"post",
            dataType:"json",
            async:false,
            data:{
                ids:ids.join(";")
            },
            success:function(files){
                result = files;
            }
        });
        return result;
    };

    return {
        register:register,
        unRegister:unRegister,
        getSavedFiles:getSavedFiles
    }
});