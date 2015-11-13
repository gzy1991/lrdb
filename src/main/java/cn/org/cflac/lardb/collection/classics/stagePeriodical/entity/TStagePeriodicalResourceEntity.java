package cn.org.cflac.lardb.collection.classics.stagePeriodical.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the t_stage_periodical_resource database table.
 * 
 */
@Entity
@Table(name="t_stage_periodical_resource")
@NamedQuery(name="TStagePeriodicalResourceEntity.findAll", query="SELECT t FROM TStagePeriodicalResourceEntity t")
public class TStagePeriodicalResourceEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="resource_id")
	private String resourceId;

	@Column(name="attachment_id")
	private String attachmentId;

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

	@Column(name="stage_attachment_name")
	private String stageAttachmentName;

	@Column(name="stage_attachment_path")
	private String stageAttachmentPath;

	@Column(name="stage_periodical_id")
	private String stagePeriodicalId;

	public TStagePeriodicalResourceEntity() {
	}

	public String getResourceId() {
		return this.resourceId;
	}

	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}

	public String getAttachmentId() {
		return this.attachmentId;
	}

	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
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

	public String getStageAttachmentName() {
		return this.stageAttachmentName;
	}

	public void setStageAttachmentName(String stageAttachmentName) {
		this.stageAttachmentName = stageAttachmentName;
	}

	public String getStageAttachmentPath() {
		return this.stageAttachmentPath;
	}

	public void setStageAttachmentPath(String stageAttachmentPath) {
		this.stageAttachmentPath = stageAttachmentPath;
	}

	public String getStagePeriodicalId() {
		return this.stagePeriodicalId;
	}

	public void setStagePeriodicalId(String stagePeriodicalId) {
		this.stagePeriodicalId = stagePeriodicalId;
	}

}