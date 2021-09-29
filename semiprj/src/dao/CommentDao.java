package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.CommentDto;
import dto.RestaurantDto;

public class CommentDao {

	private static CommentDao dao = new CommentDao();

	private CommentDao() {
		DBConnection.initConnection();
	}

	public static CommentDao getInstance() {
		return dao;
	}

	// COMMENT테이블에 저장된 모든 댓글 반환하는 메소드 // resdto 의 seq를 부르고 싶은데..
	public List<CommentDto> getCommentList(int seq_restaurant) { // 전체 list 불러오기: [정아]
		String sql = " SELECT SEQ_RESTAURANT, ID, CONTENT, WDATE, SEQ "
				// + " DEL, REPORT_IT, STEP, DEPTH "
				+ " 	FROM COMMENT_BBS "
				// + " ORDER BY REF DESC, STEP ASC "; // 그룹별로 정렬하고, 그룹 안에서 STEP별로 정렬
				// + " ORDER BY SEQ DESC " // 최신글 상단정렬 (글 번호 순. 작성일 순으로 바꿔도 됨)
				+ " 	WHERE SEQ_RESTAURANT=?"
				+ "		ORDER BY WDATE DESC "; // 원글 seq가 얼마인지에 따라

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행
		ResultSet rs = null; // 결과 취득

		List<CommentDto> list = new ArrayList<CommentDto>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getCommentList success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq_restaurant);
			System.out.println("2/4 getCommentList success");

			rs = psmt.executeQuery();
			System.out.println("3/4 getCommentList success");

			while (rs.next()) {
				CommentDto dto = new CommentDto(rs.getInt(1), // seq_restaurant
												rs.getString(2), // id
												rs.getString(3), // content
												rs.getString(4), // wdate
												rs.getInt(5)); // tlqkf... 이거 comment의 SEQ (seq)해서 넣어주면 되는거였음.. 물론 dto 생성자도 다시 만들어야함★★★
				list.add(dto);
			}
			System.out.println("4/4 getCommentList success");

		} catch (SQLException e) {
			System.out.println("getCommentList fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
	}

	
	
	public  List<CommentDto> selectComment(int cseq) {
        String sql = " SELECT SEQ_RESTAURANT, ID, CONTENT, WDATE, SEQ " 
        			+ " FROM COMMENT_BBS WHERE SEQ=? ";
	      
	      Connection conn = null;         // DB 연결
	      PreparedStatement psmt = null;   // Query문을 실행
	      ResultSet rs = null;         // 결과 취득
	      
	      List<CommentDto> list = new ArrayList<CommentDto>();

	      try {
	         conn = DBConnection.getConnection();
	         System.out.println("1/4 selectComment success");
	         
	         psmt = conn.prepareStatement(sql);
	         System.out.println("2/4 selectComment success");
	         psmt.setInt(1, cseq);
	         
	         rs = psmt.executeQuery();
	         System.out.println("3/4 selectComment success");
	         
	         while(rs.next()) {
	            int i=1;
	            CommentDto dto = new CommentDto(rs.getInt(i++), 
	            								rs.getString(i++),
	            								rs.getString(i++),
	            								rs.getString(i++), 
	            								rs.getInt(i++));
	            list.add(dto);
	         }
	         System.out.println("4/4 selectComment success");
	         
	      } catch (SQLException e) {
	         System.out.println("selectComment fail");
	         e.printStackTrace();
	      } finally {
	         DBClose.close(conn, psmt, rs);
	      }
	      
	      return list;      
	   }

	// 댓글 정보를 전달 받아 COMMENT테이블에 저장하고 저장 행의 개수(count)를 반환하는 메소드
	public boolean writeCommentBbs(CommentDto dto) { // write : 게시물 작성 [정아]

		// sql query문 작성하기
		String sql = "INSERT INTO COMMENT_BBS(SEQ, ID, SEQ_RESTAURANT, CONTENT, WDATE, REPORT_IT ) "
				+ "VALUES(SEQ_COMMENT.NEXTVAL, ?, ?, ?, SYSDATE, 0 )";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {

			conn = DBConnection.getConnection();
			System.out.println("1/3 writeCommentBbs success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId()); // ?에 들어가는 값
			psmt.setInt(2, dto.getSeq_restaurant());
			psmt.setString(3, dto.getContent());

			System.out.println("2/3 writeCommentBbs success");

			count = psmt.executeUpdate();
			System.out.println("3/3 writeCommentBbs success");

		} catch (SQLException e) {
			System.out.println("writeCommentBbs fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0;
	}

	/*
	 * public String getWdate() {
	 * 
	 * }
	 */

	// 댓글 정보를 전달 받아 COMMENT테이블에 저장된 댓글을 변경하고 변경 행의 개수(count)를 반환하는 메소드
	public boolean updateCommentBbs(int cseq, String content) { // [정아]
		
		String sql = " UPDATE COMMENT_BBS " + " SET CONTENT=? " + " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {

			conn = DBConnection.getConnection();
			System.out.println("1/3 updateCommentBbs success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, content);
			psmt.setInt(2, cseq);
			// System.out.println(sql); // 수정 버튼 눌리면 테스트용
			System.out.println("2/3 updateCommentBbs success");

			count = psmt.executeUpdate();
			System.out.println("3/3 updateCommentBbs success");

		} catch (SQLException e) {
			System.out.println("updateCommentBbs fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0 ? true : false;
	}

	
	// 댓글번호를 전달 받아 COMMENT테이블에 저장된 댓글을 삭제하고 삭제행의 개수(count)를 반환하는 메소드
	public boolean deleteCommentBbs(int cseq) { // [정아]
		String sql = " DELETE COMMENT_BBS WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {

			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteCommentBbs success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, cseq);
			System.out.println("2/3 deleteCommentBbs success");

			count = psmt.executeUpdate();
			System.out.println("3/3 deleteCommentBbs success");

		} catch (SQLException e) {
			System.out.println("deleteCommentBbs fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0 ? true : false;
	}

	// paging // 이거 comment의 seq 필요한지 생각해보삼 --
	public List<CommentDto> getCommentPagingList(int seq_restaurant, String choice, String search, int pageNumber) {
		// search 필요x
		System.out.println("====getCommentPagingList====");
		System.out.println("seq_restaurant = " + seq_restaurant + "choice = " + choice + "search = " + search
				+ "pageNumber = " + pageNumber);
		System.out.println("====getCommentPagingList====");

		String sql = " SELECT * FROM COMMENT_BBS WHERE SEQ=? ";

		// number 설정
		sql += "(SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, "
				+ "		SEQ, SEQ_RESTAURANT, ID, CONTENT, WDATE, DEL, REPORT_IT, STEP, DEPTH"
				+ "	FROM COMMEMT_BBS WHERE SEQ_RESTAURANT=? ";

		String sWord = "";

		if (choice.equals("content")) {
			sWord = " AND CONTENT LIKE '%" + search + "%' ";
		} else if (choice.equals("id")) {
			sWord = " AND ID='" + search + "' ";
		}

		sql = sql + sWord;

		sql = sql + " ORDER BY WDATE DESC) ";

		sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";

		// ? 에 들어갈 값 준비
		int start, end;
		start = 1 + 10 * pageNumber; // 0 -> 1 ~ 10, 1 -> 11 ~ 20
		end = 10 + 10 * pageNumber;

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행
		ResultSet rs = null; // 결과 취득

		List<CommentDto> list = new ArrayList<CommentDto>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getCommentPagingList success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/4 getCommentPagingList success");

			rs = psmt.executeQuery();
			System.out.println("3/4 getCommentPagingList success");

			while (rs.next()) {
				CommentDto dto = new CommentDto(rs.getInt(1),
												rs.getInt(2), 
												rs.getString(3),
												rs.getString(4),
												rs.getString(5),
												rs.getInt(6));
				list.add(dto);

			}
			System.out.println("4/4 getCommentPagingList success");

		} catch (SQLException e) {
			System.out.println("getCommentPagingList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
	}

	public int getAllComment(int seq_restaurant, String choice, String search) {
		System.out.println("seq_restaurant = " + seq_restaurant + "choice = " + choice + "search = " + search);

		String sql = " SELECT COUNT(*) FROM RESTAURANT_BBS WHERE SEQ_RESTAURANT ='" + seq_restaurant + "' ";

		String sWord = "";
		if (choice.equals("content")) {
			sWord = " AND TITLE LIKE '%" + search + "%' ";
		} else if (choice.equals("id")) {
			sWord = " AND ID='" + search + "' ";
		}
		sql = sql + sWord;

		Connection conn = null; // DB 연결
		PreparedStatement psmt = null; // Query문을 실행
		ResultSet rs = null; // 결과 취득

		int len = 0; // return해줄 변수 생성

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllComment success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getAllComment success");
			System.out.println("getAllComment sql =" + sql);

			rs = psmt.executeQuery();
			if (rs.next()) {
				len = rs.getInt(1);
			}
			System.out.println("3/3 getAllComment success");

		} catch (SQLException e) {
			System.out.println("getAllComment fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return len;
	}
	
	
	
	
	
	
	//내가 쓴 댓글의 총수 --박준희 추가
	   public int getMyAllComment(String choice, String search, String id) {
	   
	      String sql = " SELECT COUNT(*) FROM COMMENT_BBS WHERE ID = '" + id + "' ";
	         
	      String sWord = "";
	         
	      if(choice.equals("content")) {
	            sWord = " AND CONTENT LIKE '%" + search + "%' ";
	      }
	         
	      sql = sql + sWord;
	            
	      Connection conn = null;         
	      PreparedStatement psmt = null;   
	      ResultSet rs = null;         
	         
	      int len = 0; 
	         
	      try {
	         conn = DBConnection.getConnection();
	         System.out.println("1/3 getMyAllComment success");
	            
	         psmt = conn.prepareStatement(sql);
	         System.out.println("2/3 getMyAllComment success");
	            
	         rs = psmt.executeQuery();
	            
	         if(rs.next()) {
	            len = rs.getInt(1);
	         }
	         System.out.println("3/3 getMyAllComment success");
	            
	      } catch (SQLException e) {
	         System.out.println("getMyAllComment fail");
	         e.printStackTrace();
	         
	      } finally {
	         DBClose.close(conn, psmt, rs);
	      }
	      
	        return len;
	   }
	        
	     //내가 쓴 댓글목록 보기(검색/페이징)
	     public List<CommentDto> getMyConmmentPagingList(String choice, String search, int pageNumber, String id){
	           
	        String sql = " SELECT SEQ, SEQ_RESTAURANT, ID, CONTENT, WDATE, REPORT_IT "
	                    + " FROM ";
	                 
	        sql += " (SELECT ROW_NUMBER()OVER(ORDER BY WDATE DESC) AS RNUM, "
	              + " SEQ, SEQ_RESTAURANT, ID, CONTENT, WDATE, REPORT_IT "
	              + " FROM COMMENT_BBS WHERE ID = '" + id +"' ";
	           
	        String sWord = "";
	           
	        if(choice.equals("content")) {
	           sWord = " AND CONTENT LIKE '%" + search + "%' ";
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
	           
	        List<CommentDto> list = new ArrayList<CommentDto>();
	                 
	        try {
	           conn = DBConnection.getConnection();
	           System.out.println("1/4 getMyConmmentPagingList success");
	              
	           psmt = conn.prepareStatement(sql);
	           psmt.setInt(1, start);
	           psmt.setInt(2, end);
	           
	           
	           System.out.println("2/4 getMyConmmentPagingList success");
	           
	           rs = psmt.executeQuery();
	           System.out.println("3/4 getMyConmmentPagingList success");
	              
	           while(rs.next()) {
	           int i = 1;
	           CommentDto dto = new CommentDto( rs.getInt(i++), 
	                                    rs.getInt(i++),
	                                    rs.getString(i++),
	                                    rs.getString(i++), 
	                                    rs.getString(i++), 
	                                    rs.getInt(i++));
	              list.add(dto);
	           }
	           System.out.println("4/4 getMyConmmentPagingList success");
	              
	           } catch (SQLException e) {
	              System.out.println("getMyConmmentPagingList fail");
	              e.printStackTrace();
	              
	           } finally{
	              DBClose.close(conn, psmt, rs);
	           }
	        
	           return list;
	        }

}
