package tobe.project.dto;

public class FileVO {
	private int fidx;
	private int tidx;
	private String f_type;
	private String f_org_file_name;
	private String f_stored_file_name;
	private String f_file_size;
	private String delyn;
	public int getFidx() {
		return fidx;
	}
	public void setFidx(int fidx) {
		this.fidx = fidx;
	}
	public int getTidx() {
		return tidx;
	}
	public void setTidx(int tidx) {
		this.tidx = tidx;
	}
	public String getF_type() {
		return f_type;
	}
	public void setF_type(String f_type) {
		this.f_type = f_type;
	}
	public String getF_org_file_name() {
		return f_org_file_name;
	}
	public void setF_org_file_name(String f_org_file_name) {
		this.f_org_file_name = f_org_file_name;
	}
	public String getF_stored_file_name() {
		return f_stored_file_name;
	}
	public void setF_stored_file_name(String f_stored_file_name) {
		this.f_stored_file_name = f_stored_file_name;
	}
	public String getF_file_size() {
		return f_file_size;
	}
	public void setF_file_size(String f_file_size) {
		this.f_file_size = f_file_size;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}

}
