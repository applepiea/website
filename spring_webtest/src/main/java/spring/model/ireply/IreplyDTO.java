package spring.model.ireply;

public class IreplyDTO {
	
	private int inum;
	private String content; 
	private String id;
	private String regdate;
	private int imgno;
	
	@Override
	public String toString() {
		return "IreplyDTO [inum=" + inum + ", content=" + content + ", id=" + id + ", regdate=" + regdate + ", imgno="
				+ imgno + "]";
	}
	public int getInum() {
		return inum;
	}
	public void setInum(int inum) {
		this.inum = inum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getImgno() {
		return imgno;
	}
	public void setImgno(int imgno) {
		this.imgno = imgno;
	}

}
