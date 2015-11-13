package cn.org.cflac.lardb.fileUpload.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.css.sword.core.kernel.utils.SwordServiceUtils;
import com.css.sword.utils.logger.SwordLogUtils;
import com.css.sword.web.controller.AbsSwordController;
import com.css.sword.web.controller.SwordController;
import com.css.sword.web.request.SwordDefaultRequest;

/**
 * 
 * @description 附件上传controller实现类
 * @createTime 2015年10月28日 下午4:15:50
 * @modifyTime 
 * @author liwei@css.com.cn
 * @version 1.0
 */
@SwordController("fileUploadController")
public class fileUploadController extends AbsSwordController{
	private static final SwordLogUtils logger = SwordLogUtils
			.getLogger(fileUploadController.class);
	
	@Override
	public void doAction(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("---fileUploadController中的文件上传方法开始---");
		SwordServiceUtils.callService("/fileUpload/uploadChunkFile", new Object[] { new SwordDefaultRequest(request), request, response });
		logger.debug("---fileUploadController中的文件上传方法结束---");
	}
}
