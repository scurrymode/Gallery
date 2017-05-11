package gallery.model;

public class Gallery {
	private int Gallery_id;
	private String writer;
	private String title;
	private String content;
	private String regdate;
	private int hit;
	private String user_filename;
	
	
	public int getGallery_id() {
		return Gallery_id;
	}
	public void setGallery_id(int gallery_id) {
		Gallery_id = gallery_id;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getUser_filename() {
		return user_filename;
	}
	public void setUser_filename(String user_filename) {
		this.user_filename = user_filename;
	}
	
	
	
}
