package cn.org.cflac.lardb.fileUpload.entity;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.AbsPersistObject;
import com.css.sword.core.kernel.base.dataElement.IValueObject;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * The persistent class for the t_attachment_document database table.
 * 
 */
@Entity
@Table(name="t_attachment_document")
@NamedQuery(name="TAttachmentDocument.findAll", query="SELECT t FROM TAttachmentDocument t")
public class TAttachmentDocument extends AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="document_id")
	private String documentId;

	@Column(name="art_type_dict")
	private String artTypeDict;

	@Column(name="attachment_id")
	private String attachmentId;

	@Column(name="create_time")
	private Timestamp createTime;

	@Column(name="create_user")
	private String createUser;

	@Lob
	@Column(name="document_introduction")
	private String documentIntroduction;

	@Column(name="document_language")
	private String documentLanguage;

	@Column(name="document_level_dict")
	private String documentLevelDict;

	@Column(name="document_name")
	private String documentName;

	@Column(name="document_source")
	private String documentSource;

	@Column(name="document_state_dict")
	private String documentStateDict;

	@Column(name="document_type_dict")
	private String documentTypeDict;

	private String invalid;

	@Column(name="is_audit")
	private String isAudit;

	@Column(name="last_modify_time")
	private Timestamp lastModifyTime;

	@Column(name="last_modify_user")
	private String lastModifyUser;

	@Column(name="oper_status")
	private String operStatus;

	@Column(name="org_code")
	private String orgCode;

	@Column(name="theme_custom_mix")
	private String themeCustomMix;

	@Column(name="theme_standard_dict")
	private String themeStandardDict;

	@Transient
	private TAttachmentInfo attachdetailinfo;
	
	public TAttachmentDocument() {
	}

	public String getDocumentId() {
		return this.documentId;
	}

	public TAttachmentInfo getAttachdetailinfo() {
        return attachdetailinfo;
    }

    public void setAttachdetailinfo(TAttachmentInfo attachdetailinfo) {
        this.attachdetailinfo = attachdetailinfo;
    }

    public void setDocumentId(String documentId) {
		this.documentId = documentId;
	}

	public String getArtTypeDict() {
		return this.artTypeDict;
	}

	public void setArtTypeDict(String artTypeDict) {
		this.artTypeDict = artTypeDict;
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

	public String getDocumentIntroduction() {
		return this.documentIntroduction;
	}

	public void setDocumentIntroduction(String documentIntroduction) {
		this.documentIntroduction = documentIntroduction;
	}

	public String getDocumentLanguage() {
		return this.documentLanguage;
	}

	public void setDocumentLanguage(String documentLanguage) {
		this.documentLanguage = documentLanguage;
	}

	public String getDocumentLevelDict() {
		return this.documentLevelDict;
	}

	public void setDocumentLevelDict(String documentLevelDict) {
		this.documentLevelDict = documentLevelDict;
	}

	public String getDocumentName() {
		return this.documentName;
	}

	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}

	public String getDocumentSource() {
		return this.documentSource;
	}

	public void setDocumentSource(String documentSource) {
		this.documentSource = documentSource;
	}

	public String getDocumentStateDict() {
		return this.documentStateDict;
	}

	public void setDocumentStateDict(String documentStateDict) {
		this.documentStateDict = documentStateDict;
	}

	public String getDocumentTypeDict() {
		return this.documentTypeDict;
	}

	public void setDocumentTypeDict(String documentTypeDict) {
		this.documentTypeDict = documentTypeDict;
	}

	public String getInvalid() {
		return this.invalid;
	}

	public void setInvalid(String invalid) {
		this.invalid = invalid;
	}

	public String getIsAudit() {
		return this.isAudit;
	}

	public void setIsAudit(String isAudit) {
		this.isAudit = isAudit;
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

	public String getOrgCode() {
		return this.orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getThemeCustomMix() {
		return this.themeCustomMix;
	}

	public void setThemeCustomMix(String themeCustomMix) {
		this.themeCustomMix = themeCustomMix;
	}

	public String getThemeStandardDict() {
		return this.themeStandardDict;
	}

	public void setThemeStandardDict(String themeStandardDict) {
		this.themeStandardDict = themeStandardDict;
	}

}