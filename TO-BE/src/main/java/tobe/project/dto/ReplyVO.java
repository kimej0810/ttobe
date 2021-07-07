package tobe.project.dto;

public class ReplyVO {
	private int ridx;
	private String r_content;
	private String r_writedate;
	private char delyn;
	private int tidx;
	private int bidx;
	private String profilePath;
	
	//resultMap �ㅽ��
	private MemberVO memberVO;
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	
	public int getRidx() {
		return ridx;
	}
	public void setRidx(int ridx) {
		this.ridx = ridx;
	}
	public String getR_content() {
		return r_content;
	}
	public void setR_content(String r_content) {
		this.r_content = r_content;
	}
	public String getR_writedate() {
		return r_writedate;
	}
	public void setR_writedate(String r_writedate) {
		this.r_writedate = r_writedate;
	}
	public char getDelyn() {
		return delyn;
	}
	public void setDelyn(char delyn) {
		this.delyn = delyn;
	}
	public int getTidx() {
		return tidx;
	}
	public void setTidx(int tidx) {
		this.tidx = tidx;
	}
	public int getBidx() {
		return bidx;
	}
	public void setBidx(int bidx) {
		this.bidx = bidx;
	}
	
	
}
