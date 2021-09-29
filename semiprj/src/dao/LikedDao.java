package dao;

import db.DBClose;
import db.DBConnection;
import dto.RestaurantDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LikedDao {

    public static LikedDao dao = new LikedDao();

    private LikedDao() { }

    public static LikedDao getInstance() {
        return dao;
    }

    public int checkLiked(String id, int restSeq){
        String sql = "SELECT count(*) FROM LIKED WHERE ID = ? AND SEQ_RESTAURANT = ?";

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        int result = 0;

        try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 LikedDao");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1,id);
            psmt.setInt(2,restSeq);
            System.out.println("2/3 LikedDao");

            rs = psmt.executeQuery();
            System.out.println("3/3 LikedDao");

            if(rs.next()){
               result =  rs.getInt(1);
            }
            System.out.println("success LikedDao");
        } catch (SQLException throwables) {
            System.out.println("checkLiked fail");
            throwables.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return result;
    }

    public boolean addLiked(int restSeq, String id){
        String sql = "INSERT INTO LIKED VALUES(SEQ_LIKED.nextval, ?, ? )";

        Connection conn = null;
        PreparedStatement psmt = null;

        int result = 0;

        try {
            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);
            psmt.setString(1,id);
            psmt.setInt(2,restSeq);

            result = psmt.executeUpdate();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, null);
        }

        return result > 0;
    }

    public void delLiked(int restSeq, String id){
        String sql = "DELETE LIKED WHERE SEQ_RESTAURANT = ? AND ID = ?";

        Connection conn = null;
        PreparedStatement psmt = null;

        try {
            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);

            psmt.setInt(1,restSeq);
            psmt.setString(2,id);
            psmt.executeUpdate();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, null);
        }

    }
    
    /*
    //내가 좋아요한 목록의 수 --박준희 추가
    public int getAllMyLikedRestaurant(String choice, String search, String id) {

        String sql = " SELECT COUNT(*) FROM LIKED L, RESTAURANT_BBS R WHERE L.SEQ_RESTAURANT = R.SEQ  "
        		+ " AND L.ID = '" + id + "' ";

        String sWord = "";
        if(choice.equals("title")) {
            sWord = " AND R.TITLE LIKE '%" + search + "%' ";
        }else if(choice.equals("review")) {
            sWord = " AND R.REVIEW LIKE '%" + search + "%' ";
        }else if(choice.equals("name")){
            sWord = " AND R.NAME LIKE '%" + search + "%' ";
        }else if(choice.equals("location")) {
  			sWord = " AND R.LOCATION LIKE '%" + search + "%' ";
  		}

        sql = sql + sWord;

        Connection conn = null;			
        PreparedStatement psmt = null;	
        ResultSet rs = null;			

        int len = 0;

        try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 getAllMyLikedRestaurant success");

            psmt = conn.prepareStatement(sql);
            System.out.println("2/3 getAllMyLikedRestaurant success");

            rs = psmt.executeQuery();
            if(rs.next()) {
                len = rs.getInt(1);
            }
            System.out.println("3/3 getAllMyLikedRestaurant success");

        } catch (SQLException e) {
            System.out.println("getAllMyLikedRestaurant fail");
            e.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return len;
    }
   
    //내가 좋아요한 목록(검색/페이징) --박준희 추가
    public List<RestaurantDto> getMyLikedRestaurantPagingList(String choice, String search, String id, int pageNumber) {


        String sql = " SELECT  R.SEQ, R.ID, R.NAME, R.KINDS, R.TITLE, R.TEL, R.OPERATING_TIME, R.SCORE, "
        		+ "          R.LIKECOUNT, R.NEWFILENAME, FROM ( SELECT ROW_NUMBER()OVER(ORDER BY R.WDATE DESC) AS RNUM, "
                + "  R.SEQ, R.ID, R.NAME, R.KINDS, R.TITLE, R.TEL, R.OPERATING_TIME, R.SCORE, "
                + " R.LIKECOUNT, R.NEWFILENAME ";

        sql += " (SELECT COUNT(*) FROM LIKED L WHERE L.ID = '" + id + "' "
                + " AND L.SEQ_RESTAURANT = R.SEQ) AS LIKED_YN FROM RESTAURANT_BBS R ";

        String sWord = "";
        if(choice.equals("title")) {
            sWord = " AND R.TITLE LIKE '%" + search + "%' ";
        }else if(choice.equals("review")) {
            sWord = " AND R.REVIEW LIKE '%" + search + "%' ";
        }else if(choice.equals("name")){
            sWord = " AND R.NAME='" + search + "' ";
        }else if(choice.equals("location")) {
  			sWord = " AND R.LOCATION LIKE '%" + search + "%' ";
  		}
        
        sql = sql + sWord;

        sql = sql + " ORDER BY R.WDATE DESC) ";

        sql = sql + " A WHERE RNUM >= ? AND RNUM <= ? ";

        int start, end;
        start = 1 + 15 * pageNumber;	
        end = 15 + 15 * pageNumber;

        Connection conn = null;			
        PreparedStatement psmt = null;	
        ResultSet rs = null;			

        List<RestaurantDto> list = new ArrayList<RestaurantDto>();

        try {
            conn = DBConnection.getConnection();
            System.out.println("1/4 getMyLikedRestaurantPagingList success");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, start);
            psmt.setInt(2, end);
            System.out.println("2/4 getMyLikedRestaurantPagingList success");

            System.out.println("getMyLikedRestaurantPagingList sql=" + sql );

            rs = psmt.executeQuery();
            System.out.println("3/4 getMyLikedRestaurantPagingList success");

            while(rs.next()) {
                RestaurantDto dto = new RestaurantDto(rs.getInt("SEQ"),
                                                    rs.getString("ID"),
                                                    rs.getString("NAME"),
                                                    rs.getString("KINDS"),
                                                    rs.getString("TITLE"),
                                                    rs.getString("TEL"),
                                                    rs.getString("OPERATING_TIME"),
                                                    rs.getInt("SCORE"),
                                                    rs.getInt("LIKECOUNT"),
                                                    rs.getInt("LIKED_YN"),
                                                    rs.getString("NEWFILENAME"));
                list.add(dto);
            }
            System.out.println("4/4 getMyLikedRestaurantPagingList success");

        } catch (SQLException e) {
            System.out.println("getMyLikedRestaurantPagingList fail");
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return list;
    }
    */
    
    public List<RestaurantDto> getMyLikedRestaurantSearch(String choice, String search, String id) {
		
		String sql = " SELECT  R.SEQ, R.ID, R.NAME, R.TEL, R.LOCATION, R.OPERATING_TIME, R.KINDS, R.SCORE, R.LIKECOUNT, R.READCOUNT, "
				+ "  			R.TITLE, R.REVIEW, R.WDATE, R.FILENAME, R.NEWFILENAME "
				+ " FROM LIKED L, RESTAURANT_BBS R "
				+ " WHERE L.SEQ_RESTAURANT = R.SEQ "
				+ " AND L.ID = '" + id +"' " ;
		
		String sWord = "";
        if(choice.equals("title")) {
            sWord = " AND R.TITLE LIKE '%" + search + "%' ";
        }else if(choice.equals("review")) {
            sWord = " AND R.REVIEW LIKE '%" + search + "%' ";
        }else if(choice.equals("name")){
            sWord = " AND R.NAME LIKE '%" + search + "%' ";
        }else if(choice.equals("location")) {
  			sWord = " AND R.LOCATION LIKE '%" + search + "%' ";
  		}

		sql = sql + sWord;
		
		sql = sql + " ORDER BY R.WDATE DESC ";
		
		Connection conn = null;			
		PreparedStatement psmt = null;	
		ResultSet rs = null;			
		
		List<RestaurantDto> list = new ArrayList<RestaurantDto>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getMyLikedRestaurantSearch success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getMyLikedRestaurantSearch success");
			
			System.out.println("getMyLikedRestaurantPagingList sql=" + sql );
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getMyLikedRestaurantSearch success");
			
			while(rs.next()) {
				int i = 1;
	  			RestaurantDto dto = new RestaurantDto(  rs.getInt(i++),
														rs.getString(i++),
														rs.getString(i++),
														rs.getString(i++),
														rs.getString(i++),
														rs.getString(i++),
														rs.getString(i++),
														rs.getInt(i++),
														rs.getInt(i++),
														rs.getInt(i++),
														rs.getString(i++),
														rs.getString(i++),
														rs.getString(i++),
														rs.getString(i++),
														rs.getString(i++));
				list.add(dto);
			}
			System.out.println("4/4 getMyLikedRestaurantSearch success");
			
		} catch (SQLException e) {
			System.out.println("getMyLikedRestaurantSearch fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;		
	}
}
