package cn.org.cflac.lardb.fileUpload.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.org.cflac.lardb.common.UUIDUtil;
import cn.org.cflac.lardb.fileUpload.entity.TAttachmentAudio;
import cn.org.cflac.lardb.fileUpload.entity.TAttachmentDocument;
import cn.org.cflac.lardb.fileUpload.entity.TAttachmentInfo;
import cn.org.cflac.lardb.fileUpload.entity.TAttachmentPicture;
import cn.org.cflac.lardb.fileUpload.entity.TAttachmentVideo;
import cn.org.cflac.lardb.fileUpload.util.FileUtil;
import cn.org.cflac.lardb.fileUpload.util.PathUtil;
import cn.org.cflac.lardb.fileUpload.util.constantUtil;
import cn.org.cflac.lardb.fileUpload.util.fileUploadUtil;
import cn.org.cflac.lardb.fileUpload.util.picUtil;

import com.alibaba.fastjson.JSONObject;
import com.css.sword.common.fileupload.dao.ChunkDao;
import com.css.sword.common.fileupload.entity.PdWebFileuploadChunk;
import com.css.sword.common.util.ServiceResult;
import com.css.sword.core.kernel.base.annotation.Service;
import com.css.sword.core.kernel.base.annotation.ServiceContainer;
import com.css.sword.core.kernel.base.exception.SwordBaseCheckedException;
import com.css.sword.core.kernel.base.persistence.IPersistenceService;
import com.css.sword.core.kernel.utils.SwordPersistenceUtils;
import com.css.sword.utils.SwordStringUtils;
import com.css.sword.utils.logger.SwordLogUtils;
import com.css.sword.web.request.ISwordRequest;
import com.css.sword.web.response.ISwordResponse;
import com.css.sword.web.response.SwordResponseFactory;


/**
 * 
 * @description 文件资源上传实现类
 * @createTime 2015年10月28日 下午4:13:49
 * @modifyTime 
 * @author liwei@css.com.cn
 * @version 1.0
 */
@ServiceContainer("fileUpload")
public class fileUploadService {

    private static final SwordLogUtils logger = SwordLogUtils.getLogger(fileUploadService.class);

    /**
     * 
     * @description 保存或更新文件资源信息表
     * @methodName saveOrUpdateFile
     * @param
     * @returnType ISwordResponse   
     * @throw
     */
    @Service("saveOrUpdateFile")
    public ISwordResponse saveOrUpdateFile(JSONObject json) throws SwordBaseCheckedException {
        logger.debug("---fileUploadService中的saveOrUpdateFile方法开始---");
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        ISwordResponse dRes = SwordResponseFactory.createSwordResponseInstance(null);
        JSONObject resultJson = new JSONObject();
        /*
         * 附件相关信息
         */
        String type = (String) json.get("type");
        String name = (String) json.get("name");
        String uploadFileName = (String) json.get("uploadFileName");
        String uploadFileType = (String) json.get("uploadFileType");
        fileUploadUtil util = new fileUploadUtil();
        String postfix = util.getPostfix(uploadFileType);
        Double size = (Double) json.get("size");
        String relativePath = (String) json.get("relativePath");
        String md5 = (String) json.get("md5");
        /*
         * 公共业务字段
         */
        String format = (String) json.get("format");
        String arttype = (String) json.get("arttype");
        String belongorg = (String) json.get("belongorg");
        String standardTheme = (String) json.get("standardTheme");
        String userTheme = (String) json.get("userTheme");
        String secretLevel = (String) json.get("secretLevel");
        String status = (String) json.get("status");
        String intro = (String) json.get("intro");
        String language = (String) json.get("language");// 文档语言
        /*
         * 个性字段
         */
        String resolution = (String) json.get("resolution");// 分辨率
        String pixel = (String) json.get("pixel");// 图片像素
        String timing = (String) json.get("timing");// 视频长度
        String definition = (String) json.get("definition");// 视频清晰度
        String subtitles = (String) json.get("subtitles");// 视频字幕
        /*
         * 标记位为true，表示该文件已经上传过，此时不再往附件信息表中保存，仅保存参数信息表
         */
        String attachmentId = null;
        String path = null;
        if ("true".equals((String) json.get("flag"))) {
            attachmentId = (String) json.get("id");
            path = (String) json.get("path");
        } else {
            /*
             * 处理逻辑：首先将附件相关信息保存到附件信息表中，然后根据附件类型将其它业务字段保存到各自的业务表中
             */
            TAttachmentInfo attachmentInfo = new TAttachmentInfo();
            attachmentInfo.setAttachmentId(UUIDUtil.generateUUID());
            attachmentInfo.setAttachmentName(uploadFileName);
            attachmentInfo.setAttachmentType(uploadFileType);
            attachmentInfo.setAttachmentPath(relativePath);
            attachmentInfo.setAttachmentSize(size);
            attachmentInfo.setAttachmentType(type);
            attachmentInfo.setAttachmentMd5(md5);
            dao.insert(attachmentInfo);
            attachmentId = attachmentInfo.getAttachmentId();
            path = relativePath;
        }
        if (constantUtil.state_attachment_document.equals(postfix)) {// 文档
            TAttachmentDocument attackmentDocument = new TAttachmentDocument();
            attackmentDocument.setDocumentId(UUIDUtil.generateUUID());
            attackmentDocument.setDocumentName(name);
            attackmentDocument.setDocumentTypeDict(format);
            attackmentDocument.setAttachmentId(attachmentId);
            attackmentDocument.setIsAudit(constantUtil.state_N);

            attackmentDocument.setArtTypeDict(arttype);
            attackmentDocument.setOrgCode(belongorg);
            attackmentDocument.setThemeStandardDict(standardTheme);
            attackmentDocument.setThemeCustomMix(userTheme);
            attackmentDocument.setDocumentLevelDict(secretLevel);
            attackmentDocument.setDocumentStateDict(status);
            attackmentDocument.setDocumentLanguage(language);
            attackmentDocument.setDocumentIntroduction(intro);
            dao.insert(attackmentDocument);

            resultJson.put("id", attackmentDocument.getAttachmentId());
        } else if (constantUtil.state_attachment_picture.equals(postfix)) {// 图片
            TAttachmentPicture attackmentPicture = new TAttachmentPicture();
            attackmentPicture.setPictureId(UUIDUtil.generateUUID());
            attackmentPicture.setPictureName(name);
            attackmentPicture.setArtTypeDict(format);
            attackmentPicture.setAttachmentId(attachmentId);
            attackmentPicture.setIsAudit(constantUtil.state_N);

            attackmentPicture.setArtTypeDict(arttype);
            attackmentPicture.setOrgCode(belongorg);
            attackmentPicture.setThemeStandardDict(standardTheme);
            attackmentPicture.setThemeCustomMix(userTheme);
            attackmentPicture.setPictureLevelDict(secretLevel);
            attackmentPicture.setPictureStateDict(status);
            attackmentPicture.setPictureResolution(resolution);
            attackmentPicture.setPicturePixel(pixel);
            attackmentPicture.setPictureIntroduction(intro);
            dao.insert(attackmentPicture);

            resultJson.put("id", attackmentPicture.getPictureId());
            
            /*
             * 图片类文件，自动生成缩略图，保存位置与原图相同，文件名称格式为原图文件名+_thumbnail
             * 生成后修改是否已生成缩略图标记为Y
             */
            picUtil picutil= new picUtil();
            String thumbnailPath=picutil.creatThumbnail(path);
            if(SwordStringUtils.isEmpty(thumbnailPath)){
                attackmentPicture.setIsThumbnail(constantUtil.state_Y);
                dao.update(attackmentPicture);
                resultJson.put("thumbnailPath", thumbnailPath);
            }
            
        } else if (constantUtil.state_attachment_video.equals(postfix)) {// 视频
            TAttachmentVideo attackmentVideo = new TAttachmentVideo();
            attackmentVideo.setVideoId(UUIDUtil.generateUUID());
            attackmentVideo.setVideoName(name);
            attackmentVideo.setArtTypeDict(format);
            attackmentVideo.setAttachmentId(attachmentId);
            attackmentVideo.setIsAudit(constantUtil.state_N);

            attackmentVideo.setArtTypeDict(arttype);
            attackmentVideo.setOrgCode(belongorg);
            attackmentVideo.setThemeStandardDict(standardTheme);
            attackmentVideo.setThemeCustomMix(userTheme);
            attackmentVideo.setVideoLevelDict(secretLevel);
            attackmentVideo.setVideoStateDict(status);
            attackmentVideo.setVideoLanguage(language);
            attackmentVideo.setVideoLength(timing);
            attackmentVideo.setVideoDefinition(definition);
            attackmentVideo.setVideoSubtitlesDict(subtitles);
            attackmentVideo.setVideoIntroduction(intro);
            dao.insert(attackmentVideo);

            resultJson.put("id", attackmentVideo.getVideoId());
            
        } else if (constantUtil.state_attachment_audio.equals(postfix)) {// 音频
            TAttachmentAudio attackmentAudio = new TAttachmentAudio();
            attackmentAudio.setAudioId(UUIDUtil.generateUUID());
            attackmentAudio.setAudioName(name);
            attackmentAudio.setArtTypeDict(format);
            attackmentAudio.setAttachmentId(attachmentId);
            attackmentAudio.setIsAudit(constantUtil.state_N);

            attackmentAudio.setArtTypeDict(arttype);
            attackmentAudio.setOrgCode(belongorg);
            attackmentAudio.setThemeStandardDict(standardTheme);
            attackmentAudio.setThemeCustomMix(userTheme);
            attackmentAudio.setAudioLevelDict(secretLevel);
            attackmentAudio.setAudioStateDict(status);
            attackmentAudio.setAudioLanguage(language);
            attackmentAudio.setAudioLength(timing);
            dao.insert(attackmentAudio);

            resultJson.put("id", attackmentAudio.getAudioId());
        }
        resultJson.put("path", path);
        resultJson.put("status", "200");
        resultJson.put("message", "操作成功");
        dRes.setModel(resultJson);
        logger.debug("---fileUploadService中的saveOrUpdateFile方法结束---");
        return dRes;
    }

    /**
     * 
     * @description 获取前端上传的MD5码，与现有文件进行比对
     * @methodName isFlagMD5
     * @param
     * @returnType ISwordResponse   
     * @throw
     */
    @Service("isFlagMD5")
    public ISwordResponse isFlagMD5(String md5,String type) {
        logger.debug("---fileUploadService中的isFlagMD5方法开始---");
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        ISwordResponse dRes = SwordResponseFactory.createSwordResponseInstance(null);
        JSONObject json = new JSONObject();
        String sql = "select t.attachment_id,t.attachment_path" + " from t_attachment_info t where t.attachment_md5=?";
        List param = new ArrayList<Object>();
        param.add(md5);
        Object[] paramObj = null;
        if (null != param && param.size() > 0) {
            paramObj = param.toArray();
        }
        Map resultMap = dao.findOneBySql(sql, paramObj);
        if (null != resultMap && resultMap.size() > 0) {
            json.put("id", (String) resultMap.get("attachmentId"));
            json.put("path", (String) resultMap.get("attachmentPath"));
            json.put("flag", "true");
        } else {
            json.put("flag", "false");
        }
        fileUploadUtil util = new fileUploadUtil();
        String postfix = util.getPostfix(type);
        json.put("postfix", postfix);
        dRes.setModel(json);
        logger.debug("---fileUploadService中的isFlagMD5方法开始---");
        return dRes;
    }

    /**
     * 
     * @description 根据业务表ID查询附件相关信息
     * @methodName queryFileById
     * @param
     * @returnType ISwordResponse   
     * @throw
     */
    @Service("queryFileById")
    public ISwordResponse queryFileById(ISwordRequest iReq) throws SwordBaseCheckedException {
        logger.debug("---fileUploadService中的queryFileById方法开始---");
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        ISwordResponse dRes = SwordResponseFactory.createSwordResponseInstance(null);
        JSONObject resultJson = new JSONObject();
        String id = iReq.getData("id");
        fileUploadUtil util= new fileUploadUtil();
        if (SwordStringUtils.isEmpty(id)) {
            logger.error("---传入附件ID为空！---");
        } else {
            /*
             * 处理逻辑：获取传入id的文件类型，根据不同的文件类型，查询不同的文件类型业务表
             */
            List param = new ArrayList<Object>();
            param.add(id);
            Object[] paramObj = null;
            if (null != param && param.size() > 0) {
                paramObj = param.toArray();
            }
            Map fileMap=util.getFileInfoAndTypeById(id);
            if(null!=fileMap && fileMap.size()>0){
                String type=(String)fileMap.get("type");
                String sql="";
                if(constantUtil.state_attachment_document.equals(type)){
                    sql="select t.*,info.attachment_path,info.attachment_size from t_attachment_file t,"
                            + " t_attachment_info info where t.attachment_id=info.attachment_id"
                            + " and t.file_id=?";
                }else if(constantUtil.state_attachment_picture.equals(type)){
                    sql="select t.*,info.attachment_path,info.attachment_size from t_attachment_picture t,"
                            + " t_attachment_info info where t.attachment_id=info.attachment_id"
                            + " and t.picture_id=?";
                }else if(constantUtil.state_attachment_video.equals(type)){
                    sql="select t.*,info.attachment_path,info.attachment_size from t_attachment_video t,"
                            + " t_attachment_info info where t.attachment_id=info.attachment_id"
                            + " and t.video_id=?";
                }else if(constantUtil.state_attachment_audio.equals(type)){
                    sql="select t.*,info.attachment_path,info.attachment_size from t_attachment_audio t,"
                            + " t_attachment_info info where t.attachment_id=info.attachment_id"
                            + " and t.audio_id=?";
                }
                Map resultMap=dao.findOneBySql(sql, paramObj);
                dRes.setModel(resultMap);
            }else{
                logger.error("---当前文件类型未匹配到分类！---");
            }
        }
        logger.debug("---fileUploadService中的queryFileById方法结束---");
        return dRes;
    }
    
    /**
     * 
     * @description 根据业务表id和文件是否需要删除标记作废业务表记录和删除文件
     * @methodName deleteFileById
     * @param
     * @returnType ISwordResponse   
     * @throw
     */
    @Service("deleteFileById")
    public ISwordResponse deleteFileById(ISwordRequest iReq) throws SwordBaseCheckedException {
        logger.debug("---fileUploadService中的deleteFileById方法开始---");
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        ISwordResponse dRes = SwordResponseFactory.createSwordResponseInstance(null);
        JSONObject resultJson = new JSONObject();
        String id = iReq.getData("id");
        String flag = iReq.getData("flag");
        fileUploadUtil util= new fileUploadUtil();
        if (SwordStringUtils.isEmpty(id)) {
            logger.error("---传入附件ID为空！---");
        } else {
            /*
             * 获取传入id的文件类型，根据不同的文件类型，查询不同的文件类型业务表
             */
            List param = new ArrayList<Object>();
            param.add(id);
            Object[] paramObj = null;
            if (null != param && param.size() > 0) {
                paramObj = param.toArray();
            }
            Map fileMap=util.getFileInfoAndTypeById(id);
            if(null!=fileMap && fileMap.size()>0){
                String type=(String)fileMap.get("type");
                String fileId=(String)fileMap.get("fileId");
                String filePath=(String)fileMap.get("filePath");
                List fileIdParam = new ArrayList<Object>();
                fileIdParam.add(fileId);
                Object[] fileIdParamObj = null;
                if (null != fileIdParam && fileIdParam.size() > 0) {
                    fileIdParamObj = fileIdParam.toArray();
                }
                /*
                 * 根据不同的附件类型，作废不同的业务表中的数据
                 */
                if(constantUtil.state_attachment_document.equals(type)){
                    dao.deleteBatchByPrimaryKey(TAttachmentDocument.class, fileIdParamObj);
                }else if(constantUtil.state_attachment_picture.equals(type)){
                    dao.deleteBatchByPrimaryKey(TAttachmentPicture.class, fileIdParamObj);
                }else if(constantUtil.state_attachment_video.equals(type)){
                    dao.deleteBatchByPrimaryKey(TAttachmentVideo.class, fileIdParamObj);
                }else if(constantUtil.state_attachment_audio.equals(type)){
                    dao.deleteBatchByPrimaryKey(TAttachmentAudio.class, fileIdParamObj);
                }
                dao.deleteByprimaryKey(TAttachmentInfo.class, paramObj);
                
                /*
                 * 根据前端传入的是否删除文件的标记位判断：true表示删除对应的文件，否则仅作废业务表中的数据
                 */
                if("true".equals(flag)){
                    /*
                     * 获取配置中的路径
                     */
                    PathUtil Util = new PathUtil(); 
                    String path=Util.getPublishPath();
                    if(null==path || "".equals(path)){
                        path=Util.getWebappPath();
                        path = path.replace('\\', '/');
                    }
                    /*
                     * 拼接相对路径，并删除文件
                     */
                    FileUtil fileUtil=new FileUtil();
                    fileUtil.deleteFile(path+filePath);
                }
            }else{
                logger.error("---当前文件类型未匹配到分类！---");
            }
        }
        logger.debug("---fileUploadService中的deleteFileById方法结束---");
        return dRes;
    }
    
    /**
     * 
     * @description 分片上传文件
     * @methodName uploadChunkFile
     * @param
     * @returnType void   
     * @throw
     */
    @Service("uploadChunkFile")
    public void uploadChunkFile(ISwordRequest iReq, HttpServletRequest request, HttpServletResponse response) throws SwordBaseCheckedException {
        logger.debug("---fileUploadService中的uploadChunkFile方法开始---");
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService(); 
        /*
         * 获取配置文件中的上传路径，如果为空表示未配置上传路径，获取本地工程路径
         */
        PathUtil Util = new PathUtil(); 
        String publishPath=Util.getPublishPath();
        if(null==publishPath || "".equals(publishPath)){
            publishPath=Util.getWebappPath();
            publishPath = publishPath.replace('\\', '/');
        }     
        
        String chunk = request.getParameter("chunk");
        //String md5 = request.getParameter("md5");
        String md5=UUIDUtil.generateUUID();
        
        String filePath = request.getParameter("filePath");
        long chunkSize = Long.parseLong(request.getParameter("chunkSize"));

        if (chunk == null){
            chunk = "0";
        }
        InputStream in = null;
        RandomAccessFile randomFile = null;
 
        /*
         * 文件写入
         */
        try {
            int i;
            in = request.getPart("file").getInputStream();
            randomFile = new RandomAccessFile(publishPath+File.separator+filePath, "rw");
            long index = chunkSize * Long.parseLong(chunk);
            randomFile.seek(index);

            byte[] buf = new byte[4096];

            while ((i = in.read(buf)) != -1) {
              randomFile.write(buf, 0, i);
            }
            randomFile.close();
            in.close();
        }catch (IOException e) {
            e.printStackTrace();
        }catch (ServletException e){
            e.printStackTrace();
        }
        
        /*
         * 记录分片状态，用于前端分片验证
         */
        PdWebFileuploadChunk chunkEntity = new PdWebFileuploadChunk();
        chunkEntity.setChunk(Integer.parseInt(chunk));
        chunkEntity.setMd5(md5);
        ChunkDao chunkDao = new ChunkDao();
        chunkDao.saveChunkInfo(chunkEntity);
        
        logger.debug("---fileUploadService中的uploadChunkFile方法结束---");
    }
    
    /*
     * 根据请求头解析出文件名
     * 请求头的格式：火狐和google浏览器下：form-data; name="file"; filename="snmp4j--api.zip"
     *                 IE浏览器下：form-data; name="file"; filename="E:\snmp4j--api.zip"
     * @param header 请求头
     * @return 文件名
     */
    public String getFileName(String header) {
        /*
         * String[] tempArr1 = header.split(";");代码执行完之后，在不同的浏览器下，tempArr1数组里面的内容稍有区别
         * 火狐或者google浏览器下：tempArr1={form-data,name="file",filename="snmp4j--api.zip"}
         * IE浏览器下：tempArr1={form-data,name="file",filename="E:\snmp4j--api.zip"}
         */
        String[] tempArr1 = header.split(";");
        /*
         *火狐或者google浏览器下：tempArr2={filename,"snmp4j--api.zip"}
         *IE浏览器下：tempArr2={filename,"E:\snmp4j--api.zip"}
         */
        String[] tempArr2 = tempArr1[2].split("=");
        //获取文件名，兼容各种浏览器的写法
        String fileName = tempArr2[1].substring(tempArr2[1].lastIndexOf("\\")+1).replaceAll("\"", "");
        return fileName;
    }
    
    /**
     * 
     * @description 获取前端上传的MD5码，与现有文件进行比对
     * @methodName isFlagMD5
     * @param
     * @returnType ISwordResponse   
     * @throw
     */
    public TAttachmentInfo queryFileByMD5(String md5) {
        logger.debug("---fileUploadService中的queryFileByMD5方法开始---");
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        JSONObject json = new JSONObject();
        String sql = "select t.* from t_attachment_info t where t.invalid=? and t.attachment_md5=?";
        List param = new ArrayList<Object>();
        param.add(constantUtil.state_N);
        param.add(md5);
        Object[] paramObj = null;
        if (null != param && param.size() > 0) {
            paramObj = param.toArray();
        }
        TAttachmentInfo info=dao.findOneBySql(TAttachmentInfo.class, sql, paramObj);
        logger.debug("---fileUploadService中的queryFileByMD5方法开始---");
        return info;
    }
    
    /**
     * 
     * @description 文件发送前处理方法，用于往附件信息表和业务表中保存数据
     * @methodName beforeSendFile
     * @param
     * @returnType ServiceResult   
     * @throw
     */
    @Service("beforeSendFile")
    public ISwordResponse beforeSendFile(ISwordRequest iReq)throws SwordBaseCheckedException{
        logger.debug("---fileUploadService中的beforeSendFile方法开始---");
        ISwordResponse dRes = SwordResponseFactory.createSwordResponseInstance(iReq);
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        String md5=iReq.getData("md5");
        String fileFullName=iReq.getData("fileFullName");
        String fileType=fileFullName.substring(fileFullName.lastIndexOf(".") + 1);
        String fileSize=iReq.getData("fileSize");
        HashMap map = new HashMap();
        ServiceResult result = new ServiceResult();
        /*
         * 获取前端传来的附件业务字段信息
         */
        String arttype="76015";//艺术类型
        String belongorg="xxj";//所属机构
        String format="760004888";//文档格式
        String intro="111111";//文档简介
        String language="2222222";//文档语言
        String name="XXXXXXX文档.doc";//文档名称
        String secretLevel="1";//文档密级
        String standardTheme="xxj";//标准主题
        String status="1";//文档状态
        String userTheme="123";//自定义
        String definition="";//视频清晰度
        String pixel="";//图片像素
        String remark="";//?的备注
        String resolution="";//分辨率
        String subtitles="";//视频字幕
        String timing="";//视频长度
        Double size=59.00;//文件大小（已经根据不同的类型自动进行了转换，保留二位小数）
        String type="doc";//文件类型
        
        if(SwordStringUtils.isEmpty(md5)){
            logger.error("---md5为空！---");
        }else{
            /*
             * 获取配置文件中的上传路径，如果为空表示未配置上传物理路径返回noConfig状态
             */
            PathUtil Util = new PathUtil(); 
            String publishPath=Util.getPublishPath();
            if(null==publishPath || "".equals(publishPath)){
                //publishPath=Util.getWebappPath();
                //publishPath = publishPath.replace('\\', '/');
                result.setStatus("noConfig");
            }
            
            /*
             * 根据MD5码查询业务表，看文件是否已存在
             */
            TAttachmentInfo info =this.queryFileByMD5(md5);
            /*
             * 查询结果为空表示，该文件为第一次上传，此时往附件信息表和业务表中添加一条新的记录
             */
            if(null==info || "".equals(info)){
                /*
                 * 根据文件后缀获取文件分类
                 */
                fileUploadUtil util = new fileUploadUtil();
                String postfix = util.getPostfix(fileType);
                /*
                 * 当前文件不管是管理类还是非管理类，至少有一个名称有值，
                 * 所以在保存时根据文件类型分别写入到不同类型的表中，在审核通过前文件统一保存到临时文件夹
                 */
                String path="temporary"+File.separator+postfix;
                File file = new File(publishPath+path);
                if(!file .exists()  && !file .isDirectory()){
                    file.mkdirs();
                }
                
                /*
                 * 文件名称格式化，采用uuid做上传的文件名，避免中文文件名的图片无法读取
                 */
                String uuidName=UUIDUtil.generateUUID()+"."+fileType;
                String relativePath=path+File.separator+uuidName;
                map.put("filePath", relativePath);
                /*
                 * 将附件相关信息保存到附件信息表中，然后根据附件类型将其它业务字段保存到各自的业务表中
                 */
                TAttachmentInfo attachmentInfo = new TAttachmentInfo();
                attachmentInfo.setAttachmentId(md5);
                attachmentInfo.setAttachmentName(fileFullName);
                attachmentInfo.setAttachmentType(fileType);
                attachmentInfo.setAttachmentPath(relativePath);
                attachmentInfo.setAttachmentSize(size);
                attachmentInfo.setAttachmentType(type);
                attachmentInfo.setAttachmentMd5(md5);
                dao.insert(attachmentInfo);
                String attachmentId = attachmentInfo.getAttachmentId();
                map.put("id", attachmentId);               
                if (constantUtil.state_attachment_document.equals(postfix)) {// 文档
                    TAttachmentDocument attackmentDocument = new TAttachmentDocument();
                    attackmentDocument.setDocumentId(UUIDUtil.generateUUID());
                    attackmentDocument.setDocumentName(name);
                    attackmentDocument.setDocumentTypeDict(format);
                    attackmentDocument.setAttachmentId(attachmentId);
                    attackmentDocument.setIsAudit(constantUtil.state_N);

                    attackmentDocument.setArtTypeDict(arttype);
                    attackmentDocument.setOrgCode(belongorg);
                    attackmentDocument.setThemeStandardDict(standardTheme);
                    attackmentDocument.setThemeCustomMix(userTheme);
                    attackmentDocument.setDocumentLevelDict(secretLevel);
                    attackmentDocument.setDocumentStateDict(status);
                    attackmentDocument.setDocumentLanguage(language);
                    attackmentDocument.setDocumentIntroduction(intro);
                    dao.insert(attackmentDocument);
                    
                    //map.put("id", attackmentDocument.getAttachmentId());
                } else if (constantUtil.state_attachment_picture.equals(postfix)) {// 图片
                    TAttachmentPicture attackmentPicture = new TAttachmentPicture();
                    attackmentPicture.setPictureId(UUIDUtil.generateUUID());
                    attackmentPicture.setPictureName(name);
                    attackmentPicture.setArtTypeDict(format);
                    attackmentPicture.setAttachmentId(attachmentId);
                    attackmentPicture.setIsAudit(constantUtil.state_N);

                    attackmentPicture.setArtTypeDict(arttype);
                    attackmentPicture.setOrgCode(belongorg);
                    attackmentPicture.setThemeStandardDict(standardTheme);
                    attackmentPicture.setThemeCustomMix(userTheme);
                    attackmentPicture.setPictureLevelDict(secretLevel);
                    attackmentPicture.setPictureStateDict(status);
                    attackmentPicture.setPictureResolution(resolution);
                    attackmentPicture.setPicturePixel(pixel);
                    attackmentPicture.setPictureIntroduction(intro);
                    dao.insert(attackmentPicture);
                    
                    //map.put("id", attackmentPicture.getPictureId());
                } else if (constantUtil.state_attachment_video.equals(postfix)) {// 视频
                    TAttachmentVideo attackmentVideo = new TAttachmentVideo();
                    attackmentVideo.setVideoId(UUIDUtil.generateUUID());
                    attackmentVideo.setVideoName(name);
                    attackmentVideo.setArtTypeDict(format);
                    attackmentVideo.setAttachmentId(attachmentId);
                    attackmentVideo.setIsAudit(constantUtil.state_N);

                    attackmentVideo.setArtTypeDict(arttype);
                    attackmentVideo.setOrgCode(belongorg);
                    attackmentVideo.setThemeStandardDict(standardTheme);
                    attackmentVideo.setThemeCustomMix(userTheme);
                    attackmentVideo.setVideoLevelDict(secretLevel);
                    attackmentVideo.setVideoStateDict(status);
                    attackmentVideo.setVideoLanguage(language);
                    attackmentVideo.setVideoLength(timing);
                    attackmentVideo.setVideoDefinition(definition);
                    attackmentVideo.setVideoSubtitlesDict(subtitles);
                    attackmentVideo.setVideoIntroduction(intro);
                    dao.insert(attackmentVideo);
                    
                    //map.put("id", attackmentVideo.getVideoId());
                } else if (constantUtil.state_attachment_audio.equals(postfix)) {// 音频
                    TAttachmentAudio attackmentAudio = new TAttachmentAudio();
                    attackmentAudio.setAudioId(UUIDUtil.generateUUID());
                    attackmentAudio.setAudioName(name);
                    attackmentAudio.setArtTypeDict(format);
                    attackmentAudio.setAttachmentId(attachmentId);
                    attackmentAudio.setIsAudit(constantUtil.state_N);

                    attackmentAudio.setArtTypeDict(arttype);
                    attackmentAudio.setOrgCode(belongorg);
                    attackmentAudio.setThemeStandardDict(standardTheme);
                    attackmentAudio.setThemeCustomMix(userTheme);
                    attackmentAudio.setAudioLevelDict(secretLevel);
                    attackmentAudio.setAudioStateDict(status);
                    attackmentAudio.setAudioLanguage(language);
                    attackmentAudio.setAudioLength(timing);
                    dao.insert(attackmentAudio);
                    
                    //map.put("id", attackmentAudio.getAudioId());
                }
                result.setStatus("newUpload"); 
            }else {
                /*
                 * 如果查询到记录，则根据记录中的文件上传是否完成，返回不同的标记
                 */
                map.put("filePath", info.getAttachmentPath());
                if (constantUtil.state_Y.equals(info.getIsCompleted())){
                  result.setStatus("completed");
                }else {
                  result.setStatus("partUpload");
                }
                
                /*
                 * 根据MD5获取改文件的上传分片状态，用于前端判断是否已经上传，从而启用断点续传
                 */
                ChunkDao chunkDao = new ChunkDao();
                map.put("chunks", chunkDao.getChunksByMd5(md5));
              }
            
        }
        /*
         * 将业务表id以及附件的相对路径返回到前端
         */
        //map.put("file", file);
        
        result.setData(map);
        dRes.setModel(result);
        logger.debug("---fileUploadService中的beforeSendFile方法结束---");
        return dRes;
    }
    
    /**
     * 
     * @description 文件上传完成后处理方法，用于修改附件表中的完成状态，以及删除分片信息表中的临时记录
     * @methodName afterSendFile
     * @param
     * @returnType void   
     * @throw
     */
    @Service("afterSendFile")
    public ISwordResponse afterSendFile(ISwordRequest iReq)throws SwordBaseCheckedException{
        logger.debug("---fileUploadService中的afterSendFile方法开始---");
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        ISwordResponse dRes = SwordResponseFactory.createSwordResponseInstance(iReq);
        String md5=iReq.getData("md5");
        /*
         * 删除临时分片信息
         */
        new ChunkDao().delChunksByMd5(md5);
        /*
         * 修改附件信息表中的完成上传的标记
         */
        TAttachmentInfo info =this.queryFileByMD5(md5);
        info.setIsCompleted(constantUtil.state_Y);
        dao.update(info);
        ServiceResult result = new ServiceResult();
        result.setSuccess(true);
        dRes.setModel(result);
        return dRes;
    }
    
    /**
     * 
     * @description 根据附件id下载附件
     * @methodName fileDownload
     * @param
     * @returnType ISwordResponse   
     * @throw
     */
    @Service("fileDownload")
    public ISwordResponse fileDownload(ISwordRequest iReq, HttpServletResponse response, String id)
            throws SwordBaseCheckedException{
      ISwordResponse dRes = SwordResponseFactory.createSwordResponseInstance(iReq);
      TAttachmentInfo info = this.queryFileById(id);
      InputStream in = null;
      OutputStream out = null;
      /*
       * 获取配置文件中的上传路径
       */
      PathUtil Util = new PathUtil(); 
      String publishPath=Util.getPublishPath();
      try {
        int i;
        in = new BufferedInputStream(new FileInputStream(publishPath+info.getAttachmentPath()));
        response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(info.getAttachmentName(), "UTF-8"));
       // response.addHeader("Content-Length", file.getFileSize());
        response.setContentType("application/octet-stream");
        out = new BufferedOutputStream(response.getOutputStream());
        byte[] buf = new byte[4096];

        while ((i = in.read(buf)) != -1) {
          out.write(buf, 0, i);
          out.flush();
        }
        out.close();
        in.close();
      }catch (IOException e) {
        e.printStackTrace();
      }
      return dRes;
    }
    
    /**
     * 
     * @description 根据附件id查询附件详细信息
     * @methodName queryFileById
     * @param
     * @returnType ISwordResponse   
     * @throw
     */
    public TAttachmentInfo queryFileById(String id) {
        logger.debug("---fileUploadService中的queryFileById方法开始---");
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        JSONObject json = new JSONObject();
        String sql = "select t.* from t_attachment_info t where t.attachment_id=?";
        List param = new ArrayList<Object>();
        param.add(id);
        Object[] paramObj = null;
        if (null != param && param.size() > 0) {
            paramObj = param.toArray();
        }
        TAttachmentInfo info=dao.findOneBySql(TAttachmentInfo.class, sql, paramObj);
        logger.debug("---fileUploadService中的queryFileById方法开始---");
        return info;
    }
    
    @Service("delFile")
    public ISwordResponse delFile(ISwordRequest iReq) throws Exception {
        logger.debug("---fileUploadService中的queryFileById方法开始---");
        IPersistenceService dao = SwordPersistenceUtils.getPersistenceService();
        ISwordResponse dRes = SwordResponseFactory.createSwordResponseInstance(iReq);
        String id=iReq.getData("id");
        ServiceResult result = new ServiceResult();
        /*
         * 作废附件信息表中的有效标记
         */
        TAttachmentInfo info = this.queryFileById(id);
        dao.delete(info);
        
        /*
         * 根据附件id作废对应的业务表中的记录
         */
        
        /*
         * 获取配置文件中的上传路径
         */
        PathUtil Util = new PathUtil(); 
        String publishPath=Util.getPublishPath();
        File file = new File(publishPath+info.getAttachmentPath());
        if ((file.isFile()) && (file.exists())) {
          file.delete();
        }
        result.setSuccess(true);
        dRes.setModel(result);
        return dRes;
    }
}
