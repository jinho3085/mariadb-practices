package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionEx {

	public static void main(String[] args) {
		Connection con = null;
		
		try {
			// 1. JDBC Driver 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			
			// 2. 연결하기
			String url  = "jdbc:mariadb://192.168.0.178:3306/webdb";
			con =  DriverManager.getConnection (url, "webdb", "webdb");
			
			System.out.println("연결성공");
		} catch (ClassNotFoundException e) {
			System.out.println("Driver Class Not Found");
		} catch (SQLException e) {
			 System.out.println("error:" + e);
		} finally {
			try {
				if(con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}

}