package cn.org.cflac.lardb.fileUpload.entity;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.AbsPersistObject;

import java.sql.Timestamp;


/**
 * The persistent class for the t_attachment_info database table.
 * 
 */
@Entity
@Table(name="t_attachment_info")
@NamedQuery(name="TAttachmentInfo.findAll", query="SELECT t FROM TAttachmentInfo t")
public class TAttachmentInfo extends AbsPersistObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="attachment_id")
	private String attachmentId;

	@Column(name="attachment_md5")
	private String attachmentMd5;

	@Column(name="attachment_name")
	private String attachmentName;

	@Column(name="attachment_path")
	private String attachmentPath;

	@Column(name="attachment_size")
	private Double attachmentSize;

	@Column(name="attachment_type")
	private String attachmentType;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	private String invalid;

	@Column(name="last_modify_time")
	private Timestamp lastModifyTime;

	@Column(name="last_modify_user")
	private String lastModifyUser;

	@Column(name="oper_status")
	private String operStatus;
	
	@Column(name="is_completed")
    private String isCompleted;

	public TAttachmentInfo() {
	}

	public String getAttachmentId() {
		return this.attachmentId;
	}

	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
	}

	public String getAttachmentMd5() {
		return this.attachmentMd5;
	}

	public void setAttachmentMd5(String attachmentMd5) {
		this.attachmentMd5 = attachmentMd5;
	}

	public String getAttachmentName() {
		return this.attachmentName;
	}

	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}

	public String getAttachmentPath() {
		return this.attachmentPath;
	}

	public void setAttachmentPath(String attachmentPath) {
		this.attachmentPath = attachmentPath;
	}

	public Double getAttachmentSize() {
		return this.attachmentSize;
	}

	public void setAttachmentSize(Double attachmentSize) {
		this.attachmentSize = attachmentSize;
	}

	public String getAttachmentType() {
		return this.attachmentType;
	}

	public void setAttachmentType(String attachmentType) {
		this.attachmentType = attachmentType;
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

	public Timestamp getLastModifyTime() {
		return this.lastModifyTime;
	}

	public void setLastModifyTime(Timestamp lastModifyTime) {
		this.lastModifyTime = lastModifyTime;
	}

	public String getLastModifyUser() {
		return this.lastModifyUser;
	}

	public void setLastModifyUser(String lastModifyUser) {
		this.lastModifyUser = lastModifyUser;
	}

	public String getOperStatus() {
		return this.operStatus;
	}

	public void setOperStatus(String operStatus) {
		this.operStatus = operStatus;
	}

    public String getIsCompleted() {
        return isCompleted;
    }

    public void setIsCompleted(String isCompleted) {
        this.isCompleted = isCompleted;
    }

}