package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;


/**
 * The persistent class for the t_winners_opus_rel database table.
 * 
 */
@Entity
@Table(name="t_winners_opus_rel")
@NamedQuery(name="TWinnersOpusRelEntity.findAll", query="SELECT t FROM TWinnersOpusRelEntity t")
public class TWinnersOpusRelEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="winners_opus_id")
	private String winnersOpusId;

	@Column(name="opus_id")
	private String opusId;

	@Column(name="opus_label")
	private String opusLabel;

	@Column(name="winners_id")
	private String winnersId;
	
	@Column(name="opus_sort_number")
	private String opusSortNumber;

	public TWinnersOpusRelEntity() {
	}

	public String getWinnersOpusId() {
		return this.winnersOpusId;
	}

	public void setWinnersOpusId(String winnersOpusId) {
		this.winnersOpusId = winnersOpusId;
	}

	public String getOpusId() {
		return this.opusId;
	}

	public void setOpusId(String opusId) {
		this.opusId = opusId;
	}

	public String getOpusLabel() {
		return this.opusLabel;
	}

	public void setOpusLabel(String opusLabel) {
		this.opusLabel = opusLabel;
	}

	public String getWinnersId() {
		return this.winnersId;
	}

	public void setWinnersId(String winnersId) {
		this.winnersId = winnersId;
	}

	public String getOpusSortNumber() {
		return opusSortNumber;
	}

	public void setOpusSortNumber(String opusSortNumber) {
		this.opusSortNumber = opusSortNumber;
	}
	
}