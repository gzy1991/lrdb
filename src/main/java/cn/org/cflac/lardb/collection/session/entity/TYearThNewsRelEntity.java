package cn.org.cflac.lardb.collection.session.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.css.sword.core.kernel.base.dataElement.IValueObject;


/**
 * The persistent class for the t_year_th_news_rel database table.
 * 
 */
@Entity
@Table(name="t_year_th_news_rel")
@NamedQuery(name="TYearThNewsRelEntity.findAll", query="SELECT t FROM TYearThNewsRelEntity t")
public class TYearThNewsRelEntity extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable ,IValueObject {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="t_year_th_news_id")
	private String tYearThNewsId;

	@Column(name="news_id")
	private String newsId;

	@Column(name="year_th_id")
	private String yearThId;
	
	@Column(name="year_th_news_sort_number")
	private Integer yearThNewsSortNumber;

	public TYearThNewsRelEntity() {
	}

	public String getTYearThNewsId() {
		return this.tYearThNewsId;
	}

	public void setTYearThNewsId(String tYearThNewsId) {
		this.tYearThNewsId = tYearThNewsId;
	}

	public String getNewsId() {
		return this.newsId;
	}

	public void setNewsId(String newsId) {
		this.newsId = newsId;
	}

	public String getYearThId() {
		return this.yearThId;
	}

	public void setYearThId(String yearThId) {
		this.yearThId = yearThId;
	}

	public Integer getYearThNewsSortNumber() {
		return yearThNewsSortNumber;
	}

	public void setYearThNewsSortNumber(Integer yearThNewsSortNumber) {
		this.yearThNewsSortNumber = yearThNewsSortNumber;
	}
	
}