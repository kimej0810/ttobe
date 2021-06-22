package tobe.project.dto;

public class ScheduleVO {
	private int sidx;
	private String s_type;
	private String s_title;
	private String s_startDate;
	private String s_endDate;
	private String s_content;
	private String delYn;
	private int tidx;
	
	public int getTidx() {
		return tidx;
	}
	public void setTidx(int tidx) {
		this.tidx = tidx;
	}
	private int midx;
	public int getMidx() {
		return midx;
	}
	public void setMidx(int midx) {
		this.midx = midx;
	}
	public int getSidx() {
		return sidx;
	}
	public void setSidx(int sidx) {
		this.sidx = sidx;
	}
	public String getS_type() {
		return s_type;
	}
	public void setS_type(String s_type) {
		this.s_type = s_type;
	}
	public String getS_title() {
		return s_title;
	}
	public void setS_title(String s_title) {
		this.s_title = s_title;
	}
	public String getS_startDate() {
		return s_startDate;
	}
	public void setS_startDate(String s_startDate) {
		this.s_startDate = s_startDate;
	}
	public String getS_endDate() {
		return s_endDate;
	}
	public void setS_endDate(String s_endDate) {
		this.s_endDate = s_endDate;
	}
	public String getS_content() {
		return s_content;
	}
	public void setS_content(String s_content) {
		this.s_content = s_content;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	
	
	
}
