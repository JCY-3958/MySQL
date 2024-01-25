package chapter20.mysql.sec11;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

import chapter20.mysql.sec11.Board;

public class BoardExample3 {
	//field
	private Scanner scanner = new Scanner(System.in);
	private Connection conn;
	
	//constructor
	public BoardExample3() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			conn = DriverManager.getConnection(
					"jdbc:mysql://192.168.111.200:3306/thisisjava",
					"java",
					"mysql"
					);
			
		} catch(Exception e) {
			e.printStackTrace();
			exit();
		}
	}
	
	//method
	public void list() {
		System.out.println();
		System.out.println("[게시물 목록]");
		System.out.println("-------------------------------------------------------");
		System.out.printf("%-6s%-12s%-16s%-40s\n", "no", "writer", "date", "title");
		System.out.println("-------------------------------------------------------");
		
		//board 테이블에서 게시물 정보를 가져와서 출력하기
		try {
			String sql = "" +
					"select bno, btitle, bcontent, bwriter, bdate " +
					"from boards " +
					"order by bno desc";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				Board board = new Board();
				board.setBno(rs.getInt("bno"));
				board.setBtitle(rs.getString("btitle"));
				board.setBcontent(rs.getString("bcontent"));
				board.setBwriter(rs.getString("bwriter"));
				board.setBdate(rs.getDate("bdate"));
				System.out.printf("%-6s%-12s%-16s%-40s \n",
						board.getBno(),
						board.getBwriter(),
						board.getBdate(),
						board.getBtitle());
			}
			
			rs.close();
			pstmt.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
			exit();
		}
		
		mainMenu();
	}
	
	public void mainMenu() {
		System.out.println();
		System.out.println("-------------------------------------------------------");
		System.out.println("메인 메뉴: 1.Create | 2.Read | 3.Clear | 4.Exit");
		System.out.print("메뉴 선택: ");
		String menuNo = scanner.nextLine();
		System.out.println();
		
		switch(menuNo) {
		case "1" -> create();
		case "2" -> read();
		case "3" -> clear();
		case "4" -> exit();
		}
	}
	
	public void create() {
		System.out.println("*** create() 메서드 실행");
		list();
	}
	
	public void read() {
		System.out.println("*** read() 메서드 실행");
		list();
	}
	
	public void clear() {
		System.out.println("*** clear() 메서드 실행");
		list();
	}
	
	public void exit() {
		System.exit(0);
	}
	
	public static void main(String[] args) {
		BoardExample3 boardExample = new BoardExample3();
		boardExample.list();
	}
}
