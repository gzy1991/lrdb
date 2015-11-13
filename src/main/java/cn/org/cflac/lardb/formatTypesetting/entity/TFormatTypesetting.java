package cn.org.cflac.lardb.formatTypesetting.entity;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the t_format_typesetting database table.
 * 
 */
@Entity
@Table(name="t_format_typesetting")
@NamedQuery(name="TFormatTypesetting.findAll", query="SELECT t FROM TFormatTypesetting t")
public class TFormatTypesetting extends com.css.sword.core.kernel.base.dataElement.AbsPersistObject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="formatsetting_id")
	private String formatsettingId;

	private String firLineIndent;

	private String justify;

	private int paraAfterNum;

	private int paraPreNum;

	private String phoCenter;

	private int rowSpanNum;

	private String selFont;

	private int selFontSize;

	public TFormatTypesetting() {
	}

	public String getFormatsettingId() {
		return this.formatsettingId;
	}

	public void setFormatsettingId(String formatsettingId) {
		this.formatsettingId = formatsettingId;
	}

	public String getFirLineIndent() {
		return this.firLineIndent;
	}

	public void setFirLineIndent(String firLineIndent) {
		this.firLineIndent = firLineIndent;
	}

	public String getJustify() {
		return this.justify;
	}

	public void setJustify(String justify) {
		this.justify = justify;
	}

	public int getParaAfterNum() {
		return this.paraAfterNum;
	}

	public void setParaAfterNum(int paraAfterNum) {
		this.paraAfterNum = paraAfterNum;
	}

	public int getParaPreNum() {
		return this.paraPreNum;
	}

	public void setParaPreNum(int paraPreNum) {
		this.paraPreNum = paraPreNum;
	}

	public String getPhoCenter() {
		return this.phoCenter;
	}

	public void setPhoCenter(String phoCenter) {
		this.phoCenter = phoCenter;
	}

	public int getRowSpanNum() {
		return this.rowSpanNum;
	}

	public void setRowSpanNum(int rowSpanNum) {
		this.rowSpanNum = rowSpanNum;
	}

	public String getSelFont() {
		return this.selFont;
	}

	public void setSelFont(String selFont) {
		this.selFont = selFont;
	}

	public int getSelFontSize() {
		return this.selFontSize;
	}

	public void setSelFontSize(int selFontSize) {
		this.selFontSize = selFontSize;
	}

}