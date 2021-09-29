package dto;

public class LikedDto {
    private int seq;
    private String id;
    private int seq_restaurant;

    public LikedDto(int seq, String id, int seq_restaurant) {
        this.seq = seq;
        this.id = id;
        this.seq_restaurant = seq_restaurant;
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

    public int getSeq_restaurant() {
        return seq_restaurant;
    }

    public void setSeq_restaurant(int seq_restaurant) {
        this.seq_restaurant = seq_restaurant;
    }
}
