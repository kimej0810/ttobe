package tobe.project.dto;

import java.util.List;

public class EmailVO {
	private int midx;
	private String m_addressee;
	private String m_senddate;
	private String m_title;
	private String m_content;
	private String delyn;
	private List<MemberVO> memberVOList;
	public int getMidx() {
		return midx;
	}
	public void setMidx(int midx) {
		this.midx = midx;
	}
	public String getM_addressee() {
		return m_addressee;
	}
	public void setM_addressee(String m_addressee) {
		this.m_addressee = m_addressee;
	}
	public String getM_senddate() {
		return m_senddate;
	}
	public void setM_senddate(String m_senddate) {
		this.m_senddate = m_senddate;
	}
	public String getM_title() {
		return m_title;
	}
	public void setM_title(String m_title) {
		this.m_title = m_title;
	}
	public String getM_content() {
		return m_content;
	}
	public void setM_content(String m_content) {
		this.m_content = m_content;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
	public List<MemberVO> getMemberVOList() {
		return memberVOList;
	}
	public void setMemberVOList(List<MemberVO> memberVOList) {
		this.memberVOList = memberVOList;
	}
}
