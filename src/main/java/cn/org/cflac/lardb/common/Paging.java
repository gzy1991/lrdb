/**
 * <b>项目名：</b>lrdb<br/>  
 * <b>包名：</b>cn.org.cflac.lardb.common<br/>  
 * <b>文件名：</b>Paging.java<br/>  
 * <b>版本信息：</b>1.0<br/>  
 * <b>日期：</b>2015年10月20日 下午3:15:06<br/>  
 * <b>COPYRIGHT 2010-2012 ALL RIGHTS RESERVED 中国软件与技术服务股份有限公司</b>-版权所有<br/>
 */
package cn.org.cflac.lardb.common;

/**
 * @description TODO
 * @createTime 2015年10月20日 下午3:15:06
 * @modifyTime
 * @author gaodsh@css.com.cn
 * @version 1.0
 */
public class Paging {

    public static final int DEFAULT_PAGE_SIZE = 20;

    public static final int DEFAULT_PAGE_NUM = 1;

    /** 页码,从1开始 */
    private int curPage = DEFAULT_PAGE_NUM;

    /** 每页多少行 */
    private int pageSize = DEFAULT_PAGE_SIZE;

    public Paging() {
    }

    public Paging(int pageNum) {
        this(pageNum, DEFAULT_PAGE_SIZE);
    }

    /**
     * 分页信息
     * 
     * @param pageNumber
     *            页码,从1开始
     * @param pageSize
     *            每页多少行,默认为 20
     */
    public Paging(int curPage, int pageSize) {
        if (curPage < 1) {
            curPage = 1;
        }

        if (pageSize < 1) {
            pageSize = DEFAULT_PAGE_SIZE;
        }
        this.curPage = curPage - 1;
        this.pageSize = pageSize;
    }


    public int getCurPage() {
        return curPage;
    }

    public void setCurPage(int curPage) {
        this.curPage = curPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    @Override
    public String toString() {
        return "Paging [curPage=" + curPage + ", pageSize=" + pageSize + "]";
    }
    
    

}
