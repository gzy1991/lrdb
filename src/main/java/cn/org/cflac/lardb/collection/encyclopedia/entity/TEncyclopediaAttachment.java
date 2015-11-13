package cn.org.cflac.lardb.collection.encyclopedia.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the t_encyclopedia_attachment database table.
 * 
 */
@Entity
@Table(name="t_encyclopedia_attachment")
@NamedQuery(name="TEncyclopediaAttachment.findAll", query="SELECT t FROM TEncyclopediaAttachment t")
public class TEncyclopediaAttachment extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private TEncyclopediaAttachmentPK id;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	@Column(name="encyclopedia_attachment_path")
	private String encyclopediaAttachmentPath;

	@Column(name="encyclopedia_attachment_title")
	private String encyclopediaAttachmentTitle;

	private String invalid;

	@Column(name="lastmodify_time")
	private Timestamp lastmodifyTime;

	@Column(name="lastmodify_user")
	private String lastmodifyUser;

	@Column(name="oper_status")
	private String operStatus;

	@Column(name="org_code")
	private String orgCode;

	public TEncyclopediaAttachment() {
	}

	public TEncyclopediaAttachmentPK getId() {
		return this.id;
	}

	public void setId(TEncyclopediaAttachmentPK id) {
		this.id = id;
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

	public String getEncyclopediaAttachmentPath() {
		return this.encyclopediaAttachmentPath;
	}

	public void setEncyclopediaAttachmentPath(String encyclopediaAttachmentPath) {
		this.encyclopediaAttachmentPath = encyclopediaAttachmentPath;
	}

	public String getEncyclopediaAttachmentTitle() {
		return this.encyclopediaAttachmentTitle;
	}

	public void setEncyclopediaAttachmentTitle(String encyclopediaAttachmentTitle) {
		this.encyclopediaAttachmentTitle = encyclopediaAttachmentTitle;
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