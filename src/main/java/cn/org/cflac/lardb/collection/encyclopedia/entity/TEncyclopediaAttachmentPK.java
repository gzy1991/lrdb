package cn.org.cflac.lardb.collection.encyclopedia.entity;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the t_encyclopedia_attachment database table.
 * 
 */
@Embeddable
public class TEncyclopediaAttachmentPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="encyclopedia_id", insertable=false, updatable=false)
	private String encyclopediaId;

	@Column(name="attachment_id", insertable=false, updatable=false)
	private String attachmentId;

	public TEncyclopediaAttachmentPK() {
	}
	public String getEncyclopediaId() {
		return this.encyclopediaId;
	}
	public void setEncyclopediaId(String encyclopediaId) {
		this.encyclopediaId = encyclopediaId;
	}
	public String getAttachmentId() {
		return this.attachmentId;
	}
	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof TEncyclopediaAttachmentPK)) {
			return false;
		}
		TEncyclopediaAttachmentPK castOther = (TEncyclopediaAttachmentPK)other;
		return 
			this.encyclopediaId.equals(castOther.encyclopediaId)
			&& this.attachmentId.equals(castOther.attachmentId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.encyclopediaId.hashCode();
		hash = hash * prime + this.attachmentId.hashCode();
		
		return hash;
	}
}