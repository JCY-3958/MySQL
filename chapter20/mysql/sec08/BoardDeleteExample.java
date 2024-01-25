package chapter20.mysql.sec08;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BoardDeleteExample {

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
			String sql = "delete from boards where bwriter=?";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "winter");
			
			int rows = pstmt.executeUpdate();
			System.out.println("삭제된 행 수 : " + rows);
						
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
