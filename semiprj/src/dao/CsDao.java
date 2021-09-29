package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.CsDto;

public class CsDao {
	
	private static CsDao dao = null;
	
	private CsDao() {
		
	}
	
	public static CsDao getInstance() {
		
		if(dao == null) {
			dao = new CsDao();
		}
		return dao;		
	}
	
	////////////////////////////////////////////////////////////////////////////////////// csList 구현용
	
	// 글목록을 가져오기
	public List<CsDto> getCsList(){ // csList에서 사용[영신]
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, TYPE, DEL "
				   + " FROM CS_BBS "
				   + " ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;			// DB 연결
		PreparedStatement psmt = null;	// Query문을 실행
		ResultSet rs = null;			// 결과 취득
		
		List<CsDto> list = new ArrayList<CsDto>();
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getCsList success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getCsList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getCsList success");
			
			while(rs.next()) {
				int n = 1;
				CsDto dto = new CsDto(	rs.getInt(n++),
										rs.getString(n++),
										rs.getInt(n++),
										rs.getInt(n++),
										rs.getInt(n++),
										rs.getString(n++),
										rs.getString(n++),
										rs.getString(n++),
										rs.getInt(n++),
										rs.getInt(n++));
				list.add(dto);
			}
			System.out.println("4/4 getCsList success");	
			
		} catch (SQLException e) {
			System.out.println("getCsList fail");	
			e.printStackTrace();
			
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}
	
	public List<CsDto> getSearchList(String choice, String search){ // csList에서 사용[영신]
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, TYPE, DEL "
				   + " FROM CS_BBS ";
		
		String sWord = "";

		if(choice.equals("title")) {
			sWord = " WHERE TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) {
			sWord = " WHERE CONTENT LIKE '%" + search + "%' ";
		}else if(choice.equals("id")) {
			sWord = " WHERE ID='" + search + "' ";
		}
		
		sql += sWord + " ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;			// DB 연결
		PreparedStatement psmt = null;	// Query문을 실행
		ResultSet rs = null;			// 결과 취득
		
		List<CsDto> list = new ArrayList<CsDto>();
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getSearchList success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getSearchList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getSearchList success");
			
			while(rs.next()) {
				
				int n = 1;
				CsDto dto = new CsDto(	rs.getInt(n++),
										rs.getString(n++),
										rs.getInt(n++),
										rs.getInt(n++),
										rs.getInt(n++),
										rs.getString(n++),
										rs.getString(n++),
										rs.getString(n++),
										rs.getInt(n++),
										rs.getInt(n++));
				list.add(dto);
			}
			System.out.println("4/4 getSearchList success");
			
		} catch (SQLException e) {
			System.out.println("getSearchList fail");
			e.printStackTrace();
			
		} finally{
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}
	
	public int getAllCs(String choice, String search) { // csList에서 사용[영신]
		System.out.println("choice : " + choice);
		System.out.println("search : " + search);
		String sql = " SELECT COUNT(*) FROM CS_BBS ";
		
		String sWord = "";
		
		if(choice.equals("title")) {
			sWord = " WHERE TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) {
			sWord = " WHERE CONTENT LIKE '%" + search + "%' ";
		}else if(choice.equals("id")) {
			sWord = " WHERE ID='" + search + "' ";
		}
		
		sql = sql + sWord;
		
		System.out.println("getallc = "+ sql);
		Connection conn = null;			// DB 연결
		PreparedStatement psmt = null;	// Query문을 실행
		ResultSet rs = null;			// 결과 취득
		
		int len = 0; // BBS list length
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllCs success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getAllCs success");
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				len = rs.getInt(1);
			}
			System.out.println("3/3 getAllCs success");
			
		} catch (SQLException e) {
			System.out.println("getAllCs fail");
			e.printStackTrace();
			
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return len;
	}
	
	public List<CsDto> getCsPagingList(String choice, String search, int pageNumber){ // csList에서 사용[영신]
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, TYPE, DEL "
				   + " FROM ";
		
		sql += " (SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, "
			 + " SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, TYPE, DEL "
			 + " FROM CS_BBS ";
		
		String sWord = "";
		
		if(choice.equals("title")) {
			sWord = " WHERE TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) {
			sWord = " WHERE CONTENT LIKE '%" + search + "%' ";
		}else if(choice.equals("id")) {
			sWord = " WHERE ID='" + search + "' ";
		}
		
		sql += sWord
			+ " ORDER BY REF DESC, STEP ASC) "
			+ " WHERE RNUM >= ? AND RNUM <= ? ";
		
		int start, end;
		start = 1 + 15 * pageNumber;
		end = 15 + 15 * pageNumber;
		
		Connection conn = null;			// DB 연결
		PreparedStatement psmt = null;	// Query문을 실행
		ResultSet rs = null;			// 결과 취득
		
		List<CsDto> list = new ArrayList<CsDto>();
		
		System.out.println("sql=" + sql);
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getCsPagingList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/4 getCsPagingList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getCsPagingList success");
			
			while(rs.next()) {
				
				int n = 1;
				CsDto dto = new CsDto(	rs.getInt(n++),
										rs.getString(n++),
										rs.getInt(n++),
										rs.getInt(n++),
										rs.getInt(n++),
										rs.getString(n++),
										rs.getString(n++),
										rs.getString(n++),
										rs.getInt(n++),
										rs.getInt(n++));
				list.add(dto);
			}
			System.out.println("4/4 getCsPagingList success");
			
		} catch (SQLException e) {
			System.out.println("getCsPagingList fail");
			e.printStackTrace();
			
		} finally{
			DBClose.close(conn, psmt, rs);
		}
		
		
		System.out.println("list size()" + list.size());
		
		return list;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////csDetail 구현용
	
	public CsDto getCs(int seq) { // csDetail에서 사용[영신]
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, TYPE, DEL "
				   + " FROM CS_BBS "
				   + " WHERE SEQ=? ";
		
		Connection conn = null;			
		PreparedStatement psmt = null;	
		ResultSet rs = null;	
		
		CsDto dto = null;		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getCs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 getCs success");
	
			rs = psmt.executeQuery();
		
			if(rs.next()) {
				int n = 1;
				dto = new CsDto(	rs.getInt(n++),
									rs.getString(n++),
									rs.getInt(n++),
									rs.getInt(n++),
									rs.getInt(n++),
									rs.getString(n++),
									rs.getString(n++),
									rs.getString(n++),
									rs.getInt(n++),
									rs.getInt(n++));
			}
			System.out.println("3/3 getCs success");
		
		} catch (SQLException e) {
			System.out.println("getCs fail");
			e.printStackTrace();
			
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////csWrite 구현용
	
	public boolean writeCs(CsDto dto) { // csWrite에서 사용[영신]
		
		String sql = " INSERT INTO CS_BBS (SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, TYPE, DEL) "
				   + " VALUES (SEQ_CS.NEXTVAL, ?, (SELECT NVL(MAX(REF), 0)+1 FROM CS_BBS), 0, 0, ?, ?, SYSDATE, ?, 0) "; 

		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0; // 추가가 되었다는 확인 변수
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 writeCs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setInt(4, dto.getType());
			System.out.println("2/3 writeCs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 writeCs success");			
			
		} catch (SQLException e) {			
			System.out.println("writeCs fail");
			e.printStackTrace();
			
		} finally {				
			DBClose.close(conn, psmt, null);			
		}
		return count>0?true:false;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////csUpdate 구현용
	
	public boolean updateCs(int seq, String title, String content, int type) { // csUpdate에서 사용[영신]

		String sql = " UPDATE CS_BBS " 
				   + " SET TITLE = ?, CONTENT = ?, TYPE = ? "
				   + " WHERE SEQ = ? "; 
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 updateCs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, type);
			psmt.setInt(4, seq);
			System.out.println("2/3 updateCs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 updateCs success");			
			
		} catch (SQLException e) {			
			System.out.println("updateCs fail");
			e.printStackTrace();
			
		} finally {				
			DBClose.close(conn, psmt, null);			
		}
		
		return count>0?true:false;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////csDelete 구현용	
	
	public boolean deleteCs(int seq) { // csDelete에서 사용[영신]

		String sql = " UPDATE CS_BBS " 
				   + " SET DEL = 1"
				   + " WHERE SEQ = ? "; 
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteCs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 deleteCs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteCs success");			
			
		} catch (SQLException e) {			
			System.out.println("deleteCs fail");
			e.printStackTrace();
			
		} finally {				
			DBClose.close(conn, psmt, null);			
		}
		return count>0?true:false;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////csAnswer 구현용	
	
	public boolean answerCs(int seq, CsDto bbs) {
		// update
		String sql1 = " UPDATE CS_BBS "
					+ "	SET STEP=STEP+1 "
					+ " WHERE REF = (SELECT REF FROM CS_BBS WHERE SEQ=?) "
					+ " AND STEP > (SELECT STEP FROM CS_BBS WHERE SEQ=?) ";
		
		// insert
		String sql2 = " INSERT INTO CS_BBS(SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, TYPE, DEL) "
					+ " VALUES(SEQ_CS.NEXTVAL, ?, "
					+ "		  (SELECT REF FROM CS_BBS WHERE SEQ=?), "
					+ "		  (SELECT STEP FROM CS_BBS WHERE SEQ=?) + 1, "
					+ "		  (SELECT DEPTH FROM CS_BBS WHERE SEQ=?) + 1, ?, ?, SYSDATE, ?, 0) ";
		
		Connection conn = null;			
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 answerCs success");
			
			// update
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("2/6 answerCs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 answerCs success");
			
			// psmt 초기화
			psmt.clearParameters();
			
			// insert
			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, bbs.getId());
			psmt.setInt(2, seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, bbs.getTitle());
			psmt.setString(6, bbs.getContent());
			psmt.setInt(7, bbs.getType());
			System.out.println("4/6 answerCs success");
			
			count = psmt.executeUpdate();
			System.out.println("5/6 answerCs success");
			
			conn.commit();
			System.out.println("6/6 answerCs success");
			
		} catch (SQLException e) {
			System.out.println("answerCs fail");			
			try {
				conn.rollback();
			} catch (SQLException e1) {				
				e1.printStackTrace();
			}			
			e.printStackTrace();
			
		} finally {			
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBClose.close(conn, psmt, null);			
		}
		
		return count>0?true:false;		
	}
	
	//내가 쓴 고객센터 글의 총수 -- 박준희 추가
	public int getMyAllCs(String choice, String search, String id) {

		String sql = " SELECT COUNT(*) FROM CS_BBS WHERE ID = '" + id + "' AND DEL = 0 ";
		
		String sWord = "";
		
		if(choice.equals("title")) {
			sWord = "  AND TITLE LIKE '%" + search + "%' ";
			
		}else if(choice.equals("content")) {
			sWord = " AND CONTENT LIKE '%" + search + "%' ";
		}
		
		sql = sql + sWord;
		
		Connection conn = null;			
		PreparedStatement psmt = null;	
		ResultSet rs = null;			
		
		int len = 0; 
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getMyAllCs success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getMyAllCs success");
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				len = rs.getInt(1);
			}
			System.out.println("3/3 getMyAllCs success");
			
		} catch (SQLException e) {
			System.out.println("getMyAllCs fail");
			e.printStackTrace();
			
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return len;
	}
		
	//내가 쓴 고객센터글 글목록 보기(검색/페이징) -- 박준희 추가
	public List<CsDto> getMyCsPagingList(String choice, String search, int pageNumber, String id){
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, TYPE, DEL "
				   + " FROM ";
				
		sql += " (SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, "
			 + " SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, TYPE, DEL "
			 + " FROM CS_BBS WHERE ID = '" + id +"' AND DEL = 0 ";
		
		String sWord = "";
		
		if(choice.equals("title")) {
			sWord = " AND TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) {
			sWord = " AND CONTENT LIKE '%" + search + "%' ";
		}
						
		sql += sWord
			+ " ORDER BY REF DESC, STEP ASC) "
			+ " WHERE RNUM >= ? AND RNUM <= ? ";
		
		int start, end;
		start = 1 + 15 * pageNumber;
		end = 15 + 15 * pageNumber;
		
		Connection conn = null;			
		PreparedStatement psmt = null;	
		ResultSet rs = null;		
		
		List<CsDto> list = new ArrayList<CsDto>();
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getMyCsPagingList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			
			System.out.println("2/4 getMyCsPagingList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getMyCsPagingList success");
			
			while(rs.next()) {
				int i = 1;
				CsDto dto = new CsDto(	rs.getInt(i++),
										rs.getString(i++),
										rs.getInt(i++),
										rs.getInt(i++),
										rs.getInt(i++),
										rs.getString(i++),
										rs.getString(i++),
										rs.getString(i++),
										rs.getInt(i++),
										rs.getInt(i++));
				list.add(dto);
			}
			System.out.println("4/4 getMyCsPagingList success");
			
		} catch (SQLException e) {
			System.out.println("getMyCsPagingList fail");
			e.printStackTrace();
			
		} finally{
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}
}
