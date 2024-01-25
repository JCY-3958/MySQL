package chapter20.mysql.sec06;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class BoardInsertExample {

	public static void main(String[] args) {
		Connection conn = null;
		try {
			//JDBC Driver 등록
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			//연결하기
			conn = DriverManager.getConnection(
					"jdbc:mysql://192.168.111.200:3306/thisisjava",
					"java", //사용자 id
					"mysql" //비밀번호
					);
			
			//매개변수화된 SQL문 작성
			String sql = "" + 
			"insert into boards (btitle, bcontent, bwriter, bdate, bfilename, bfiledata)" +
					"values(?, ?, ?, now(), ?, ?)";
			
			//PreparedStatement 얻기 및 값 지정
			PreparedStatement pstmt = conn.prepareStatement(sql,
					Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, "눈 오는 날");
			pstmt.setString(2, "함박눈이 내려요.");
			pstmt.setString(3, "winter");
			pstmt.setString(4, "snow.jpg");
			pstmt.setBlob(5, new FileInputStream("src/chapter20/mysql/sec06/snow.jpg"));
			
			//SQL문 실행
			int rows = pstmt.executeUpdate();
			System.out.println("저장된 행 수 : " + rows);
			
			//bno 값 얻기
			if(rows == 1) {
				ResultSet rs = pstmt.getGeneratedKeys();
				if(rs.next()) {
					int bno = rs.getInt(1); //rs 첫 번째가 bno 필드
					System.out.println("저장된 bno : " + bno);
				}
				rs.close();
			}
			
			//PreparedStatement 닫기
			pstmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}  finally { //try, catch 구문이 끝나면 finally 구문 실행
			if(conn != null) {
				try {
					//연결 끊기
					conn.close();
				} catch (SQLException e) {}
			}
		}

	}

}
