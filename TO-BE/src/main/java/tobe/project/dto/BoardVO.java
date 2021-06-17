package tobe.project.dto;

public class BoardVO {
	private int bidx;
	private String b_type;
	private String b_title;
	private String b_content;
	private String b_writedate;
	private int b_hit;
	private char delyn;
	private int tidx;
	
	//resultMap 실험
	private MemberVO memberVO;
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	
	public int getBidx() {
		return bidx;
	}
	public void setBidx(int bidx) {
		this.bidx = bidx;
	}
	public String getB_type() {
		return b_type;
	}
	public void setB_type(String b_type) {
		this.b_type = b_type;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public String getB_writedate() {
		return b_writedate;
	}
	public void setB_writedate(String b_writedate) {
		this.b_writedate = b_writedate;
	}
	public int getB_hit() {
		return b_hit;
	}
	public void setB_hit(int b_hit) {
		this.b_hit = b_hit;
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
}
