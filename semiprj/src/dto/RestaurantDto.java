package dto;

import java.io.Serializable;

// Bulletin Board System
public class RestaurantDto implements Serializable {
	private int seq;    // 글 번호

	private String id; // member id
	private String name;    // 가게명
	private String tel;        // 전화번호
	private String location;    // 주소
	private String operatingTime;    // 영업시간
	private String kinds; //음식분류 한식,중식,양식,일식,기타

	private int score;    // 평점

	/* 삭제예정
	private int wish; // 찜하기
	private int hateCount;    // 싫어요 수
	private int del;
	*/
	private int likedYn; //좋아요 여부 확인
	private int likeCount;    // 좋아요 수
	private int readCount;	//조회 수

	private String title;    // 글 제목
	private String review;    // 후기(본문)
	private String wdate;    // 작성일

	private String fileName; // (이미지업로드용) 파일명
	private String newFileName;    // 위와 같음

	public RestaurantDto(int seq, String id, String name, String tel, String location, String operatingTime, String kinds, int score, int likeCount, int readCount, String title, String review, String wdate, String fileName, String newFileName) {
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.tel = tel;
		this.location = location;
		this.operatingTime = operatingTime;
		this.kinds = kinds;
		this.score = score;
		this.likeCount = likeCount;
		this.readCount = readCount;
		this.title = title;
		this.review = review;
		this.wdate = wdate;
		this.fileName = fileName;
		this.newFileName = newFileName;
	}

	// List에서 사용하는 생성자
	public RestaurantDto(int seq, String id, String name, String kinds, String title, String tel, String operatingTime, int score, int likeCount, int likedYn, String newFileName){
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.kinds = kinds;
		this.title = title;
		this.tel = tel;
		this.operatingTime = operatingTime;
		this.score = score;
		this.likeCount = likeCount;
		this.likedYn = likedYn;
		this.newFileName = newFileName;
	}

	//write시 사용하는 생성자
	public RestaurantDto(String id, String name, String tel, String location, String operatingTime, String kinds, int score, String title, String review, String fileName, String newFileName) {
		this.id = id;
		this.name = name;
		this.tel = tel;
		this.location = location;
		this.operatingTime = operatingTime;
		this.kinds = kinds;
		this.score = score;
		this.title = title;
		this.review = review;
		this.fileName = fileName;
		this.newFileName = newFileName;
	}

	//updateAf
	public RestaurantDto(int seq, String id, String name, String tel, String location, String operatingTime, String kinds, int score, String title, String review, String fileName, String newFileName) {
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.tel = tel;
		this.location = location;
		this.operatingTime = operatingTime;
		this.kinds = kinds;
		this.score = score;
		this.title = title;
		this.review = review;
		this.fileName = fileName;
		this.newFileName = newFileName;
	}

	//Detail


	public RestaurantDto(int seq, String id, String name, String tel, String location, String operatingTime, String kinds, int score, int likedYn, int likeCount, int readCount, String title, String review, String wdate, String newFileName) {
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.tel = tel;
		this.location = location;
		this.operatingTime = operatingTime;
		this.kinds = kinds;
		this.score = score;
		this.likedYn = likedYn;
		this.likeCount = likeCount;
		this.readCount = readCount;
		this.title = title;
		this.review = review;
		this.wdate = wdate;
		this.newFileName = newFileName;
	}

	public int getLikedYn() {
		return likedYn;
	}

	public void setLikedYn(int likedYn) {
		this.likedYn = likedYn;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public String getKinds() {
		return kinds;
	}

	public void setKinds(String kinds) {
		this.kinds = kinds;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getOperatingTime() {
		return operatingTime;
	}

	public void setOperatingTime(String operatingTime) {
		this.operatingTime = operatingTime;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getNewFileName() {
		return newFileName;
	}

	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}


	@Override
	public String toString() {
		return "RestaurantDto{" +
				"seq=" + seq +
				", id='" + id + '\'' +
				", title='" + title + '\'' +
				", review='" + review + '\'' +
				", kinds='" + kinds + '\'' +
				", name='" + name + '\'' +
				", tel='" + tel + '\'' +
				", location='" + location + '\'' +
				", operatingTime='" + operatingTime + '\'' +
				", score=" + score +
				", wdate='" + wdate + '\'' +
				", fileName='" + fileName + '\'' +
				", newFileName='" + newFileName + '\'' +
				'}';
	}
}
