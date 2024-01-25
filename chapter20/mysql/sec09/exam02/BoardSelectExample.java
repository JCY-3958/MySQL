package chapter20.mysql.sec09.exam02;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BoardSelectExample {

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
			
			String sql = "" +
			"select bno, btitle, bcontent, bwriter, bdate, bfilename, bfiledata " +
			"from boards " +
			"where bwriter=?";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "winter");
			
			//데이터 읽기
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				//데이터 행을 읽고 Board 객체 생성
				Board board = new Board();
				board.setBno(rs.getInt("bno"));
				board.setBtitle(rs.getString("btitle"));
				board.setBcontent(rs.getString("bcontent"));
				board.setBwriter(rs.getString("bwriter"));
				board.setBdate(rs.getDate("bdate"));
				board.setBfilename(rs.getString("bfilename"));
				board.setBfiledata(rs.getBlob("bfiledata"));
				
				//콘솔에 출력
				System.out.println(board);
				
				//파일로 저장
				Blob blob = board.getBfiledata();
				if(blob != null) {
					InputStream is = blob.getBinaryStream();
					OutputStream os = new FileOutputStream("C:/Temp/"
							+ board.getBfilename());
					is.transferTo(os);
					os.flush();
					os.close();
					is.close();
				}
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
