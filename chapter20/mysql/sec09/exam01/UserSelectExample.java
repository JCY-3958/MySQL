package chapter20.mysql.sec09.exam01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class UserSelectExample {

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
			"select userid, username, userpassword, userage, useremail " +
			"from users " +
			"where userid=?";
			
			//PreparedStatement 얻기 및 값 지정
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "winter");
			
			//SQL문 실행 후 ResultSet을 통해 데이터 읽기
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) { //결과 값이 1개인 경우(true)
				User user = new User();
				//user.setUserid(rs.getString("userid"));
				//user.setUsername(rs.getString("username"));
				//user.setUserpassword(rs.getString("userpassword"));
				
				user.setUserid(rs.getString(1));
				user.setUsername(rs.getString(2));
				user.setUserpassword(rs.getString(3));
				
				user.setUserage(rs.getInt(4)); //칼럼 순번을 이용
				user.setUseremail(rs.getString(5)); //칼럼 순번을 이용
				System.out.println(user);
			} else { //데이터 행을 가져오지 않았을 경우
				System.out.println("사용자 아이디가 존재하지 않음");
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally { //try, catch 구문이 끝나면 finally 구문 실행
			if(conn != null) {
				try {
					//연결 끊기
					conn.close();
				} catch (SQLException e) {}
			}
		}
	}

}
