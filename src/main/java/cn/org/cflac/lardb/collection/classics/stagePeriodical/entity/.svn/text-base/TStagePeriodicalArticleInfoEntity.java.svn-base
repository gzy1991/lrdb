package cn.org.cflac.lardb.collection.classics.stagePeriodical.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.alibaba.fastjson.JSONArray;

import cn.org.cflac.lardb.common.UUIDUtil;

import java.sql.Timestamp;


/**
 * The persistent class for the t_stage_periodical_article_info database table.
 * 
 */
@Entity
@Table(name="t_stage_periodical_article_info")
@NamedQuery(name="TStagePeriodicalArticleInfoEntity.findAll", query="SELECT t FROM TStagePeriodicalArticleInfoEntity t")
public class TStagePeriodicalArticleInfoEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="article_id")
	private String articleId;

	@Lob
	@Column(name="article_content")
	private String articleContent;

	@Column(name="article_deputy_title")
	private String articleDeputyTitle;

	@Column(name="article_keyword")
	private String articleKeyword;

	@Column(name="article_page_num_end")
	private String articlePageNumEnd;

	@Column(name="article_page_num_start")
	private String articlePageNumStart;

	@Column(name="article_title")
	private String articleTitle;

	@Column(name="columntree_pertree_id")
	private String columntreePertreeId;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	private String invalid;

	@Column(name="lastmodify_time")
	private Timestamp lastmodifyTime;

	@Column(name="lastmodify_user")
	private String lastmodifyUser;

	@Column(name="oper_status")
	private String operStatus;

	@Column(name="org_code")
	private String orgCode;

	@Transient
	private JSONArray artAuthors;
	
	@Transient
	private JSONArray artTranslators;
	
	
	public JSONArray getArtAuthors() {
		return artAuthors;
	}

	public void setArtAuthors(JSONArray artAuthors) {
		this.artAuthors = artAuthors;
	}

	public JSONArray getArtTranslators() {
		return artTranslators;
	}

	public void setArtTranslators(JSONArray artTranslators) {
		this.artTranslators = artTranslators;
	}

	public TStagePeriodicalArticleInfoEntity() {
		this.articleId = UUIDUtil.generateUUID();
	}

	public String getArticleId() {
		return this.articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	public String getArticleContent() {
		return this.articleContent;
	}

	public void setArticleContent(String articleContent) {
		this.articleContent = articleContent;
	}

	public String getArticleDeputyTitle() {
		return this.articleDeputyTitle;
	}

	public void setArticleDeputyTitle(String articleDeputyTitle) {
		this.articleDeputyTitle = articleDeputyTitle;
	}

	public String getArticleKeyword() {
		return this.articleKeyword;
	}

	public void setArticleKeyword(String articleKeyword) {
		this.articleKeyword = articleKeyword;
	}

	public String getArticlePageNumEnd() {
		return this.articlePageNumEnd;
	}

	public void setArticlePageNumEnd(String articlePageNumEnd) {
		this.articlePageNumEnd = articlePageNumEnd;
	}

	public String getArticlePageNumStart() {
		return this.articlePageNumStart;
	}

	public void setArticlePageNumStart(String articlePageNumStart) {
		this.articlePageNumStart = articlePageNumStart;
	}

	public String getArticleTitle() {
		return this.articleTitle;
	}

	public void setArticleTitle(String articleTitle) {
		this.articleTitle = articleTitle;
	}

	public String getColumntreePertreeId() {
		return this.columntreePertreeId;
	}

	public void setColumntreePertreeId(String columntreePertreeId) {
		this.columntreePertreeId = columntreePertreeId;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getCreateUser() {
		return this.createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getInvalid() {
		return this.invalid;
	}

	public void setInvalid(String invalid) {
		this.invalid = invalid;
	}

	public Timestamp getLastmodifyTime() {
		return this.lastmodifyTime;
	}

	public void setLastmodifyTime(Timestamp lastmodifyTime) {
		this.lastmodifyTime = lastmodifyTime;
	}

	public String getLastmodifyUser() {
		return this.lastmodifyUser;
	}

	public void setLastmodifyUser(String lastmodifyUser) {
		this.lastmodifyUser = lastmodifyUser;
	}

	public String getOperStatus() {
		return this.operStatus;
	}

	public void setOperStatus(String operStatus) {
		this.operStatus = operStatus;
	}

	public String getOrgCode() {
		return this.orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

}