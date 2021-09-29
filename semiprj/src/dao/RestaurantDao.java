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

public class RestaurantDao {

    private static RestaurantDao dao = new RestaurantDao();

    private RestaurantDao(){
    }

    public static RestaurantDao getInstance() {
        return dao;
    }

    public List<RestaurantDto> getRestaurantList(String location){  // restaurantList.jsp에서 사용 [동준]
        String sql = "SELECT SEQ, ID, NAME, KINDS, TITLE, TEL, OPERATING_TIME, SCORE, LIKECOUNT, NEWFILENAME FROM RESTAURANT_BBS WHERE LOCATION = ?";

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        RestaurantDto dto = null;
        List<RestaurantDto> list = new ArrayList<RestaurantDto>();

        try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 getRestaurantList success");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1,location);
            System.out.println("2/3 getRestaurantList success");

            rs = psmt.executeQuery();
            while(rs.next()){
                dto = new RestaurantDto( rs.getInt("SEQ"),
                                         rs.getString("ID"),
                                         rs.getString("NAME"),
                                         rs.getString("KINDS"),
                                         rs.getString("TITLE"),
                                         rs.getString("TEL"),
                                         rs.getString("OPERATING_TIME"),
                                         rs.getInt("SCORE"),
                                         rs.getInt("LIKECOUNT"),
                                         rs.getInt("LIKED_YN"),
                                         rs.getString("NEWFILENAME")
                                        );
                list.add(dto);
            }
            System.out.println("3/3 getRestaurantList success");

        } catch (SQLException throwables) {
            System.out.println("getRestaurantList fail");
            throwables.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return list;
    }

    public RestaurantDto getRestaurant(String loginId, int seq){ // restaurantDetail.jsp 동준
        String sql = "SELECT "
            + " SEQ, ID, NAME, KINDS, TITLE, REVIEW, LOCATION, TEL, OPERATING_TIME, SCORE, LIKECOUNT, READCOUNT, WDATE, NEWFILENAME, LIKED_YN FROM "
            + " ( SELECT T1.SEQ "
                        + ", T1.ID "
                        + ", T1.NAME "
                        + ", T1.KINDS "
                        + ", T1.TITLE "
                        + ", T1.REVIEW "
                        + ", T1.LOCATION"
                        + ", T1.TEL "
                        + ", T1.OPERATING_TIME "
                        + ", T1.SCORE "
                        + ", T1.LIKECOUNT "
                        + ", T1.READCOUNT "
                        + ", T1.WDATE "
                        + ", T1.NEWFILENAME "
                        + ", (SELECT COUNT(*) FROM LIKED T2 WHERE T2.ID = ? AND T2.SEQ_RESTAURANT = T1.SEQ) AS LIKED_YN "
                + " FROM "                                             //현재 게시물을 보고 있는 ID
                    + " RESTAURANT_BBS T1 "
                + " WHERE T1.SEQ = ? "
            + " ) ";


        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        RestaurantDto dto = null;

        try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 getRestaurant success");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1,loginId);
            psmt.setInt(2,seq);
            System.out.println("2/3 getRestaurant success");

            rs = psmt.executeQuery();
            if(rs.next()){

                dto = new RestaurantDto(
                                        rs.getInt("SEQ"),
                                        rs.getString("ID"),
                                        rs.getString("NAME"),
                                        rs.getString("TEL"),
                                        rs.getString("LOCATION"),
                                        rs.getString("OPERATING_TIME"),
                                        rs.getString("KINDS"),
                                        rs.getInt("SCORE"),
                                        rs.getInt("LIKED_YN"),
                                        rs.getInt("LIKECOUNT"),
                                        rs.getInt("READCOUNT"),
                                        rs.getString("TITLE"),
                                        rs.getString("REVIEW"),
                                        rs.getString("WDATE"),
                                        rs.getString("NEWFILENAME")
                                    );
            }
            System.out.println("3/3 getRestaurant success");

        } catch (SQLException throwables) {
            throwables.printStackTrace();
            System.out.println("getRestaurant fail");
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return dto;
    }
    /*public boolean likeCount(int seq){
        String sql = " UPDATE RESTAURANT_BBS SET LIKECOUNT = LIKECOUNT + 1 WHERE SEQ = ? ";


        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        int count = 0;

        try {
            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);

            psmt.setInt(1,seq);
            count = psmt.executeUpdate();

        } catch (SQLException throwables) {
            System.out.println("likeCount fail");
            throwables.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, null);
        }

        return count > 0 ;
    }*/

   /* public boolean hateCount(int seq){
        String sql = " UPDATE RESTAURANT_BBS SET HATECOUNT = HATECOUNT + 1 WHERE SEQ = ? ";


        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        int count = 0;

        try {
            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);

            psmt.setInt(1,seq);
            count = psmt.executeUpdate();

        } catch (SQLException throwables) {
            System.out.println("hateCount fail");
            throwables.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, null);
        }

        return count > 0 ;
    }*/

    public boolean readCount(int seq){
        String sql = " UPDATE RESTAURANT_BBS SET READCOUNT = READCOUNT + 1 WHERE SEQ = ? ";


        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        int count = 0;

        try {
            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);

            psmt.setInt(1,seq);
            count = psmt.executeUpdate();



        } catch (SQLException throwables) {
            System.out.println("likeCount fail");
            throwables.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, null);
        }

        return count > 0 ;
    }

    public boolean delRestaurant(int seq){

        String sql = "DELETE FROM RESTAURANT_BBS WHERE SEQ = ?";

        Connection conn = null;
        PreparedStatement psmt = null;

        int count = 0;

        try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 delRestaurant success");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1,seq);
            System.out.println("2/3 delRestaurant success");

            count = psmt.executeUpdate();
            System.out.println("3/3 delRestaurant success");

        } catch (SQLException throwables) {
            System.out.println("delRestaurant fail");
            throwables.printStackTrace();
        }

        return count > 0;
    }

    public boolean writeRestaurant (RestaurantDto dto){

        String sql =" INSERT INTO RESTAURANT_BBS VALUES(SEQ_RESTAURANT.nextval, ?, ?, ?, ?, ?, ?, ?, "
                     +" 0, 0, ?, ?, sysdate, ?, ?)";

        Connection conn = null;
        PreparedStatement psmt = null;

        int count = 0;

        try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 writeRestaurant success");

            psmt = conn.prepareStatement(sql);
            System.out.println("2/3 writeRestaurant success");

            //id, name, tel, location, opertime, kinds, score, title, review, filename, newfilename
            psmt.setString(1,dto.getId());
            psmt.setString(2,dto.getName());
            psmt.setString(3,dto.getTel());
            psmt.setString(4,dto.getLocation());
            psmt.setString(5,dto.getOperatingTime());
            psmt.setString(6,dto.getKinds());
            psmt.setInt(7,dto.getScore());
            psmt.setString(8,dto.getTitle());
            psmt.setString(9, dto.getReview());
            psmt.setString(10,dto.getFileName());
            psmt.setString(11,dto.getNewFileName());
            count = psmt.executeUpdate();
            System.out.println("3/3 writeRestaurant success");

        } catch (SQLException throwables) {
            System.out.println("writeRestaurant fail");
            throwables.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, null);
        }

        return count > 0;
    }

    public List<RestaurantDto> getRestaurantPagingList(String loginId, String location, String choice, String search, int pageNumber) {


        String sql = " SELECT A.* FROM ( SELECT ROW_NUMBER()OVER(ORDER BY T1.WDATE DESC) AS RNUM "
                + " , T1.SEQ, T1.ID, T1.NAME, T1.KINDS, T1.TITLE, T1.TEL, T1.OPERATING_TIME, T1.SCORE "
                + " , T1.LIKECOUNT, T1.NEWFILENAME,";

        // 1. number설정
        sql += " (SELECT COUNT(*) FROM LIKED T2 WHERE T2.ID = '" + loginId + "'"
                + " AND T2.SEQ_RESTAURANT = T1.SEQ) AS LIKED_YN FROM RESTAURANT_BBS T1 ";

        sql += " WHERE T1.LOCATION = '" + location + "'";

        String sWord = "";
        if(choice.equals("title")) {
            sWord = " AND TITLE LIKE '%" + search + "%' ";
        }else if(choice.equals("review")) {
            sWord = " AND REVIEW LIKE '%" + search + "%' ";
        }else if(choice.equals("id")) {
            sWord = " AND ID='" + search + "' ";
        }else if(choice.equals("name")){
            sWord = " AND NAME='" + search + "' ";
        }
        sql = sql + sWord;

        sql = sql + " ORDER BY T1.WDATE DESC) ";

        sql = sql + " A WHERE RNUM >= ? AND RNUM <= ? ";

        int start, end;
        start = 1 + 12 * pageNumber;	// 0 -> 1 ~ 10	1 -> 11 ~ 20
        end = 12 + 12 * pageNumber;

        Connection conn = null;			// DB 연결
        PreparedStatement psmt = null;	// Query문을 실행
        ResultSet rs = null;			// 결과 취득

        List<RestaurantDto> list = new ArrayList<RestaurantDto>();

        try {
            conn = DBConnection.getConnection();
            System.out.println("1/4 getRestaurantListPage success");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, start);
            psmt.setInt(2, end);
            System.out.println("2/4 getRestaurantListPage success");

            System.out.println("getRestaurantPaging sql=" + sql );

            rs = psmt.executeQuery();
            System.out.println("3/4 getRestaurantListPage success");

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
            System.out.println("4/4 getRestaurantListPage success");

        } catch (SQLException e) {
            System.out.println("getRestaurantListPage fail");
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return list;
    }
    public int getAllRestaurant(String location, String choice, String search) {

        String sql = " SELECT COUNT(*) FROM RESTAURANT_BBS WHERE LOCATION ='" + location + "' ";

        String sWord = "";
        if(choice.equals("title")) {
            sWord = " AND TITLE LIKE '%" + search + "%' ";
        }else if(choice.equals("review")) {
            sWord = " AND REVIEW LIKE '%" + search + "%' ";
        }else if(choice.equals("id")) {
            sWord = " AND ID='" + search + "' ";
        }else if(choice.equals("name")){
            sWord = " AND NAME LIKE '%" + search + "%' ";
        }

        sql = sql + sWord;

        Connection conn = null;			// DB 연결
        PreparedStatement psmt = null;	// Query문을 실행
        ResultSet rs = null;			// 결과 취득

        int len = 0;

        try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 getAllRestaurant success");

            psmt = conn.prepareStatement(sql);
            System.out.println("2/3 getAllRestaurant success");

            rs = psmt.executeQuery();
            if(rs.next()) {
                len = rs.getInt(1);
            }
            System.out.println("3/3 getAllRestaurant success");

        } catch (SQLException e) {
            System.out.println("getAllRestaurant fail");
            e.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return len;
    }
    public boolean updateRestaurant(RestaurantDto dto){
        String sql = "UPDATE RESTAURANT_BBS SET TEL=?, LOCATION=?, OPERATING_TIME=?, KINDS=?," +
                " SCORE=?, TITLE=?, REVIEW=?, FILENAME=?, NEWFILENAME=?, NAME=? WHERE SEQ=? ";

        Connection conn = null;
        PreparedStatement psmt = null;

        int count = 0;
        try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 updateRestaurant success");
            psmt = conn.prepareStatement(sql);

            psmt.setString(1,dto.getTel());
            psmt.setString(2,dto.getLocation());
            psmt.setString(3, dto.getOperatingTime());
            psmt.setString(4,dto.getKinds());
            psmt.setInt(5,dto.getScore());
            psmt.setString(6, dto.getTitle());
            psmt.setString(7,dto.getReview());
            psmt.setString(8,dto.getFileName());
            psmt.setString(9,dto.getNewFileName());
            psmt.setString(10,dto.getName());
            psmt.setInt(11,dto.getSeq());

            count = psmt.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, null);
        }

        return count > 0;

    }

    public void likeCount(String msg, int restSeq){

        String sql = "";

        if(msg.equals("plus")){
            sql += "UPDATE RESTAURANT_BBS SET LIKECOUNT = LIKECOUNT + 1 WHERE SEQ = ?";
        }else if(msg.equals("minus")){
            sql += "UPDATE RESTAURANT_BBS SET LIKECOUNT = LIKECOUNT - 1 WHERE SEQ = ?";
        }

        Connection conn = null;
        PreparedStatement psmt = null;

        try {
            conn = DBConnection.getConnection();
            psmt = conn.prepareStatement(sql);

            psmt.setInt(1,restSeq);
            psmt.executeUpdate();


        } catch (SQLException throwables) {
            System.out.println("likeCount fail");
            throwables.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, null);
        }
    }
    
    //내가 쓴 글의 총수 -- 박준희 추가
  	public int getMyAllRestaurant(String choice, String search, String id) {

  		String sql = " SELECT COUNT(*) FROM RESTAURANT_BBS WHERE ID = '" + id + "' ";
  			
  		String sWord = "";
  			
  		if(choice.equals("title")) {
  			sWord = " AND TITLE LIKE '%" + search + "%' ";
  		}else if(choice.equals("content")) {
  			sWord = " AND REVIEW LIKE '%" + search + "%' ";
  		}else if(choice.equals("name")) {
  			sWord = " AND NAME LIKE'%" + search + "%' ";
  		}else if(choice.equals("location")) {
  			sWord = " AND LOCATION LIKE '%" + search + "%' ";
  		}
  		
  		sql = sql + sWord;
  				
  		Connection conn = null;			
  		PreparedStatement psmt = null;	
  		ResultSet rs = null;			
  			
  		int len = 0; 
  			
  		try {
  			conn = DBConnection.getConnection();
  			System.out.println("1/3 getMyAllRestaurant success");
  				
  			psmt = conn.prepareStatement(sql);
  			System.out.println("2/3 getMyAllRestaurant success");
  				
  			rs = psmt.executeQuery();
  				
  			if(rs.next()) {
  				len = rs.getInt(1);
  			}
  			System.out.println("3/3 getMyAllRestaurant success");
  				
  		} catch (SQLException e) {
  			System.out.println("getMyAllRestaurant fail");
  			e.printStackTrace();
  		} finally {
  			DBClose.close(conn, psmt, rs);
  		}
  		  return len;
  	}
  		
  	//내가 쓴 글목록 보기(검색/페이징) -- 박준희 추가
  	public List<RestaurantDto> getMyRestaurantPagingList(String choice, String search, int pageNumber, String id){
  			
  		String sql = " SELECT SEQ, ID, NAME, TEL, LOCATION, OPERATING_TIME, KINDS, SCORE, LIKECOUNT, READCOUNT, "
  				+ "	TITLE, REVIEW, WDATE, FILENAME, NEWFILENAME "
  					   + " FROM ";
  					
  		sql += " (SELECT ROW_NUMBER()OVER(ORDER BY WDATE DESC) AS RNUM, "
  				+ " SEQ, ID, NAME, TEL, LOCATION, OPERATING_TIME, KINDS, SCORE, LIKECOUNT, READCOUNT, "
  				+ " TITLE, REVIEW, WDATE, FILENAME, NEWFILENAME "
  				+ " FROM RESTAURANT_BBS WHERE ID = '" + id +"' ";
  			
  		String sWord = "";
  			
  		if(choice.equals("title")) {
  			sWord = " AND TITLE LIKE '%" + search + "%' ";
  		}else if(choice.equals("content")) {
  			sWord = " AND REVIEW LIKE '%" + search + "%' ";
  		}else if(choice.equals("name")) {
  			sWord = " AND NAME LIKE'%" + search + "%' ";
  		}else if(choice.equals("location")) {
  			sWord = " AND LOCATION LIKE '%" + search + "%' ";
  		}
  		
  		sql += sWord
  			+ " ORDER BY WDATE DESC) "
  			+ " WHERE RNUM >= ? AND RNUM <= ? ";
  			
  		int start, end;
  		start = 1 + 15 * pageNumber;
  		end = 15 + 15 * pageNumber;
  		
  		Connection conn = null;			
  		PreparedStatement psmt = null;	
  		ResultSet rs = null;			
  			
  		List<RestaurantDto> list = new ArrayList<RestaurantDto>();
  					
  		try {
  			conn = DBConnection.getConnection();
  			System.out.println("1/4 getMyRestaurantPagingList success");
  				
  			psmt = conn.prepareStatement(sql);
  			psmt.setInt(1, start);
  			psmt.setInt(2, end);
  		
  			System.out.println("2/4 getMyRestaurantPagingList success");
  				
  			rs = psmt.executeQuery();
  			System.out.println("3/4 getMyRestaurantPagingList success");
  				
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
  			System.out.println("4/4 getMyRestaurantPagingList success");
  				
  			} catch (SQLException e) {
  				System.out.println("getMyRestaurantPagingList fail");
  				e.printStackTrace();
  				
  			} finally{
  				DBClose.close(conn, psmt, rs);
  			}
  		
  			return list;
  		}	
  	
    //관리자뷰 전체게시글 총수 -- 박준희 추가
  	public int getManagerRestaurant(String choice, String search) {

  		String sql = " SELECT COUNT(*) FROM RESTAURANT_BBS ";
  			
  		String sWord = "";
  			
  		if(choice.equals("title")) {
  			sWord = " WHERE TITLE LIKE '%" + search + "%' ";
  		}else if(choice.equals("content")) {
  			sWord = " WHERE REVIEW LIKE '%" + search + "%' ";
  		}else if(choice.equals("id")) {
  			sWord = " WHERE ID LIKE '%" + search + "%' ";
  		}else if(choice.equals("name")) {
  			sWord = " WHERE NAME LIKE'%" + search + "%' ";
  		}else if(choice.equals("location")) {
  			sWord = " WHERE LOCATION LIKE '%" + search + "%' ";
  		}
  		
  		
  		sql = sql + sWord;
  				
  		Connection conn = null;			
  		PreparedStatement psmt = null;	
  		ResultSet rs = null;			
  			
  		int len = 0; 
  			
  		try {
  			conn = DBConnection.getConnection();
  			System.out.println("1/3 getManagerRestaurant success");
  				
  			psmt = conn.prepareStatement(sql);
  			System.out.println("2/3 getManagerRestaurant success");
  				
  			rs = psmt.executeQuery();
  				
  			if(rs.next()) {
  				len = rs.getInt(1);
  			}
  			System.out.println("3/3 getManagerRestaurant success");
  				
  		} catch (SQLException e) {
  			System.out.println("getManagerRestaurant fail");
  			e.printStackTrace();
  		} finally {
  			DBClose.close(conn, psmt, rs);
  		}
  		  return len;
  	}
  		
  	//관리자뷰 전체게시글 보기(검색/페이징) -- 박준희 추가
  	public List<RestaurantDto> getManagerRestaurantPagingList(String choice, String search, int pageNumber){
  			
  		String sql = " SELECT SEQ, ID, NAME, TEL, LOCATION, OPERATING_TIME, KINDS, SCORE, LIKECOUNT, READCOUNT, "
  				+ "	TITLE, REVIEW, WDATE, FILENAME, NEWFILENAME "
  					   + " FROM ";
  					
  		sql += " (SELECT ROW_NUMBER()OVER(ORDER BY WDATE DESC) AS RNUM, "
  				+ " SEQ, ID, NAME, TEL, LOCATION, OPERATING_TIME, KINDS, SCORE, LIKECOUNT, READCOUNT, "
  				+ " TITLE, REVIEW, WDATE, FILENAME, NEWFILENAME "
  				+ " FROM RESTAURANT_BBS ";
  			
  		String sWord = "";
  			
  		if(choice.equals("title")) {
  			sWord = " WHERE TITLE LIKE '%" + search + "%' ";
  		}else if(choice.equals("content")) {
  			sWord = " WHERE REVIEW LIKE '%" + search + "%' ";
  		}else if(choice.equals("id")) {
  			sWord = " WHERE ID LIKE '%" + search + "%' ";
  		}else if(choice.equals("name")) {
  			sWord = " WHERE NAME LIKE '%" + search + "%' ";
  		}else if(choice.equals("location")) {
  			sWord = " WHERE LOCATION LIKE '%" + search + "%' ";
  		}
  		
  		
  		sql += sWord
  			+ " ORDER BY WDATE DESC) "
  			+ " WHERE RNUM >= ? AND RNUM <= ? ";
  			
  		int start, end;
  		start = 1 + 15 * pageNumber;
  		end = 15 + 15 * pageNumber;
  		
  		Connection conn = null;			
  		PreparedStatement psmt = null;	
  		ResultSet rs = null;			
  			
  		List<RestaurantDto> list = new ArrayList<RestaurantDto>();
  					
  		try {
  			conn = DBConnection.getConnection();
  			System.out.println("1/4 getManagerRestaurantPagingList success");
  				
  			psmt = conn.prepareStatement(sql);
  			psmt.setInt(1, start);
  			psmt.setInt(2, end);
  		
  			System.out.println("2/4 getManagerRestaurantPagingList success");
  				
  			rs = psmt.executeQuery();
  			System.out.println("3/4 getManagerRestaurantPagingList success");
  				
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
  			System.out.println("4/4 getManagerRestaurantPagingList success");
  				
  			} catch (SQLException e) {
  				System.out.println("getManagerRestaurantPagingList fail");
  				e.printStackTrace();
  				
  			} finally{
  				DBClose.close(conn, psmt, rs);
  			}
  		
  			return list;
  		}	
  		
  	public List<RestaurantDto> getRestaurantPagingTotalList(String loginId, String choice, String search, int pageNumber) {


        String sql = " SELECT A.* FROM ( SELECT ROW_NUMBER()OVER(ORDER BY T1.WDATE DESC) AS RNUM "
                + " , T1.SEQ, T1.ID, T1.NAME, T1.KINDS, T1.TITLE, T1.TEL, T1.OPERATING_TIME, T1.SCORE "
                + " , T1.LIKECOUNT, T1.NEWFILENAME,";

        // 1. number설정
        sql += " (SELECT COUNT(*) FROM LIKED T2 WHERE T2.ID = '" + loginId + "'"
                + " AND T2.SEQ_RESTAURANT = T1.SEQ) AS LIKED_YN FROM RESTAURANT_BBS T1 ";


        String sWord = "";
        if(choice.equals("title")) {
            sWord = " WHERE TITLE LIKE '%" + search + "%' ";
        }else if(choice.equals("review")) {
            sWord = " WHERE REVIEW LIKE '%" + search + "%' ";
        }else if(choice.equals("id")) {
            sWord = " WHERE ID='" + search + "' ";
        }else if(choice.equals("name")){
            sWord = " WHERE NAME LIKE '%" + search + "%' ";
        }
        sql = sql + sWord;

        sql = sql + " ORDER BY T1.WDATE DESC) ";

        sql = sql + " A WHERE RNUM >= ? AND RNUM <= ? ";

        int start, end;
        start = 1 + 12 * pageNumber;   // 0 -> 1 ~ 10   1 -> 11 ~ 20
        end = 12 + 12 * pageNumber;

        Connection conn = null;         // DB 연결
        PreparedStatement psmt = null;   // Query문을 실행
        ResultSet rs = null;         // 결과 취득

        List<RestaurantDto> list = new ArrayList<RestaurantDto>();

        try {
            conn = DBConnection.getConnection();
            System.out.println("1/4 getRestaurantListPageTotal success");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, start);
            psmt.setInt(2, end);
            System.out.println("2/4 getRestaurantListPageTotal success");

            System.out.println("getRestaurantPagingTotal sql=" + sql );

            rs = psmt.executeQuery();
            System.out.println("3/4 getRestaurantListPageTotal success");

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
            System.out.println("4/4 getRestaurantListPageTotal success");

        } catch (SQLException e) {
            System.out.println("getRestaurantListPageTotal fail");
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return list;
    }
    public int getAllRestaurantTotal(String choice, String search) {

        String sql = " SELECT COUNT(*) FROM RESTAURANT_BBS ";

        String sWord = "";
        if(choice.equals("title")) {
            sWord = " WHERE TITLE LIKE '%" + search + "%' ";
        }else if(choice.equals("review")) {
            sWord = " WHERE REVIEW LIKE '%" + search + "%' ";
        }else if(choice.equals("id")) {
            sWord = " WHERE ID='" + search + "' ";
        }else if(choice.equals("name")){
            sWord = " WHERE NAME LIKE '%" + search + "%' ";
        }

        sql = sql + sWord;

        Connection conn = null;         // DB 연결
        PreparedStatement psmt = null;   // Query문을 실행
        ResultSet rs = null;         // 결과 취득

        int len = 0;

        try {
            conn = DBConnection.getConnection();
            System.out.println("1/3 getAllRestaurant success");

            psmt = conn.prepareStatement(sql);
            System.out.println("2/3 getAllRestaurant success");

            rs = psmt.executeQuery();
            if(rs.next()) {
                len = rs.getInt(1);
            }
            System.out.println("3/3 getAllRestaurant success");

        } catch (SQLException e) {
            System.out.println("getAllRestaurant fail");
            e.printStackTrace();
        } finally {
            DBClose.close(conn, psmt, rs);
        }

        return len;
    }
}

