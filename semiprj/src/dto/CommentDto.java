package dto;

import java.io.Serializable;

public class CommentDto implements Serializable {
	private int cseq;	// 댓글 번호
	private int seq_restaurant; // 게시물 번호

	private String id; // 댓글 작성자 id
	private String content; // 댓글 내용
	private String wdate; // 작성일

	private int report_it; // 신고하기


	
	
	public CommentDto( int cseq, int seq_restaurant, String id, String content, String wdate, int report_it ) {
		super();
		this.cseq = cseq;
		this.seq_restaurant = seq_restaurant;
		this.id = id;
		this.content = content;
		this.wdate = wdate;
		this.report_it = report_it;

	}
	
	public CommentDto(int seq_restaurant, String id, String content) { //write , update
		super();
		this.seq_restaurant = seq_restaurant;
		this.id = id;
		this.content = content;
	}
	
	
	public CommentDto(int seq_restaurant, String id, String content, String wdate, int cseq) { // 외부에서 들어오는 것 (2) 6/28 AM10:23 -> Dao에서 list용
		super();
		this.seq_restaurant = seq_restaurant;
		this.id = id;
		this.content = content;
		this.wdate = wdate;
		this.cseq = cseq;
	}


	public CommentDto(int cseq, int seq_restaurant, String id, String content) { // commentwrite.jsp 에서 쓰려고 만듦
		super();
		this.cseq = cseq;
		this.seq_restaurant = seq_restaurant;
		this.id = id;
		this.content = content;
	}
	

	public int getCseq() {
		return cseq;
	}

	public void setCseq(int cseq) {
		this.cseq = cseq;
	}

	public int getSeq_restaurant() {
		return seq_restaurant;
	}

	public void setSeq_restaurant(int seq_restaurant) {
		this.seq_restaurant = seq_restaurant;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getReport_it() {
		return report_it;
	}

	public void setReport_it(int report_it) {
		this.report_it = report_it;
	}

	
	
	
}

