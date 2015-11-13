package cn.org.cflac.lardb.collection.encyclopedia.entity;

import java.io.Serializable;

import javax.persistence.*;

import java.sql.Timestamp;
import java.util.UUID;


/**
 * The persistent class for the t_encyclopedia_info database table.
 * 
 */
@Entity
@Table(name="t_encyclopedia_info")
@NamedQuery(name="TEncyclopediaInfoEntity.findAll", query="SELECT t FROM TEncyclopediaInfoEntity t")
public class TEncyclopediaInfoEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private static final String CoperStatus = "I";
	private static final String CorgCode = "I";
	private static final String CisSubmit = "N";
	
	@Id
	@Column(name="encyclopedia_id")
	private String encyclopediaId;

	@Column(name="art_type_dict")
	private String artTypeDict;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	@Lob
	@Column(name="encyclopedia_content")
	private String encyclopediaContent;

	@Lob
	@Column(name="encyclopedia_index")
	private String encyclopediaIndex;

	@Column(name="encyclopedia_keyword")
	private String encyclopediaKeyword;

	@Column(name="encyclopedia_source")
	private String encyclopediaSource;

	@Column(name="encyclopedia_title")
	private String encyclopediaTitle;

	@Column(name="encyclopedia_type_dict")
	private String encyclopediaTypeDict;

	private String invalid;

	@Column(name="is_submit")
	private String isSubmit = CisSubmit;

	@Column(name="lastmodify_time")
	private Timestamp lastmodifyTime;

	@Column(name="lastmodify_user")
	private String lastmodifyUser;

	@Column(name="oper_status")
	private String operStatus = CoperStatus;

	@Column(name="org_code")
	private String orgCode = CorgCode;

	public TEncyclopediaInfoEntity() {
	}

	public String getEncyclopediaId() {
		return this.encyclopediaId;
	}

	public void setEncyclopediaId(String encyclopediaId) {
		this.encyclopediaId = encyclopediaId;
	}

	public String getArtTypeDict() {
		return this.artTypeDict;
	}

	public void setArtTypeDict(String artTypeDict) {
		this.artTypeDict = artTypeDict;
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

	public String getEncyclopediaContent() {
		return this.encyclopediaContent;
	}

	public void setEncyclopediaContent(String encyclopediaContent) {
		this.encyclopediaContent = encyclopediaContent;
	}

	public String getEncyclopediaIndex() {
		return this.encyclopediaIndex;
	}

	public void setEncyclopediaIndex(String encyclopediaIndex) {
		this.encyclopediaIndex = encyclopediaIndex;
	}

	public String getEncyclopediaKeyword() {
		return this.encyclopediaKeyword;
	}

	public void setEncyclopediaKeyword(String encyclopediaKeyword) {
		this.encyclopediaKeyword = encyclopediaKeyword;
	}

	public String getEncyclopediaSource() {
		return this.encyclopediaSource;
	}

	public void setEncyclopediaSource(String encyclopediaSource) {
		this.encyclopediaSource = encyclopediaSource;
	}

	public String getEncyclopediaTitle() {
		return this.encyclopediaTitle;
	}

	public void setEncyclopediaTitle(String encyclopediaTitle) {
		this.encyclopediaTitle = encyclopediaTitle;
	}

	public String getEncyclopediaTypeDict() {
		return this.encyclopediaTypeDict;
	}

	public void setEncyclopediaTypeDict(String encyclopediaTypeDict) {
		this.encyclopediaTypeDict = encyclopediaTypeDict;
	}

	public String getInvalid() {
		return this.invalid;
	}

	public void setInvalid(String invalid) {
		this.invalid = invalid;
	}

	public String getIsSubmit() {
		return this.isSubmit;
	}

	public void setIsSubmit(String isSubmit) {
		this.isSubmit = isSubmit;
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