package dto;

import java.io.Serializable;

public class WishListDto implements Serializable{
	
	private int seq;
	private String id;
	private int seqRestaurant;
	
	public WishListDto() {
	}

	public WishListDto(int seq, String id, int seqRestaurant) {
		super();
		this.seq = seq;
		this.id = id;
		this.seqRestaurant = seqRestaurant;
	}

	public WishListDto(String id) {
		super();
		this.id = id;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getSeqRestaurant() {
		return seqRestaurant;
	}

	public void setSeqRestaurant(int seqRestaurant) {
		this.seqRestaurant = seqRestaurant;
	}

	@Override
	public String toString() {
		return "MyPageDto [seq=" + seq + ", id=" + id + ", seqRestaurant=" + seqRestaurant + "]";
	}
	
	
}
