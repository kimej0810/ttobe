package tobe.project.domain;

public class SearchCriteria extends Criteria {
	
	private String keyword;
	private String searchType;
	private String searchWord;
	private String userId;
	private int userIdx; 
	private int rowStartBoard;
	
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public int getRowStartBoard() {
		rowStartBoard = ((getPage() - 1) * getPerPageNum()) + 1 -1;
		if(rowStartBoard!=0) {
			rowStartBoard -= 3;
		}
		return rowStartBoard;
	}
}
