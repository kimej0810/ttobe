package tobe.project.dto;

public class DataLibraryVO {
	private int didx;
	private String d_title;
	private String d_writedate;
	private String d_download;
	private String delyn;
	private int tidx;
	
	public int getTidx() {
		return tidx;
	}
	public void setTidx(int tidx) {
		this.tidx = tidx;
	}
	public int getDidx() {
		return didx;
	}
	public void setDidx(int didx) {
		this.didx = didx;
	}
	public String getD_title() {
		return d_title;
	}
	public void setD_title(String d_title) {
		this.d_title = d_title;
	}
	public String getD_writedate() {
		return d_writedate;
	}
	public void setD_writedate(String d_writedate) {
		this.d_writedate = d_writedate;
	}
	public String getD_download() {
		return d_download;
	}
	public void setD_download(String d_download) {
		this.d_download = d_download;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
	@Override
	public String toString() {
		return "DataLibraryVO [didx=" + didx + ", d_title=" + d_title + ", d_writedate=" + d_writedate + ", d_download="
				+ d_download + ", delyn=" + delyn + ", tidx=" + tidx + "]";
	}
	
	
	
}
