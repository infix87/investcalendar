package info;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class InfoDAO {
	
	DataSource dataSource;
	
	public InfoDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/InvestCalendar");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int getNext() {
		Connection conn = null;
		ResultSet rs = null;
		String SQL = "SELECT infoID FROM INFO ORDER BY infoID DESC";
		try {
			conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;	//첫 번째 게시물
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}

	public String getDate() {
		Connection conn = null;
		ResultSet rs = null;
		String SQL = "SELECT NOW()";
		try {
			conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	public int write(String infoName, String infoTitle, String infoBody, String infoLink, String infoDate) {
		Connection conn = null;
		String SQL = "INSERT INTO INFO VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, infoName);
			pstmt.setString(3, infoTitle);
			pstmt.setString(4, infoBody);
			pstmt.setString(5, infoLink);
			pstmt.setString(6, getDate());
			pstmt.setString(7, getDate());
			pstmt.setString(8, infoDate);
			pstmt.setInt(9, 1);
			return pstmt.executeUpdate(); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류		
	}
	
	public InfoDTO getInfo(int infoID) {
		Connection conn = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM INFO WHERE INFOID = ?";
		try {
			conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, infoID);
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				InfoDTO info = new InfoDTO();
				info.setInfoID(rs.getInt(1));
				info.setInfoName(rs.getString(2));
				info.setInfoTitle(rs.getString(3));
				info.setInfoBody(rs.getString(4));
				info.setInfoLink(rs.getString(5));
				info.setInfoUploadDate(rs.getString(6));
				info.setInfoUpdateDate(rs.getString(7));
				info.setInfoDate(rs.getString(8));
				info.setInfoAvailable(rs.getInt(9));
				return info;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; //데이터베이스 오류	
	}
	
}
