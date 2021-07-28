package tobe.project.dto;

public class ApprovalVO {
	private int eidx;
	private String e_status;
	private String e_type;
	private String e_draftDate;
	private String e_startDay;
	private String e_endDay;
	private String e_con;
	private String e_textTitle;
	private String e_textContent;
	private int tidx;
	private String delYn;
	private String e_approvalNoYn;
	private String e_approvalNoDay;
	private String e_approvalNoPerson;
	private String e_reason; 
	private MemberVO memberVO;
	private ApprovalLineVO approvalLineVO;
	
	
	public String getE_approvalNoDay() {
		return e_approvalNoDay;
	}
	public void setE_approvalNoDay(String e_approvalNoDay) {
		this.e_approvalNoDay = e_approvalNoDay;
	}
	public String getE_endDay() {
		return e_endDay;
	}
	public void setE_endDay(String e_endDay) {
		this.e_endDay = e_endDay;
	}
	public String getE_type() {
		return e_type;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	
	public String getE_approvalNoYn() {
		return e_approvalNoYn;
	}
	public void setE_approvalNoYn(String e_approvalNoYn) {
		this.e_approvalNoYn = e_approvalNoYn;
	}
	public String getE_approvalNoPerson() {
		return e_approvalNoPerson;
	}
	public void setE_approvalNoPerson(String e_approvalNoPerson) {
		this.e_approvalNoPerson = e_approvalNoPerson;
	}
	public void setE_type(String e_type) {
		this.e_type = e_type;
	}
	public String getE_reason() {
		return e_reason;
	}
	public void setE_reason(String e_reason) {
		this.e_reason = e_reason;
	}
	 
	public ApprovalLineVO getApprovalLineVO() { 
		return approvalLineVO; 
	}
	public void setApprovalLineVO(ApprovalLineVO approvalLineVO) {
		this.approvalLineVO = approvalLineVO;
	}
	public int getTidx() {
		return tidx;
	}
	public void setTidx(int tidx) {
		this.tidx = tidx;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public String getE_status() {
		return e_status;
	}
	public void setE_status(String e_status) {
		this.e_status = e_status;
	}
	public int getEidx() {
		return eidx;
	}
	public void setEidx(int eidx) {
		this.eidx = eidx;
	}
	public String getE_draftDate() {
		return e_draftDate;
	}
	public void setE_draftDate(String e_draftDate) {
		this.e_draftDate = e_draftDate;
	}
	public String getE_startDay() {
		return e_startDay;
	}
	public void setE_startDay(String e_startDay) {
		this.e_startDay = e_startDay;
	}
	public String getE_con() {
		return e_con;
	}
	public void setE_con(String e_con) {
		this.e_con = e_con;
	}
	public String getE_textTitle() {
		return e_textTitle;
	}
	public void setE_textTitle(String e_textTitle) {
		this.e_textTitle = e_textTitle;
	}
	public String getE_textContent() {
		return e_textContent;
	}
	public void setE_textContent(String e_textContent) {
		this.e_textContent = e_textContent;
	}
}