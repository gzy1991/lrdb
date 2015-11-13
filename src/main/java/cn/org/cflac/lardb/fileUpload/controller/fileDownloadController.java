package cn.org.cflac.lardb.fileUpload.controller;

import com.css.sword.core.kernel.utils.SwordServiceUtils;
import com.css.sword.utils.logger.SwordLogUtils;
import com.css.sword.web.controller.AbsSwordController;
import com.css.sword.web.controller.SwordController;
import com.css.sword.web.request.SwordDefaultRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * @description 附件下载controller实现类
 * @createTime 2015年10月28日 下午4:15:50
 * @modifyTime 
 * @author liwei@css.com.cn
 * @version 1.0
 */
@SwordController("fileDownloadController")
public class fileDownloadController extends AbsSwordController{
	private static final SwordLogUtils logger = SwordLogUtils
			.getLogger(fileDownloadController.class);
	
	@Override
	public void doAction(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("---fileDownloadController中的文件上传方法开始---");
		SwordServiceUtils.callService("/fileUpload/fileDownload", new Object[] { new SwordDefaultRequest(request),response,request.getParameter("id") });
		logger.debug("---fileDownloadController中的文件上传方法结束---");
	}
}
