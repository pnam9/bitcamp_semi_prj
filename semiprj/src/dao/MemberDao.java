package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {
	
	public static MemberDao dao = new MemberDao();
	
	private MemberDao() {
		DBConnection.initConnection();
	}
	public static MemberDao getInstance() {
		return dao;
	}
	
	public boolean addMember(MemberDto dto) { // 회원가입 멤버추가
		
        String sql = " INSERT INTO MEMBER(ID, PWD, NAME, BIRTH, GENDER, EMAIL, ADDR, AUTH) "
                + " VALUES(?, ?, ?, ?, ?, ?, ?, 1) ";

		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addMember success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getBirth());
			psmt.setString(5, dto.getGender());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getAddr());
			System.out.println("2/3 addMember success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addMember success");
			
		} catch (SQLException e) {
			System.out.println("addMember fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}
	
public boolean getId(String id) { //아이디 중복값 체크
		
		String sql = " SELECT ID "
				   + " FROM MEMBER "
				   + " WHERE ID=? ";
		
		Connection conn = null;			// DB 연결
		PreparedStatement psmt = null;	// Query문을 실행
		ResultSet rs = null;			// 결과 취득
		
		boolean findId = false;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/3 getId success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				findId = true;
			}
			System.out.println("3/3 getId success");
		
		} catch (SQLException e) {
			System.out.println("getId fail");			
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return findId;
	}
	
	public MemberDto login(MemberDto dto) {
		String sql = " SELECT ID, NAME, BIRTH, GENDER, EMAIL, ADDR, AUTH "
				   + " FROM MEMBER "
				   + " WHERE ID=? AND PWD=? ";
		
		Connection conn = null;			
		PreparedStatement psmt = null;	
		ResultSet rs = null;
		
		MemberDto mem = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 login success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			System.out.println("2/3 login success");
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				String id = rs.getString(1);
				String name = rs.getString(2);
				String birth = rs.getString(3);
				String gender = rs.getString(4);
				String email = rs.getString(5);
				String addr = rs.getString(6);
				int auth = rs.getInt(7);
				
				mem = new MemberDto(id, null, name, birth, gender, email, addr, auth);
			}
			System.out.println("3/3 login success");
			
		} catch (SQLException e) {
			System.out.println("login fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return mem;		
	}
	

	
	public String findid(String name, String email) {
		String id = null;
		
		String sql = " SELECT ID "
				+ " FROM MEMBER "
				+ " WHERE NAME=? AND "
				+ " EMAIL=? ";
		
		Connection conn = null;			
		PreparedStatement psmt = null;	
		ResultSet rs = null;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 findid success");

			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, name);
			psmt.setString(2, email);
			System.out.println("2/3 findid success");
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				id=rs.getString("id");
			}
			System.out.println("3/3 findid success");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("findid fail");

		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return id;
	}
	

	public String findpw(String id, String name, String birth) {
		
		String pwd = null;
		
		String sql = " SELECT PWD "
				+ " FROM MEMBER "
				+ " WHERE ID=? AND "
				+ " NAME=? AND "
				+ " BIRTH=? ";
		
		Connection conn = null;			
		PreparedStatement psmt = null;	
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 findpw success");

			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, name);
			psmt.setString(3, birth);
			System.out.println("2/3 findpw success");
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				pwd=rs.getString("pwd");
			}
			System.out.println("3/3 findpw success");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("findpw fail");

		}finally {
			DBClose.close(conn, psmt, rs);
		}
		return pwd;
	}
	
	//관리자뷰 멤버 총 수 --박준희 추가
	public int getAllMember(String choice, String search) {
		
		String sql = " SELECT COUNT(*) FROM MEMBER ";
		
		String sWord = "";
		
		if(choice.equals("id")) {
			sWord = " WHERE ID LIKE '%" + search + "%' ";
		}else if (choice.equals("gender")) {
			sWord = " WHERE GENDER LIKE '%" + search + "%' ";
		}else if(choice.equals("name")) {
			sWord = " WHERE NAME LIKE '%" + search + "%' ";
		}else if(choice.equals("addr")) {
			sWord = " WHERE ADDR LIKE '%" + search + "%' ";
		}else if(choice.equals("auth")) { 
			if(search.equals("관리자")) { 
				search = "3";
				sWord = " WHERE AUTH = " + search + " ";
			}else if(search.equals("회원")) { 
				search = "1"; 
				sWord = " WHERE AUTH = " + search + " ";
			}else if(search.equals("비회원")) { 
				search = "0"; 
				sWord = " WHERE AUTH = " + search + " "; 
			}
		}

		sql = sql + sWord;
		
		Connection conn = null;			
		PreparedStatement psmt = null;	
		ResultSet rs = null;			
		
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllMember success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getAllMember success");
	
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				len = rs.getInt(1);
			}
			System.out.println("3/3 getAllMember success");
			
		} catch (SQLException e) {
			System.out.println("getAllMember fail");
			e.printStackTrace();
			
		} finally {
			DBClose.close(conn, psmt, rs);
		}
	
		return len;
	}
					
	//관리자뷰 멤버전체 보기(검색/페이징) -- 박준희 추가
	public List<MemberDto> getMemberPagingList(String choice, String search, int pageNumber) {
		
		String sql = " SELECT ID, PWD, NAME, BIRTH, GENDER, EMAIL, ADDR, AUTH "
				   + " FROM ";
		
		sql += "(SELECT ROW_NUMBER()OVER(ORDER BY AUTH DESC) AS RNUM, "
				+ "		ID, PWD, NAME, BIRTH, GENDER, EMAIL, ADDR, AUTH "
				+ "	FROM MEMBER ";
		
		String sWord = "";
		
		if(choice.equals("id")) {
			sWord = " WHERE ID LIKE '%" + search + "%' ";
		}else if (choice.equals("gender")) {
			sWord = " WHERE GENDER LIKE '%" + search + "%' ";
		}else if(choice.equals("name")) {
			sWord = " WHERE NAME LIKE '%" + search + "%' ";
		}else if(choice.equals("addr")) {
			sWord = " WHERE ADDR LIKE '%" + search + "%' ";
		}else if(choice.equals("auth")) { 
			if(search.equals("관리자")) { 
				search = "3";
				sWord = " WHERE AUTH = " + search + " ";
			}else if(search.equals("회원")) { 
				search = "1"; 
				sWord = " WHERE AUTH = " + search + " ";
			}else if(search.equals("비회원")) { 
				search = "0"; 
				int i = Integer.parseInt(search);
				sWord = " WHERE AUTH = " + search + " "; 
			}
		}
			
		sql += sWord
				+ " ORDER BY AUTH DESC)  "
				+ " WHERE RNUM >= ? AND RNUM <= ? ";
		
		int start, end;
		start = 1 + 15 * pageNumber;	
		end = 15 + 15 * pageNumber;		
		
		Connection conn = null;			
		PreparedStatement psmt = null;	
		ResultSet rs = null;			
		
		List<MemberDto> list = new ArrayList<MemberDto>();
	
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getMemberPagingList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/4 getMemberPagingList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getMemberPagingList success");
			
			while(rs.next()) {
				int i = 1;
				MemberDto dto = new MemberDto(rs.getString(i++),
										      rs.getString(i++),
										      rs.getString(i++),
										      rs.getString(i++),
										      rs.getString(i++),
										      rs.getString(i++),
										      rs.getString(i++),
										      rs.getInt(i++));
				list.add(dto);
			}
			System.out.println("4/4 getMemberPagingList success");
			
		} catch (SQLException e) {
			System.out.println("getMemberPagingList fail");
			e.printStackTrace();
			
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;		
	}
		
	//멤버 업데이트 -- 박준희 추가
	public boolean updateMember(String id, String pwd, String email, String addr) {
		String sql = " UPDATE MEMBER SET "
				+ " PWD=?, EMAIL=?, ADDR=? "
				+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 updateMember suceess");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, pwd);
			psmt.setString(2, email);
			psmt.setString(3, addr);
			psmt.setString(4, id);
			
			System.out.println("2/3 updateMember suceess");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 updateMember suceess");
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally{
			DBClose.close(conn, psmt, null);			
		}		
		
		return count>0?true:false;
	}
		
	//멤버 삭제 -- 박준희 추가
	public boolean deleteMember(String id) {
		
		String sql = " UPDATE MEMBER SET AUTH = 0 "
					+ " WHERE ID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteMember suceess");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/3 deleteMember suceess");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteMember suceess");
			
		} catch (Exception e) {		
			System.out.println("fail deleteMember");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);			
		}
		
		return count>0?true:false;
	}
	
	//멤버 복구 -- 박준희 추가
	public boolean restoreMember(String id) {
		
		String sql = " UPDATE MEMBER SET AUTH = 1 "
					+ " WHERE ID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteMember suceess");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/3 deleteMember suceess");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteMember suceess");
			
		} catch (Exception e) {		
			System.out.println("fail deleteMember");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);			
		}
		
		return count>0?true:false;
	}
}
