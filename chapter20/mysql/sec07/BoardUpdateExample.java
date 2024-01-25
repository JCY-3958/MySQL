package chapter20.mysql.sec07;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BoardUpdateExample {

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
			
			//Update SQL문장 : StringBulilder 이용
			String sql = new StringBuilder()
					.append("update boards set ")
					.append("btitle=?, ")
					.append("bcontent=?, ")
					.append("bfilename=?, ")
					.append("bfiledata=? ")
					.append("where bno=?")
					.toString();
			
			//PreparedStatement 얻기 미 값 지정
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "눈사람");
			pstmt.setString(2, "눈으로 만든 사람");
			pstmt.setString(3, "snowman.jpg");
			pstmt.setBlob(4, new FileInputStream("src/chapter20/mysql/sec07/snowman.jpg"));
			pstmt.setInt(5, 3); // boards 테이블에 있는 게시물 번호(bno) 지정
			
			//SQL문 실행
			int rows = pstmt.executeUpdate();
			System.out.println("수정된 행 수 : " + rows);
			
			//PreparedStatememt 닫기
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
