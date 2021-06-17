package tobe.project.domain.backup;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	
	private int totalCount;
	private int startPage;
	private int endPage;
	boolean prev;
	boolean next;
	private int displayPageNum = 5;
	private SearchCriteria scri;
	private Criteria cri;
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();		
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public Criteria getCri() {
		return cri;
	}
	
	public SearchCriteria getScri() {
		return scri;
	}
	public void setScri(SearchCriteria scri) {
		this.scri = scri;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	public void calcData(){
		endPage = (int) (Math.ceil(scri.getPage()/(double)displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum)+1;
		int tempEndPage = (int) (Math.ceil(totalCount/(double) scri.getPerPageNum()));
		if(endPage>tempEndPage) {
			endPage = tempEndPage;
		}			
		prev = startPage == 1 ? false : true;		
		next = endPage * scri.getPerPageNum() >= totalCount ? false : true;
	}
	public String makeQuery(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum",scri.getPerPageNum())
				.build();
		return uriComponents.toUriString();
	}
	
	 public String makeSearch(int page) { 
		 UriComponents uriComponents = UriComponentsBuilder.newInstance()
				 .queryParam("page", page)
				 .queryParam("pagePageNum", scri.getPerPageNum())
				 .queryParam("searchType",((SearchCriteria) scri).getSearchType())
				 .queryParam("keyword",encoding(((SearchCriteria) scri).getKeyword()))
				 .build();
		 return uriComponents.toUriString();
	 }
	 
	public String encoding(String keyword){
		
		if(keyword==null || keyword.trim().length()==0){
			return "";
		}		
		try{
			return URLEncoder.encode(keyword, "UTF-8");
		}catch(UnsupportedEncodingException e){
			return "";			
		}
	}
}
