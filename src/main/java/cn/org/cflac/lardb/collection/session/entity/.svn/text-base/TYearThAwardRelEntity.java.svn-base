package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;


/**
 * The persistent class for the t_year_th_award_rel database table.
 * 
 */
@Entity
@Table(name="t_year_th_award_rel")
@NamedQuery(name="TYearThAwardRelEntity.findAll", query="SELECT t FROM TYearThAwardRelEntity t")
public class TYearThAwardRelEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="t_year_th_award_id")
	private String tYearThAwardId;

	@Column(name="award_code")
	private String awardCode;

	@Column(name="year_th_id")
	private String yearThId;

	public TYearThAwardRelEntity() {
	}

	public String getTYearThAwardId() {
		return this.tYearThAwardId;
	}

	public void setTYearThAwardId(String tYearThAwardId) {
		this.tYearThAwardId = tYearThAwardId;
	}

	public String getAwardCode() {
		return this.awardCode;
	}

	public void setAwardCode(String awardCode) {
		this.awardCode = awardCode;
	}

	public String getYearThId() {
		return this.yearThId;
	}

	public void setYearThId(String yearThId) {
		this.yearThId = yearThId;
	}

}