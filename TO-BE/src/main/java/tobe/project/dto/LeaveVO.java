package tobe.project.dto;

public class LeaveVO {
	private int aidx;
	private String a_type;
	private String a_startdate;
	private String a_enddate;
	private String a_status;
	private String a_content;
	private String a_useddays;
	private int tidx;
	
	//MemberVO
	private MemberVO memberVO;
	
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	
	public int getAidx() {
		return aidx;
	}
	public void setAidx(int aidx) {
		this.aidx = aidx;
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
	public String getA_status() {
		return a_status;
	}
	public void setA_status(String a_status) {
		this.a_status = a_status;
	}
	public String getA_content() {
		return a_content;
	}
	public void setA_content(String a_content) {
		this.a_content = a_content;
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
}
