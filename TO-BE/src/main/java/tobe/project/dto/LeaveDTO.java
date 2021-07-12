package tobe.project.dto;

public class LeaveDTO {
	private int eidx;
	private String a_type;
	private String a_startdate;
	private String a_enddate;
	private String a_useddays;
	private int tidx;
	private int t_leave_get;
	
	public int getEidx() {
		return eidx;
	}
	public void setEidx(int eidx) {
		this.eidx = eidx;
	}
	public String getA_type() {
		return a_type;
	}
	public void setA_type(String a_type) {
		this.a_type = a_type;
	}
	public String getA_startdate() {
		return a_startdate;
	}
	public void setA_startdate(String a_startdate) {
		this.a_startdate = a_startdate;
	}
	public String getA_enddate() {
		return a_enddate;
	}
	public void setA_enddate(String a_enddate) {
		this.a_enddate = a_enddate;
	}
	public String getA_useddays() {
		return a_useddays;
	}
	public void setA_useddays(String a_useddays) {
		this.a_useddays = a_useddays;
	}
	public int getTidx() {
		return tidx;
	}
	public void setTidx(int tidx) {
		this.tidx = tidx;
	}
	public int getT_leave_get() {
		return t_leave_get;
	}
	public void setT_leave_get(int t_leave_get) {
		this.t_leave_get = t_leave_get;
	}
}
