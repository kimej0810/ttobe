package tobe.project.dto;

public class ApprovalVO {
	private int eidx;
	private int e_documentNum;
	private String e_type;
	private String e_rule;
	private String e_draftDate;
	private String e_startDay;
	private String e_con;
	private String e_member;
	private String e_send;
	private String e_buseo;
	private String e_textTitle;
	private String e_textContent;
	private String delyn;
	private String e_status;
	private String e_approvalnoyn;
	private String e_reason; 
	private int tidx;
	private MemberVO memberVO;
	private ApprovalLineVO approvalLineVO;
	
	public String getE_type() {
		return e_type;
	}
	public void setE_type(String e_type) {
		this.e_type = e_type;
	}
	
	public String getE_approvalNoyn() {
		return e_approvalnoyn;
	}
	public void setE_approvalNoyn(String e_approvalnoyn) {
		this.e_approvalnoyn = e_approvalnoyn;
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
	public int getE_documentNum() {
		return e_documentNum;
	}
	public void setE_documentNum(int e_documentNum) {
		this.e_documentNum = e_documentNum;
	}
	public String getE_rule() {
		return e_rule;
	}
	public void setE_rule(String e_rule) {
		this.e_rule = e_rule;
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
	public String getE_member() {
		return e_member;
	}
	public void setE_member(String e_member) {
		this.e_member = e_member;
	}
	public String getE_send() {
		return e_send;
	}
	public void setE_send(String e_send) {
		this.e_send = e_send;
	}
	public String getE_buseo() {
		return e_buseo;
	}
	public void setE_buseo(String e_buseo) {
		this.e_buseo = e_buseo;
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
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
	
	
}