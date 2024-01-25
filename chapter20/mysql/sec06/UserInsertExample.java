package chapter20.mysql.sec06;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserInsertExample {

	public static void main(String[] args) {
		Connection conn = null;
		try {
			//JDBC Driver 등록
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			//연결하기
			conn = DriverManager.getConnection(
					"jdbc:mysql://192.168.111.200:3306/thisisjava", //접속 서버 정보
					"java", //사용자 id
					"mysql" //비밀번호
					);
			
			//매개변수화된 SQL문 작성
			String sql = "" + 
					"insert into users (userid, username, userpassword, userage, useremail)" +
					"values (?,?,?,?,?)";
			
			//PreparedStatement 얻기 및 값 기정
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "winter");
			pstmt.setString(2, "한겨울");
			pstmt.setString(3, "12345");
			pstmt.setInt(4, 25);
			pstmt.setString(5, "winter@mycompany.com");
			
			//SQL문 실행
			int rows = pstmt.executeUpdate();
			System.out.println("저장된 행 수 : " + rows);
			
			//PreparedStatement 닫기
			pstmt.close();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { //try, catch 구문이 끝나면 finally 구문 실행
			if(conn != null) {
				try {
					//연결 끊기
					conn.close();
					//System.out.println("연결 끊기");
				} catch (SQLException e) {}
			}
		}
	}

}
